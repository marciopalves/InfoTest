unit uEnviarEmail;

interface

Uses IdSSLOpenSSL, IdSMTP, IdMessage, IdText, IdAttachmentFile,
     IdExplicitTLSClientServerBase;

type
  TDestinatario = record
    nome: String;
    email: String;
  end;

type
  TEnviarEmail = class
    private
      FIdSSLIOHandlerSocket: TIdSSLIOHandlerSocketOpenSSL;
      FTIdSMTP: TIdSMTP;
      FIdMessage: TIdMessage;
      FIdText: TIdText;

      procedure SetConfugaracao;

    public
      property IdSSLIOHandlerSocket: TIdSSLIOHandlerSocketOpenSSL
                        read FIdSSLIOHandlerSocket write FIdSSLIOHandlerSocket;
      property IdSMTP : TIdSMTP read FTIdSMTP write FTIdSMTP;
      property IdMessage: TIdMessage read FIdMessage write FIdMessage;
      property IdText : TIdText read FIdText write FIdText;

      Constructor Create();
      function EnviarEmail(const pAssunto: String; const pAnexo:String;
                           const pDestinatario: TDestinatario):Boolean;
  end;

implementation

Uses SysUtils, Vcl.Dialogs;

{ TEnviarEmail }


Const
  EMAIL_REMETENTE = '';
  SENHA_REMETENTE = '';
  NOME_REMETENTE  = '';

  MSG_BODY_EMAIL = 'Olá, Cadastro realizado com sucesso!'+
                   sLineBreak+sLineBreak+'Segue em anexo arquivo.json';

constructor TEnviarEmail.Create;
begin
  IdSSLIOHandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  IdSMTP := TIdSMTP.Create(nil);
  IdMessage := TIdMessage.Create(nil);
  SetConfugaracao;
end;

procedure TEnviarEmail.SetConfugaracao;
begin
  //Configuração do protocolo SSL (TIdSSLIOHandlerSocketOpenSSL)
  IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
  IdSSLIOHandlerSocket.SSLOptions.Mode := sslmClient;

  //Configuração do servidor SMTP (TIdSMTP)
  IdSMTP.IOHandler := IdSSLIOHandlerSocket;
  IdSMTP.UseTLS := utUseImplicitTLS;
  IdSMTP.AuthType := satDefault;
  IdSMTP.Port := 465;
  IdSMTP.Host := 'smtp.gmail.com';
  IdSMTP.Username := EMAIL_REMETENTE;
  IdSMTP.Password := SENHA_REMETENTE;
end;

function TEnviarEmail.EnviarEmail(const pAssunto: String; const pAnexo:String;
                                  const pDestinatario: TDestinatario):Boolean;
begin
  try
    //Configuração da mensagem (TIdMessage)
    IdMessage.From.Address := EMAIL_REMETENTE;
    IdMessage.From.Name := NOME_REMETENTE;
    IdMessage.ReplyTo.EMailAddresses := IdMessage.From.Address;
    IdMessage.Recipients.Add.Text := pDestinatario.email;
    IdMessage.Subject := pAssunto;
    IdMessage.Encoding := meMIME;

    //Configuração do corpo do email (TIdText)
    IdText := TIdText.Create(IdMessage.MessageParts);
    IdText.Body.Add('Segue em anexo arquivo json do registro novo!');
    IdText.ContentType := 'text/plain; charset=iso-8859-1';

    //Opcional - Anexo da mensagem (TIdAttachmentFile)
    if FileExists(pAnexo) then
    begin
      TIdAttachmentFile.Create(IdMessage.MessageParts, pAnexo);
    end;

    //Conexão e autenticação
    try
      IdSMTP.Connect;
      IdSMTP.Authenticate;
    except on
      E:Exception do
      begin
        MessageDlg('Erro na conexão ou autenticação: ' +
        E.Message, mtWarning, [mbOK], 0);
        Exit;
      end;
    end;

    //Envio da mensagem
    try
      IdSMTP.Send(IdMessage);
      MessageDlg('Email enviado com sucesso!', mtInformation, [mbOK], 0);
    except
    On E:Exception do
      begin
        MessageDlg('Erro ao enviar a Email: ' +
        E.Message, mtWarning, [mbOK], 0);
      end;
    end;

  finally
    //desconecta do servidor
    IdSMTP.Disconnect;
    // liberação da DLL
    UnLoadOpenSSLLibrary;
    // liberação dos objetos da memória
    IdMessage.Free;
    IdSSLIOHandlerSocket.Free;
    IdSMTP.Free;
  end;
end;

end.

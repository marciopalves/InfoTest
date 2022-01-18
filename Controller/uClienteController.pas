unit uClienteController;

interface

uses
  uClienteModel, uICliente;

  type TClienteController = class(TInterfacedObject, ICliente)
  private

  public

    function Validarcpf( const pCpf: String):boolean;

    function ValidarEmail(pEmail: String):Boolean;

    procedure Salvar(pCliente: TClienteModel);


  end;
implementation

Uses System.SysUtils, dbxJson, REST.JsonReflect, System.Classes, uEnviarEmail;

{ uClienteController }

procedure TClienteController.Salvar(pCliente: TClienteModel);
Var
  vMarshal: TJSONMarshal;
  vTextoJson: String;
  vPasta: String;
  vArquivo: TStringList;
  vEnviarEmail : TEnviarEmail;
  vDestinatario: TDestinatario;
begin
  vMarshal   := TJSONMarshal.Create (TJSONConverter.Create);
  try
    vTextoJson :=  vMarshal.Marshal(pCliente).ToString();
    vPasta := ExtractFileDir(GetCurrentDir)+'/json';

    if Not DirectoryExists(vPasta) then
      ForceDirectories(vPasta);

    if Trim(vTextoJson)<> EmptyStr then
    begin
      vArquivo := TStringList.Create;
      vArquivo.Add(vTextoJson);
      vArquivo.SaveToFile(vPasta+'\'+pCliente.Nome+'.json');

      vDestinatario.nome  := pCliente.Nome;
      vDestinatario.email := pCliente.Email;

      vEnviarEmail := TEnviarEmail.Create;
      vEnviarEmail.EnviarEmail('Cadastro:'+pCliente.Nome,
                               vPasta+'\'+pCliente.Nome+'.json',
                               vDestinatario
                               );
      ////Enviar Email
    end;

  finally
    vArquivo.Free;
  end;

end;

function TClienteController.ValidarEmail(pEmail: String): Boolean;
begin
  if Pos('@', pEmail)> 1 then
  begin
    Delete(pEmail, 1, pos('@', pEmail));
    Result := (Length(pEmail) > 0) and (Pos('.', pEmail) > 2);
  end
  else Result := False;
end;

function TClienteController.Validarcpf(const pCpf: String): boolean;
var
  dig10, dig11: string;
  s, i, r, peso: integer;
begin
// length - retorna o tamanho da string (CPF é um número formado por 11 dígitos)
  if ((pCpf = '00000000000') or (pCpf = '11111111111') or
      (pCpf = '22222222222') or (pCpf = '33333333333') or
      (pCpf = '44444444444') or (pCpf = '55555555555') or
      (pCpf = '66666666666') or (pCpf = '77777777777') or
      (pCpf = '88888888888') or (pCpf = '99999999999') or
      (length(pCpf) <> 11)) then
  begin
    result := false;
    exit;
  end;

// try - protege o código para eventuais erros de conversão de tipo na função StrToInt
  try
{ *-- Cálculo do 1o. Digito Verificador --* }
    s := 0;
    peso := 10;
    for i := 1 to 9 do
    begin
// StrToInt converte o i-ésimo caractere do CPF em um número
      s := s + (StrToInt(pCPF[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11))
       then dig10 := '0'
    else str(r:1, dig10); // converte um número no respectivo caractere numérico

{ *-- Cálculo do 2o. Digito Verificador --* }
    s := 0;
    peso := 11;
    for i := 1 to 10 do
    begin
      s := s + (StrToInt(pCPF[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11))
       then dig11 := '0'
    else str(r:1, dig11);

{ Verifica se os digitos calculados conferem com os digitos informados. }
    if ((dig10 = pCPF[10]) and (dig11 = pCpf[11])) then
      result := true
    else result := false;
  except
    result := false
  end;
end;

end.

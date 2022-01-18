unit uClienteView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.Mask,
  uICliente;

type
  TfrmCadClientes = class(TForm)
    Panel1: TPanel;
    pgCadCliente: TPageControl;
    pnlBotoes: TPanel;
    tsDados: TTabSheet;
    tsEndereco: TTabSheet;
    edtCep: TEdit;
    Label1: TLabel;
    edtLogradouro: TEdit;
    Label2: TLabel;
    edtNumero: TEdit;
    Label3: TLabel;
    edtComplemento: TEdit;
    Label4: TLabel;
    edtBairro: TEdit;
    Label5: TLabel;
    edtCidade: TEdit;
    Label6: TLabel;
    edtEstado: TEdit;
    Label7: TLabel;
    edtPais: TEdit;
    Label8: TLabel;
    btnPesqCep: TBitBtn;
    edtNome: TEdit;
    Label9: TLabel;
    edtCpf: TEdit;
    Label10: TLabel;
    edtIdentidade: TEdit;
    Label11: TLabel;
    edtEmail: TEdit;
    Label12: TLabel;
    mkEdtTelefone: TMaskEdit;
    btnCancelar: TButton;
    btnGravar: TButton;
    Label13: TLabel;
    procedure edtNumeroKeyPress(Sender: TObject; var Key: Char);
    procedure edtCepExit(Sender: TObject);
    procedure btnPesqCepClick(Sender: TObject);
    procedure edtCpfExit(Sender: TObject);
    procedure edtIdentidadeKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtEmailExit(Sender: TObject);
  private
    { Private declarations }
    procedure LimparCampos;
    procedure ValidarCampos;
  public
    { Public declarations }
  end;

var
  frmCadClientes: TfrmCadClientes;
  Controller : ICliente;
implementation

Uses uViaCepModel, uIViaCEP, uViaCEPContoller, uClienteController,
     uClienteModel, uEnviarEmail;

{$R *.dfm}

procedure TfrmCadClientes.btnCancelarClick(Sender: TObject);
begin
  LimparCampos;
end;

procedure TfrmCadClientes.btnGravarClick(Sender: TObject);
Var
  vModel : TClienteModel;
  vEndereco : TEnderecoModel;
begin
  ValidarCampos;

  vModel    := TClienteModel.Create;
  vEndereco := TEnderecoModel.Create;
  try
    vModel.Nome       := edtNome.Text;
    vModel.CpfCnpj    := edtCpf.Text;
    vModel.Identidade := edtIdentidade.Text;
    vModel.Telefone   := mkEdtTelefone.Text;
    vModel.Email      := edtEmail.Text;

    vEndereco.Cep         := edtCep.Text;
    vEndereco.Logradouro  := edtLogradouro.Text;
    vEndereco.Numero      := edtNumero.Text;
    vEndereco.Complemento := edtComplemento.Text;
    vEndereco.Bairro      := edtBairro.text;
    vEndereco.Cidade      := edtCidade.text;
    vEndereco.Estado      := edtEstado.Text;
    vEndereco.Pais        := edtPais.Text;

    vModel.Endereco := vEndereco;
    controller.Salvar(vModel);
    ShowMessage('Registro Salvo com sucesso!');
  finally
    vModel.Free;
    vEndereco.Free;
    LimparCampos;
  end;

end;

procedure TfrmCadClientes.btnPesqCepClick(Sender: TObject);
var
  ViaCEP: IViaCEP;
  CEP: TViaCEPModel;
begin
  ViaCEP := TViaCEP.Create;
  CEP := ViaCEP.Get(edtCEP.Text);
  if not Assigned(CEP) then
    Exit;
  try
    edtCEP.Text := CEP.CEP;
    edtLogradouro.Text  := CEP.Logradouro;
    edtComplemento.Text := CEP.Complemento;
    edtBairro.Text      := CEP.Bairro;
    edtCidade.Text      := CEP.Localidade;
    edtEstado.Text      := CEP.UF;
  finally
    CEP.Free;
    edtNumero.SetFocus;
  end;
end;

procedure TfrmCadClientes.edtCepExit(Sender: TObject);
var
  ViaCEP: IViaCEP;
begin
  ViaCEP := TViaCEP.Create;
  try
    if Not ViaCEP.Validate(edtCEP.Text) then
    begin
      ShowMessage('CEP inválido favor verificar!');
      edtCep.SetFocus;
    end;
  except on e:exception do
    raise Exception.Create('Erro ao validar CEP -'+e.ToString);
  end;
end;

procedure TfrmCadClientes.edtCpfExit(Sender: TObject);
begin
  try
    if Not Controller.ValidarCpf(edtCpf.Text) then
    begin
      ShowMessage('Cpf inválido favor verificar!');
      edtCpf.SetFocus;
    end;
  except on E:exception do
    raise Exception.Create('Erro ao validar cpf-'+e.ToString);
  end;
end;

procedure TfrmCadClientes.edtEmailExit(Sender: TObject);
begin
  try
    if Not Controller.ValidarEmail(edtEmail.Text) then
    begin
      ShowMessage('Email inválido favor verificar');
      edtemail.SetFocus;
    end;
  Except on e:exception do
    raise Exception.Create('Erro ao Validar email-'+e.ToString);
  end;

end;

procedure TfrmCadClientes.edtIdentidadeKeyPress(Sender: TObject; var Key: Char);
begin
  if Not (key in ['0'..'9', #08]) then
    key := #0;
end;

procedure TfrmCadClientes.edtNumeroKeyPress(Sender: TObject; var Key: Char);
begin
   if Not (key in ['0'..'9', #08]) then
    key := #0;
end;

procedure TfrmCadClientes.FormCreate(Sender: TObject);
begin
  Controller := TClienteController.Create;
end;

procedure TfrmCadClientes.LimparCampos;
Var
  vCont:Integer;
begin
  for vCont := 0 to frmCadClientes.ComponentCount -1 do
  begin
    if frmCadClientes.Components[vCont] is TEdit then
      TEdit(frmCadClientes.Components[vCont]).clear;
  end;

end;

procedure TfrmCadClientes.ValidarCampos;
Const
  MSG = 'Favor informar %s para prosseguir com cadastro!';
begin
  if Trim(edtNome.Text) = EmptyStr then
  begin
    edtNome.SetFocus;
    raise Exception.CreateFmt(MSG, ['nome']);
  end;

  if Trim(edtEmail.Text) = EmptyStr then
  begin
    edtEmail.SetFocus;
    raise Exception.CreateFmt(MSG, ['email']);
  end;

end;

end.

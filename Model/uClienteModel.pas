unit uClienteModel;

interface

uses
  uEnumerado;

type TEnderecoModel = class
  private
    FCep: String;
    FNumero: String;
    FLogradouro: String;
    FBairro: String;
    FComplemento: String;
    FCidade: String;
    FPais: String;
    FEstado: String;

  public
    property Cep: String read FCep write FCep;
    property Logradouro: String read FLogradouro write FLogradouro;
    property Numero: String read FNumero write FNumero;
    property Complemento: String read FComplemento write FComplemento;
    property Bairro: String read FBairro write FBairro;
    property Cidade: String read FCidade write FCidade;
    property Estado: String read FEstado write FEstado;
    property Pais: String read FPais write FPais;

end;

type
  TClienteModel = class
  private
    FAcao: TAcao;
    FNome: string;
    FCpfCnpj: string;
    FEmail: String;
    FIdentidade: String;
    FEndereco: TEnderecoModel;
    FTelefone: String;

  public
    property Nome: string read FNome write FNome;
    property Acao: TAcao read FAcao write FAcao;
    property CpfCnpj : string read FCpfCnpj write FCpfCnpj;
    property Identidade: String read FIdentidade write FIdentidade;
    property Telefone: String read FTelefone write FTelefone;
    property Email: String read FEmail write FEmail;
    property Endereco: TEnderecoModel read FEndereco write FEndereco;

    constructor Create;

    destructor Destroy; override;

  end;

implementation

{ TClienteModel }

constructor TClienteModel.Create;
begin
  Endereco := TEnderecoModel.Create;
end;

destructor TClienteModel.Destroy;
begin
  FEndereco.Free;
  inherited;
end;

end.

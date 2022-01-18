unit uICliente;

interface

uses uClienteModel;

type
  ICliente = Interface
    ['{22C8B9CE-8BF6-4A6B-9AC6-81CB7F8902D8}']

    function Validarcpf(const pCpf: String):boolean;

    function ValidarEmail(pEmail: String):boolean;

    procedure Salvar(pCliente: TClienteModel);

end;

implementation

end.

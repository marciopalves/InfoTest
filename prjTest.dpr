program prjTest;

uses
  Vcl.Forms,
  untPrincipal in 'untPrincipal.pas' {Form1},
  uClienteModel in 'Model\uClienteModel.pas',
  uClienteView in 'View\uClienteView.pas' {frmCadClientes},
  uViaCEPModel in 'Model\uViaCEPModel.pas',
  uIViaCEP in 'Controller\uIViaCEP.pas',
  uViaCEPContoller in 'Controller\uViaCEPContoller.pas',
  uEnumerado in 'Model\uEnumerado.pas',
  uICliente in 'Controller\uICliente.pas',
  uClienteController in 'Controller\uClienteController.pas',
  uEnviarEmail in 'Controller\uEnviarEmail.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmCadClientes, frmCadClientes);
  Application.Run;
end.

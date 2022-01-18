object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Projeto Test Info'
  ClientHeight = 304
  ClientWidth = 592
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 312
    Top = 80
    object Cadastros1: TMenuItem
      Caption = '&Cadastros'
      object Clientes1: TMenuItem
        Caption = 'C&lientes'
        OnClick = Clientes1Click
      end
    end
  end
end

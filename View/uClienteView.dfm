object frmCadClientes: TfrmCadClientes
  Left = 0
  Top = 0
  Caption = 'frmCadClientes'
  ClientHeight = 309
  ClientWidth = 570
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 570
    Height = 41
    Align = alTop
    Caption = 'Cadastro de clientes'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 0
  end
  object pgCadCliente: TPageControl
    Left = 0
    Top = 41
    Width = 570
    Height = 215
    ActivePage = tsDados
    Align = alClient
    TabOrder = 1
    object tsDados: TTabSheet
      Caption = 'Dados Pessoais'
      object Label9: TLabel
        Left = 18
        Top = 8
        Width = 27
        Height = 13
        Caption = 'Nome'
      end
      object Label10: TLabel
        Left = 243
        Top = 8
        Width = 17
        Height = 13
        Caption = 'Cpf'
      end
      object Label11: TLabel
        Left = 371
        Top = 8
        Width = 52
        Height = 13
        Caption = 'Identidade'
      end
      object Label12: TLabel
        Left = 18
        Top = 57
        Width = 24
        Height = 13
        Caption = 'Email'
      end
      object Label13: TLabel
        Left = 368
        Top = 57
        Width = 42
        Height = 13
        Caption = 'Telefone'
      end
      object edtNome: TEdit
        Left = 16
        Top = 26
        Width = 217
        Height = 21
        TabOrder = 0
      end
      object edtCpf: TEdit
        Left = 241
        Top = 26
        Width = 120
        Height = 21
        TabOrder = 1
        OnExit = edtCpfExit
      end
      object edtIdentidade: TEdit
        Left = 369
        Top = 26
        Width = 120
        Height = 21
        TabOrder = 2
        OnKeyPress = edtIdentidadeKeyPress
      end
      object edtEmail: TEdit
        Left = 16
        Top = 74
        Width = 337
        Height = 21
        TabOrder = 3
        OnExit = edtEmailExit
      end
      object mkEdtTelefone: TMaskEdit
        Left = 368
        Top = 74
        Width = 119
        Height = 21
        EditMask = '!\(999\)0000-0000;1;_'
        MaxLength = 14
        TabOrder = 4
        Text = '(   )    -    '
      end
    end
    object tsEndereco: TTabSheet
      Caption = 'Endere'#231'o'
      ImageIndex = 1
      object Label1: TLabel
        Left = 17
        Top = 16
        Width = 19
        Height = 13
        Caption = 'Cep'
      end
      object Label2: TLabel
        Left = 136
        Top = 16
        Width = 55
        Height = 13
        Caption = 'Logradouro'
      end
      object Label3: TLabel
        Left = 397
        Top = 16
        Width = 12
        Height = 13
        Caption = 'N'#186
      end
      object Label4: TLabel
        Left = 17
        Top = 60
        Width = 65
        Height = 13
        Caption = 'Complemento'
      end
      object Label5: TLabel
        Left = 289
        Top = 60
        Width = 28
        Height = 13
        Caption = 'Bairro'
      end
      object Label6: TLabel
        Left = 17
        Top = 99
        Width = 33
        Height = 13
        Caption = 'Cidade'
      end
      object Label7: TLabel
        Left = 204
        Top = 99
        Width = 33
        Height = 13
        Caption = 'Estado'
      end
      object Label8: TLabel
        Left = 332
        Top = 99
        Width = 19
        Height = 13
        Caption = 'Pais'
      end
      object edtCep: TEdit
        Left = 16
        Top = 32
        Width = 81
        Height = 21
        TabOrder = 0
        OnExit = edtCepExit
      end
      object edtLogradouro: TEdit
        Left = 132
        Top = 32
        Width = 255
        Height = 21
        TabOrder = 1
      end
      object edtNumero: TEdit
        Left = 392
        Top = 32
        Width = 54
        Height = 21
        TabOrder = 2
        OnKeyPress = edtNumeroKeyPress
      end
      object edtComplemento: TEdit
        Left = 16
        Top = 76
        Width = 266
        Height = 21
        TabOrder = 3
      end
      object edtBairro: TEdit
        Left = 288
        Top = 76
        Width = 158
        Height = 21
        TabOrder = 4
      end
      object edtCidade: TEdit
        Left = 17
        Top = 116
        Width = 176
        Height = 21
        TabOrder = 5
      end
      object edtEstado: TEdit
        Left = 201
        Top = 116
        Width = 121
        Height = 21
        TabOrder = 6
      end
      object edtPais: TEdit
        Left = 328
        Top = 116
        Width = 118
        Height = 21
        TabOrder = 7
      end
      object btnPesqCep: TBitBtn
        Left = 100
        Top = 30
        Width = 29
        Height = 25
        Caption = 'Pesq'
        Default = True
        TabOrder = 8
        OnClick = btnPesqCepClick
      end
    end
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 256
    Width = 570
    Height = 53
    Align = alBottom
    TabOrder = 2
    object btnCancelar: TButton
      Left = 216
      Top = 15
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 0
      OnClick = btnCancelarClick
    end
    object btnGravar: TButton
      Left = 320
      Top = 15
      Width = 75
      Height = 25
      Caption = 'Gravar'
      TabOrder = 1
      OnClick = btnGravarClick
    end
  end
end

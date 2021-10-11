object Form_LockDisk: TForm_LockDisk
  Left = 224
  Top = 126
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'LockDisk [Autoriser un CD/DVD] - (gndouabs@hotmail.de)'
  ClientHeight = 515
  ClientWidth = 721
  Color = clBtnFace
  TransparentColorValue = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  Icon.Data = {
    0000010001002020040000000000E80200001600000028000000200000004000
    0000010004000000000000020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000087777777777777777777777770666000F88
    88888888888888888888088066000F8888888888888888888880608800700F88
    88888888888888888806660888700F8888888888888888888066666088700F88
    88888888888888880666660888700F8888888888888888880666608888700F88
    88888888888888880666608888700F8888888888888888880666088888700F88
    88888888888888888000888880000F8888888888888888888888888806600F88
    88888888888800088888888806600F8888888888888066608888880880600F88
    88888888888066608888806088000F8888888888808806608880066608700F88
    88888888060880088806666660700F8888888880666088888066666608700F88
    88888806666608888066666088700F8888888066666088888066660888700F88
    88888066660888888800008888700F8888888066660888888888888888700F88
    88888066608888888888888888700F8888888800088888008888888888700F88
    00088888888806660888888888700F8066608888888806660888888888700F80
    6660888888088066088888888870008806608888806088008888888888700608
    8008888006660888888888888870066088888806666660888888888888700666
    0FFFF06666660FFFFFFFFFFFFF80000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  Menu = MMenu
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnHide = NDTrayIcon1Minimize
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 17
  object Bloc_Infos: TGroupBox
    Left = 9
    Top = 5
    Width = 421
    Height = 153
    Caption = ' Informations du Lecteur CD '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object SerialNumber: TLabel
      Left = 12
      Top = 65
      Width = 104
      Height = 18
      Caption = 'SerialNumber'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Hachage: TLabel
      Left = 12
      Top = 115
      Width = 64
      Height = 18
      Caption = 'Hachage'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object TotalSpace: TLabel
      Left = 13
      Top = 89
      Width = 83
      Height = 18
      Caption = 'TotalSpace'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object SelectDrive: TComboBox
      Left = 12
      Top = 29
      Width = 387
      Height = 29
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ItemHeight = 21
      ParentFont = False
      TabOrder = 0
      OnChange = SelectDriveChange
    end
  end
  object Bloc_liste: TGroupBox
    Left = 10
    Top = 161
    Width = 708
    Height = 345
    Caption = ' Liste de tous les CD/DVD autorises '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Liste_Autorisee: TValueListEditor
      Left = 5
      Top = 25
      Width = 692
      Height = 310
      DisplayOptions = [doColumnTitles, doKeyColFixed]
      DropDownRows = 0
      FixedColor = clMoneyGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      GridLineWidth = 2
      KeyOptions = [keyUnique]
      Options = [goFixedVertLine, goFixedHorzLine, goRowSelect, goThumbTracking]
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
      TitleCaptions.Strings = (
        'Hachage du CD/DVD'
        'Titre du CD/DVD')
      OnClick = Liste_AutoriseeClick
      ColWidths = (
        234
        312)
    end
  end
  object Bloc_Autorisation: TGroupBox
    Left = 432
    Top = 5
    Width = 143
    Height = 153
    Caption = ' Autorisation '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object Btn_Enlever: TSpeedButton
      Left = 18
      Top = 86
      Width = 105
      Height = 40
      AllowAllUp = True
      Caption = 'Enlever'
      Enabled = False
      OnClick = Btn_EnleverClick
    end
    object Btn_Autoriser: TSpeedButton
      Left = 18
      Top = 41
      Width = 105
      Height = 43
      AllowAllUp = True
      Caption = 'Autoriser'
      OnClick = Btn_AutoriserClick
    end
  end
  object Bloc_Surveillance: TGroupBox
    Left = 577
    Top = 5
    Width = 141
    Height = 153
    Caption = ' Surveillance '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object Btn_Desactiver: TSpeedButton
      Left = 16
      Top = 86
      Width = 104
      Height = 40
      Caption = 'Desactiver'
      OnClick = Btn_DesactiverClick
    end
    object Btn_Activer: TSpeedButton
      Left = 16
      Top = 41
      Width = 104
      Height = 43
      Caption = 'Activer'
      Enabled = False
      OnClick = Btn_ActiverClick
    end
  end
  object Rafraichisseur: TTimer
    Enabled = False
    OnTimer = RafraichisseurTimer
    Left = 224
    Top = 72
  end
  object PMenu: TPopupMenu
    Left = 191
    Top = 72
    object PM1: TMenuItem
      Caption = 'Cacher'
      OnClick = PM1Click
    end
    object PM2: TMenuItem
      Caption = 'Lancer au demmarrage de Windows'
      OnClick = MM1_1Click
    end
    object PM3: TMenuItem
      Caption = 'Reduire au demarrage'
      OnClick = MM1_2Click
    end
    object PM4: TMenuItem
      Caption = 'Changer mot de passe'
      OnClick = MM1_3Click
    end
    object PM5: TMenuItem
      Caption = 'Quitter'
      OnClick = PM5Click
    end
  end
  object MMenu: TMainMenu
    Left = 159
    Top = 72
    object MM1: TMenuItem
      Caption = 'File'
      object MM1_1: TMenuItem
        Caption = 'Lancer au demmarrage de Windows'
        OnClick = MM1_1Click
      end
      object MM1_2: TMenuItem
        Caption = 'Reduire au demarrage'
        OnClick = MM1_2Click
      end
      object MM1_3: TMenuItem
        Caption = 'Changer mot de passe'
        OnClick = MM1_3Click
      end
      object MM1_4: TMenuItem
        Caption = 'Exit'
        OnClick = MM1_4Click
      end
    end
  end
  object Locker: TTimer
    Interval = 100
    OnTimer = LockerTimer
    Left = 256
    Top = 72
  end
end

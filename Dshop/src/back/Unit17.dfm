object Fr_GJTH: TFr_GJTH
  Left = 289
  Top = 39
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #36141#36827#36864#22238
  ClientHeight = 741
  ClientWidth = 945
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 945
    Height = 741
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 1
    TabOrder = 0
    object Panel2: TPanel
      Left = 3
      Top = 3
      Width = 939
      Height = 735
      Align = alClient
      Color = 15723503
      TabOrder = 0
      object Label9: TLabel
        Left = 401
        Top = 32
        Width = 210
        Height = 29
        Caption = #36141#12288#36827#12288#36864#12288#22238
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -29
        Font.Name = #26999#20307'_GB2312'
        Font.Style = []
        ParentFont = False
      end
      object Panel5: TPanel
        Left = 56
        Top = 671
        Width = 880
        Height = 40
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 0
        object Button1: TButton
          Left = 158
          Top = 7
          Width = 75
          Height = 25
          BiDiMode = bdLeftToRight
          Caption = #36864#12288#36135
          ParentBiDiMode = False
          TabOrder = 0
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 615
          Top = 7
          Width = 75
          Height = 25
          Caption = #36820#12288#22238
          TabOrder = 1
          OnClick = Button2Click
        end
      end
      object Panel4: TPanel
        Left = 56
        Top = 577
        Width = 880
        Height = 93
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 1
        object Label1: TLabel
          Left = 12
          Top = 13
          Width = 54
          Height = 12
          Caption = #37319#36141#21333#21495':'
        end
        object Label2: TLabel
          Left = 260
          Top = 13
          Width = 54
          Height = 12
          Caption = #36864#22238#25968#37327':'
        end
        object Label3: TLabel
          Left = 12
          Top = 45
          Width = 54
          Height = 12
          Caption = #21830#21697#26465#30721':'
        end
        object Label4: TLabel
          Left = 260
          Top = 45
          Width = 54
          Height = 12
          Caption = #21830#21697#21517#31216':'
        end
        object Label5: TLabel
          Left = 580
          Top = 45
          Width = 54
          Height = 12
          Caption = #20379' '#24212' '#21830':'
        end
        object Label6: TLabel
          Left = 12
          Top = 69
          Width = 54
          Height = 12
          Caption = #35745#37327#21333#20301':'
        end
        object Label7: TLabel
          Left = 580
          Top = 69
          Width = 54
          Height = 12
          Caption = #36827#36135#21333#20215':'
        end
        object Label8: TLabel
          Left = 260
          Top = 69
          Width = 54
          Height = 12
          Caption = #36827#36135#25968#37327':'
        end
        object Bevel1: TBevel
          Left = 3
          Top = 33
          Width = 870
          Height = 3
          Style = bsRaised
        end
        object SpeedButton1: TSpeedButton
          Left = 242
          Top = 10
          Width = 13
          Height = 18
          Caption = '...'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          OnClick = SpeedButton1Click
        end
        object RzEdit1: TRzEdit
          Left = 66
          Top = 10
          Width = 175
          Height = 18
          AutoSize = False
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
          MaxLength = 11
          TabOrder = 0
          OnKeyPress = RzEdit1KeyPress
        end
        object RzEdit2: TRzEdit
          Left = 314
          Top = 10
          Width = 95
          Height = 18
          AutoSize = False
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
          MaxLength = 10
          TabOrder = 1
          OnKeyPress = RzEdit2KeyPress
        end
        object RzEdit3: TRzEdit
          Left = 66
          Top = 42
          Width = 183
          Height = 18
          AutoSize = False
          BiDiMode = bdLeftToRight
          Color = clInfoBk
          Ctl3D = True
          DisabledColor = clWhite
          FocusColor = clWhite
          FrameColor = clGray
          FrameHotColor = 14593668
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
          MaxLength = 4
          ParentBiDiMode = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 2
        end
        object RzEdit4: TRzEdit
          Left = 314
          Top = 42
          Width = 255
          Height = 18
          AutoSize = False
          Color = clInfoBk
          Ctl3D = True
          DisabledColor = clWhite
          FrameColor = clGray
          FrameHotColor = 14593668
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
          MaxLength = 4
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object RzEdit6: TRzEdit
          Left = 66
          Top = 66
          Width = 183
          Height = 18
          AutoSize = False
          Color = clInfoBk
          Ctl3D = True
          DisabledColor = clWhite
          FrameColor = clGray
          FrameHotColor = 14593668
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
          MaxLength = 4
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 4
        end
        object RzEdit7: TRzEdit
          Left = 314
          Top = 66
          Width = 159
          Height = 18
          AutoSize = False
          Color = clInfoBk
          Ctl3D = True
          DisabledColor = clWhite
          FrameColor = clGray
          FrameHotColor = 14593668
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
          MaxLength = 4
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
        object RzEdit5: TRzEdit
          Left = 633
          Top = 42
          Width = 241
          Height = 18
          AutoSize = False
          Color = clInfoBk
          Ctl3D = True
          DisabledColor = clWhite
          FrameColor = clGray
          FrameHotColor = 14593668
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
          MaxLength = 4
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 6
        end
        object RzEdit8: TRzEdit
          Left = 634
          Top = 66
          Width = 239
          Height = 18
          AutoSize = False
          Color = clInfoBk
          Ctl3D = True
          DisabledColor = clWhite
          FrameColor = clGray
          FrameHotColor = 14593668
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
          MaxLength = 4
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 7
        end
      end
      object Panel3: TPanel
        Left = 56
        Top = 64
        Width = 880
        Height = 512
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 2
        object dbgrd1: TDBGrid
          Left = 2
          Top = 2
          Width = 876
          Height = 508
          Align = alClient
          BorderStyle = bsNone
          Color = 15723503
          Ctl3D = False
          DataSource = DataSource1
          FixedColor = 15723503
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = GB2312_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = #23435#20307
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'InvoiceID'
              Title.Alignment = taCenter
              Title.Caption = #36864#36135#21333#21495
              Width = 83
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PID'
              Title.Alignment = taCenter
              Title.Caption = #37319#36141#21333#21495
              Width = 96
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'BarCode'
              Title.Alignment = taCenter
              Title.Caption = #21830#21697#26465#30721
              Width = 116
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'GoodsName'
              Title.Alignment = taCenter
              Title.Caption = #21830#21697#21517#31216
              Width = 200
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Unit'
              Title.Alignment = taCenter
              Title.Caption = #21333#20301
              Width = 60
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'UnitPrice'
              Title.Alignment = taCenter
              Title.Caption = #21333#20215
              Width = 87
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'UNScalar'
              Title.Alignment = taCenter
              Title.Caption = #36864#36135#25968#37327
              Width = 71
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'UNDate'
              Title.Alignment = taCenter
              Title.Caption = #36864#36135#26085#26399
              Width = 88
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'UserName'
              Title.Alignment = taCenter
              Title.Caption = #25805#20316#21592
              Width = 55
              Visible = True
            end>
        end
      end
    end
  end
  object ADOQuery1: TADOQuery
    Connection = Fr_Pass.ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from UNStock')
    Left = 11
    Top = 11
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 43
    Top = 11
  end
  object ADOQuery2: TADOQuery
    Connection = Fr_Pass.ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select * from Purchase')
    Left = 11
    Top = 43
  end
end

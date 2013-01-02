object frmSettings: TfrmSettings
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Settings'
  ClientHeight = 483
  ClientWidth = 564
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 564
    Height = 442
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    ExplicitLeft = -1
    object TabSheet1: TTabSheet
      Caption = 'General'
      object GroupBox1: TGroupBox
        Left = 3
        Top = 6
        Width = 238
        Height = 172
        TabOrder = 0
        object Label1: TLabel
          Left = 6
          Top = 38
          Width = 164
          Height = 13
          Caption = 'More settings coming in the future'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsItalic, fsUnderline]
          ParentFont = False
        end
        object chkbxShowWelcome: TCheckBox
          Left = 6
          Top = 15
          Width = 217
          Height = 17
          Caption = 'Show welcome screen'
          TabOrder = 0
        end
      end
    end
    object Character: TTabSheet
      Caption = 'Character'
      ImageIndex = 1
      object GroupBox2: TGroupBox
        Left = 3
        Top = 6
        Width = 270
        Height = 131
        TabOrder = 0
        object Label2: TLabel
          Left = 6
          Top = 41
          Width = 37
          Height = 13
          Caption = 'Region:'
        end
        object Label3: TLabel
          Left = 6
          Top = 65
          Width = 81
          Height = 13
          Caption = 'Character name:'
        end
        object Label4: TLabel
          Left = 6
          Top = 89
          Width = 33
          Height = 13
          Caption = 'Realm:'
        end
        object chkbxUseDefChar: TCheckBox
          Left = 6
          Top = 15
          Width = 244
          Height = 17
          Caption = 'Use default character'
          TabOrder = 0
          OnClick = chkbxUseDefCharClick
        end
        object cmbxDefCharRegion: TComboBox
          Left = 120
          Top = 38
          Width = 145
          Height = 21
          Style = csDropDownList
          Enabled = False
          ItemIndex = 0
          TabOrder = 1
          Text = 'EU'
          Items.Strings = (
            'EU'
            'US'
            'KR')
        end
        object edtDefChar: TEdit
          Left = 120
          Top = 64
          Width = 145
          Height = 21
          Enabled = False
          TabOrder = 2
        end
        object edtDefRealm: TEdit
          Left = 120
          Top = 88
          Width = 145
          Height = 21
          Enabled = False
          TabOrder = 3
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'File settings'
      ImageIndex = 2
      object GroupBox3: TGroupBox
        Left = 3
        Top = 6
        Width = 278
        Height = 179
        Caption = 'Deleting images'
        TabOrder = 0
        object chkbxDelImgAtClose: TCheckBox
          Tag = 1
          Left = 6
          Top = 15
          Width = 163
          Height = 17
          Caption = 'Delete on closing application'
          TabOrder = 0
          OnClick = chkbxDelImgAtCloseClick
        end
        object chkbxDelImgWeek: TCheckBox
          Tag = 2
          Left = 6
          Top = 33
          Width = 140
          Height = 17
          Caption = 'Delete weekly '
          TabOrder = 1
          OnClick = chkbxDelImgAtCloseClick
        end
        object Panel2: TPanel
          Left = 152
          Top = 33
          Width = 17
          Height = 17
          Hint = 
            'Images will delete every 7 days when you exit the application. D' +
            'ate resets when this setting is changed.'
          BevelKind = bkSoft
          BevelOuter = bvNone
          BorderWidth = 2
          Caption = '?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = Panel2Click
        end
        object Panel3: TPanel
          Left = 152
          Top = 51
          Width = 17
          Height = 17
          Hint = 
            'Images will delete when you exit the application the first time ' +
            'every month.'
          BevelKind = bkSoft
          BevelOuter = bvNone
          BorderWidth = 2
          Caption = '?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = Panel3Click
        end
        object chkbxDelImgMonth: TCheckBox
          Tag = 3
          Left = 6
          Top = 51
          Width = 140
          Height = 17
          Caption = 'Delete Monthly'
          TabOrder = 4
          OnClick = chkbxDelImgAtCloseClick
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 442
    Width = 564
    Height = 41
    Align = alBottom
    TabOrder = 1
    object btnCancel: TButton
      Left = 480
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Cancel'
      Style = bsSplitButton
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object btnApply: TButton
      Left = 399
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Apply'
      Style = bsSplitButton
      TabOrder = 1
      OnClick = btnApplyClick
    end
    object btnOk: TButton
      Left = 318
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Ok'
      Style = bsSplitButton
      TabOrder = 2
      OnClick = btnOkClick
    end
  end
end

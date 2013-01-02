object ERetrieveCharData: TERetrieveCharData
  Left = 0
  Top = 0
  Caption = 'Retrieve data'
  ClientHeight = 175
  ClientWidth = 363
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 363
    Height = 175
    Align = alClient
    Caption = 'Details'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 35
      Width = 37
      Height = 13
      Caption = 'Region:'
    end
    object Label2: TLabel
      Left = 16
      Top = 67
      Width = 81
      Height = 13
      Caption = 'Character name:'
    end
    object Label3: TLabel
      Left = 16
      Top = 99
      Width = 81
      Height = 13
      Caption = 'Character realm:'
    end
    object cboxRegion: TComboBox
      Left = 176
      Top = 32
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'EU'
      OnKeyDown = FormKeyDown
      Items.Strings = (
        'EU'
        'US'
        'KR')
    end
    object edtCharName: TEdit
      Left = 176
      Top = 64
      Width = 145
      Height = 21
      TabOrder = 1
      Text = 'xaveak'
      OnKeyDown = FormKeyDown
    end
    object btnRetrieve: TButton
      Left = 176
      Top = 131
      Width = 145
      Height = 25
      Caption = 'Retrieve data'
      TabOrder = 2
      OnClick = btnRetrieveClick
      OnKeyDown = FormKeyDown
    end
  end
  object edtRealm: TEdit
    Left = 176
    Top = 96
    Width = 145
    Height = 21
    TabOrder = 1
    Text = 'moonglade'
    OnKeyDown = FormKeyDown
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 72
    Top = 136
  end
end

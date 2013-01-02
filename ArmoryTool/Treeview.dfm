object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 533
  ClientWidth = 572
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object VirtualStringTree: TVirtualStringTree
    Left = 0
    Top = 0
    Width = 572
    Height = 257
    Align = alTop
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'Tahoma'
    Header.Font.Style = []
    Header.MainColumn = 1
    Header.SortColumn = 0
    Header.Style = hsFlatButtons
    TabOrder = 0
    ExplicitTop = 97
    Columns = <
      item
        Position = 0
        Width = 246
        WideText = 'Key'
      end
      item
        Position = 1
        WideText = 'Value'
      end>
  end
  object Memo: TMemo
    Left = 0
    Top = 385
    Width = 572
    Height = 148
    Align = alBottom
    ScrollBars = ssVertical
    TabOrder = 1
    ExplicitLeft = -53
    ExplicitTop = 353
    ExplicitWidth = 625
  end
end

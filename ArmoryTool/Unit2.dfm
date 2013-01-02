object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 304
  ClientWidth = 643
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 88
    Width = 643
    Height = 216
    Align = alBottom
    TabOrder = 0
  end
  object Button1: TButton
    Left = 104
    Top = 24
    Width = 75
    Height = 25
    Caption = 'pick color'
    TabOrder = 1
    OnClick = Button1Click
  end
  object ColorDialog1: TColorDialog
    OnClose = ColorDialog1Close
    Options = [cdAnyColor]
    Left = 384
    Top = 32
  end
end

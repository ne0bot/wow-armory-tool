object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
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
    Top = 168
    Width = 643
    Height = 136
    Align = alBottom
    TabOrder = 0
  end
  object Button1: TButton
    Left = 128
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Pick color'
    TabOrder = 1
    OnClick = Button1Click
  end
  object ColorDialog1: TColorDialog
    OnClose = ColorDialog1Close
    Options = [cdAnyColor]
    Left = 496
    Top = 104
  end
end

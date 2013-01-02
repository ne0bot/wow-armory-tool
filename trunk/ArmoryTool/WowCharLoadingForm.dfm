object Form4: TForm4
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSizeToolWin
  Caption = 'Loading...'
  ClientHeight = 84
  ClientWidth = 336
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
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 317
    Height = 13
    Caption = 'Downloading some missing images. This might take a few seconds.'
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 35
    Width = 317
    Height = 17
    Smooth = True
    Style = pbstMarquee
    MarqueeInterval = 75
    Step = 8
    TabOrder = 0
  end
  object Timer1: TTimer
    Interval = 75
    OnTimer = Timer1Timer
    Left = 256
    Top = 56
  end
end

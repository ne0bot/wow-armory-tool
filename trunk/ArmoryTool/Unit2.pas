unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm22 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    ColorDialog1: TColorDialog;
    procedure ColorDialog1Close(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form22: TForm22;

implementation

{$R *.dfm}

procedure TForm22.Button1Click(Sender: TObject);
begin
  ColorDialog1.Create(self);
end;

procedure TForm22.ColorDialog1Close(Sender: TObject);
begin
 Memo1.Lines.Append(ColorToString(ColorDialog1.Color));
end;

end.

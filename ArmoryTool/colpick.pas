unit colpick;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm3 = class(TForm)
    Memo1: TMemo;
    ColorDialog1: TColorDialog;
    Button1: TButton;
    procedure ColorDialog1Close(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
begin
  ColorDialog1.Execute();
end;

procedure TForm3.ColorDialog1Close(Sender: TObject);
begin
  Memo1.Lines.Append(ColorToString(ColorDialog1.Color));
end;

end.

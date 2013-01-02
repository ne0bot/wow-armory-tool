unit WowCharLoadingForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm4 = class(TForm)
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    Timer1: TTimer;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ChangeProgbarStep(step: integer; funct: string);
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.ChangeProgbarStep(step: integer; funct: string);
begin
  //ShowMessage(funct);
  if funct = 'reps' then
  begin
    //Label1.Caption := 'HAA';
    Application.ProcessMessages;
  end;
  ProgressBar1.Step := step;
  Application.ProcessMessages;
//  ShowMessage(Label1.Caption);
//  ShowMessage('whoop');
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
  Left:=(Screen.Width-Width)  div 2;
  Top:=(Screen.Height-Height) div 2;
  Top:= Top-(Top div 2);
end;

procedure TForm4.FormShow(Sender: TObject);
var
  runBar: boolean;
begin
  runBar := true;
  ProgressBar1.MarqueeInterval := 75;
  //Timer1.Create(Self);
end;

procedure TForm4.Timer1Timer(Sender: TObject);
begin
  ProgressBar1.Stepit;
end;

end.

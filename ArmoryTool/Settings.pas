unit Settings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, inifiles,
  DateUtils;

type
  TfrmSettings = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Character: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    btnCancel: TButton;
    btnApply: TButton;
    btnOk: TButton;
    Label1: TLabel;
    chkbxShowWelcome: TCheckBox;
    GroupBox2: TGroupBox;
    chkbxUseDefChar: TCheckBox;
    cmbxDefCharRegion: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    edtDefChar: TEdit;
    Label4: TLabel;
    edtDefRealm: TEdit;
    GroupBox3: TGroupBox;
    chkbxDelImgAtClose: TCheckBox;
    chkbxDelImgWeek: TCheckBox;
    Panel2: TPanel;
    Panel3: TPanel;
    chkbxDelImgMonth: TCheckBox;
    procedure chkbxUseDefCharClick(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure Panel3Click(Sender: TObject);
    procedure chkbxDelImgAtCloseClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckForChanges();
    function SaveSettings(): boolean;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    var
      settingsChanged,showWelcome, useDefChar,
      DelImgClose, DelImgWeek, DelImgMonth, clickFlag: boolean;
      DefChar, DefRealm: string;
      DefRegion: integer;
  end;

var
  frmSettings: TfrmSettings;

implementation

{$R *.dfm}

procedure TfrmSettings.btnCancelClick(Sender: TObject);
begin
  Self.Destroy;
end;

procedure TfrmSettings.btnOkClick(Sender: TObject);
var
  saved: boolean;
begin
  CheckForChanges();
  saved := SaveSettings();
  if saved then Self.Destroy;
end;

procedure TfrmSettings.CheckForChanges();
begin
  if chkbxShowWelcome.Checked <> showWelcome then settingsChanged := true;
  if chkbxUseDefChar.Checked <> useDefChar then settingsChanged := true;
  if chkbxDelImgAtClose.Checked <> DelImgClose then settingsChanged := true;
  if chkbxDelImgWeek.Checked <> DelImgWeek then settingsChanged := true;
  if chkbxDelImgMonth.Checked <> DelImgMonth then settingsChanged := true;
  if edtDefChar.Text <> DefChar then settingsChanged := true;
  if edtDefRealm.Text <> DefRealm then settingsChanged := true;
  if cmbxDefCharRegion.ItemIndex <> DefRegion then settingsChanged := true;
end;

procedure TfrmSettings.btnApplyClick(Sender: TObject);
var
  saved: boolean;
begin
  CheckForChanges();
  saved := SaveSettings();
  if saved then settingsChanged := false;
end;

procedure TfrmSettings.chkbxDelImgAtCloseClick(Sender: TObject);
var
  trigger: integer;
begin
  if clickFlag then
  begin
    clickFlag := false;
    trigger := TCheckBox(Sender).Tag;

    case trigger of
      1:
      begin
        chkbxDelImgWeek.State := cbUnchecked;
        chkbxDelImgMonth.State := cbUnchecked;
        chkbxDelImgAtClose.State := cbChecked;
      end;
      2:
      begin
        chkbxDelImgWeek.State := cbChecked;
        chkbxDelImgMonth.State := cbUnchecked;
        chkbxDelImgAtClose.State := cbUnchecked;
      end;
      3:
      begin
        chkbxDelImgWeek.State := cbUnchecked;
        chkbxDelImgMonth.State := cbChecked;
        chkbxDelImgAtClose.State := cbUnchecked;
      end;
    end;
    clickFlag := true;
  end;
end;

procedure TfrmSettings.chkbxUseDefCharClick(Sender: TObject);
begin
  cmbxDefCharRegion.Enabled := chkbxUseDefChar.Checked;
  edtDefChar.Enabled := chkbxUseDefChar.Checked;
  edtDefRealm.Enabled := chkbxUseDefChar.Checked;
end;

procedure TfrmSettings.FormCreate(Sender: TObject);
var
  settingsFile: TIniFile;
begin
  clickFlag := false;
  Left:=(Screen.Width-Width)  div 2;
  Top:=(Screen.Height-Height) div 2;

  settingsChanged := false;
  showWelcome := false;
  useDefChar := false;
  DelImgClose := false;
  DelImgWeek := false;
  DelImgMonth := false;

  settingsFile := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\Settings\Settings.ini');
  with settingsFile do
  begin
    try
      if ReadBool('Application', 'ShowPopup', false) then showWelcome := true;
      if ReadBool('Application', 'UseDefChar', false) then useDefChar := true;
      if ReadBool('Application', 'DeleteImagesClose', false ) then DelImgClose := true;
      if ReadBool('Application', 'DeleteImagesWeekly', false) then DelImgWeek := true;
      if ReadBool('Application', 'DeleteImagesMonthly', false) then DelImgMonth := true;
      if useDefChar = true then
      begin
        DefRegion := ReadInteger('Application', 'DefRegion', 0);
        DefChar := ReadString('Application', 'DefChar', '');
        DefRealm := ReadString('Application', 'DefRealm', '');
      end;
    finally
      settingsFile.Free;
    end;
  end;
  chkbxShowWelcome.Checked := showWelcome;
  chkbxUseDefChar.Checked := useDefChar;
  chkbxDelImgAtClose.Checked := DelImgClose;
  chkbxDelImgWeek.Checked := DelImgWeek;
  chkbxDelImgMonth.Checked := DelImgMonth;
  if useDefChar = true then
  begin
    cmbxDefCharRegion.ItemIndex := DefRegion;
    edtDefChar.Text := DefChar;
    edtDefRealm.Text := DefRealm;
  end;
  clickFlag := true;
end;

procedure TfrmSettings.Panel2Click(Sender: TObject);
begin
  Panel2.ShowHint := true;
end;

procedure TfrmSettings.Panel3Click(Sender: TObject);
begin
  Panel3.ShowHint := true;
end;

function TfrmSettings.SaveSettings: boolean;
var
  settingsFile: TIniFile;
  showWelcomeScrn, settingsChanged: boolean;
  date, nextDate, newDate : TDate;
begin
if settingsChanged then
  begin
    date := Now;
    showWelcomeScrn := chkbxShowWelcome.Checked;
    settingsFile := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\Settings\Settings.INI');
    with settingsFile do
    begin
      try
        WriteBool('Application', 'ShowPopup', chkbxShowWelcome.Checked);
        WriteBool('Application', 'UseDefChar', chkbxUseDefChar.Checked);
        WriteBool('Application', 'DeleteImagesClose', chkbxDelImgAtClose.Checked);
        WriteBool('Application', 'DeleteImagesWeekly', chkbxDelImgWeek.Checked);
        WriteBool('Application', 'DeleteImagesMonthly', chkbxDelImgMonth.Checked);
        if chkbxUseDefChar.Checked then
        begin
          WriteInteger('Application', 'DefRegion', cmbxDefCharRegion.ItemIndex);
          WriteString('Application', 'DefChar', edtDefChar.Text);
          WriteString('Application', 'DefRealm', edtDefRealm.Text);
        end
        else
        begin
          WriteInteger('Application', 'DefRegion', -1);
          WriteString('Application', 'DefChar', '');
          WriteString('Application', 'DefRealm', '');
        end;
        if chkbxDelImgWeek.Checked then nextDate := IncDay(Now, 7);
        if chkbxDelImgMonth.Checked then
        begin
          nextDate := IncMonth(Now, 1);
          nextDate := IncDay(nextDate, -(DayOfTheMonth(nextDate)-1));
        end;

        WriteDateTime('Application', 'WriteTime', Now);
        WriteDateTime('Application', 'NextDeletion', Now);

      finally
        settingsFile.Free;
      end;
    end;
  end;
  Result := true;
end;

end.

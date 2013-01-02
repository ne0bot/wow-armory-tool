unit RetrieveData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, WowCharacter, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, Generics.Collections, WowCharacterStats, WowCharLoadingForm, superobject;

type
  myDictionary = TDictionary<string,string>;
  myTempDict = TDictionary<string,string>;
  TERetrieveCharData = class(TForm)
    GroupBox1: TGroupBox;
    cboxRegion: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    edtCharName: TEdit;
    edtRealm: TEdit;
    Label3: TLabel;
    btnRetrieve: TButton;
    IdHTTP1: TIdHTTP;
    procedure btnRetrieveClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function CreateWowAPILink(region, name, realm: string): string;
    function MakeAPICall(APIUrl: string): ISuperObject;
    procedure ChangeProgbarStep(step: integer);
  end;

var
  ERetrieveCharData: TERetrieveCharData;

implementation
uses
  SpecialCharacters, main;

{$R *.dfm}

procedure TERetrieveCharData.btnRetrieveClick(Sender: TObject);
var
  Character: TWowChar;
  CharStats: TWowCharStats;
  CreationSucces: boolean;
  APIUrl: string;
  apiValue: ISuperObject;
  loading: TForm4;
begin
  loading := TForm4.Create(Self);
  loading.ProgressBar1.Step := Form1.ImageLoadCount;
  loading.Show;
  Application.ProcessMessages;
  APIUrl := CreateWowAPILink(cboxRegion.Text, edtCharName.Text, edtRealm.Text);
  apiValue := MakeAPICall(APIUrl);
  Character := TWowChar.Create(cboxRegion.Text, apiValue);
  try
      try
        CreationSucces := Form1.CreateWowCharFromJson(Character);
      finally
        CharStats.Free;
      end;
  finally

  end;

  if CreationSucces then
  begin
    loading.Destroy;
    Self.Destroy;
  end;


end;

procedure TERetrieveCharData.ChangeProgbarStep(step: integer);
begin
  //Form4.ChangeProgbarStep(step);
end;

function TERetrieveCharData.CreateWowAPILink(region, name, realm: string): string;
var
  baseAPIUrl{, nameForAPI}: string;
begin
  realm := StringReplace(realm, ' ', '-', [rfReplaceAll]);
  baseAPIUrl := 'http://{region}.battle.net/api/wow/character/{realm}/{character}?fields=stats,reputation,talents,items';
  baseAPIUrl := StringReplace(baseAPIUrl, '{region}', LowerCase(region), [rfReplaceAll]);
  baseAPIUrl := StringReplace(baseAPIUrl, '{realm}', LowerCase(realm), [rfReplaceAll]);
  baseAPIUrl := StringReplace(baseAPIUrl, '{character}', FormatName(LowerCase(name)), [rfReplaceAll]);
  Result := baseAPIUrl;
end;

procedure TERetrieveCharData.FormCreate(Sender: TObject);
begin
  Left:=(Screen.Width-Width)  div 2;
  Top:=(Screen.Height-Height) div 2;
  Top:= Top-(Top div 2);
end;

procedure TERetrieveCharData.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 27 then
  begin
    if Dialogs.MessageDlg('Do you want to close this form?', mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
          Self.Destroy
        else
          Abort
  end;
end;

function TERetrieveCharData.MakeAPICall(APIUrl: string): ISuperObject;
var
  memoryStream: TMemoryStream;
  obj: ISuperObject;
begin
  memoryStream := TMemoryStream.Create;
  try
    //IdHTTP.Create(Self);
    IdHTTP1.Get(APIUrl, memoryStream);
    memoryStream.Position := 0;
    memoryStream.SaveToFile('C:\Stream.txt');

    if memoryStream <> nil then
    begin
      obj := TSuperObject.ParseStream(memoryStream, true);
    end;
  finally
    memoryStream.Free;
  end;

  //obj.SaveTo('c:\jsonstream.txt');
  Result := obj;

end;

end.

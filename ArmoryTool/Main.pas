unit Main;

interface

uses
  Windows, Contnrs, Generics.Collections, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, WowCharLoadingForm, RetrieveData, TreeView, JPEG,
  ActnList, Menus, System.Actions, colpick, Vcl.ComCtrls, Vcl.Grids, Vcl.Buttons,
  Vcl.ButtonGroup, WowFaction, WowCharacter, WowCharacterTalentSpec,
  WowCharacterStats, WoWIndividualTalent, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, WowCharacterItems, Vcl.Imaging.pngimage,
  axCtrls, IniFiles, Settings, ShellApi;

type
  CurrentWowChar = TWowChar;
  RetrieveComponent = TERetrieveCharData;
  Form3 = TForm3;
  WowCharLoadingForm = TFloatSpecial;
  TForm1 = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Button1: TButton;
    edtName: TEdit;
    edtRealm: TEdit;
    edtRegion: TEdit;
    labeeel3: TLabel;
    labeeel2: TLabel;
    labeeel: TLabel;
    MainMenu1: TMainMenu;
    f1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    Exit1: TMenuItem;
    Options1: TMenuItem;
    Languages1: TMenuItem;
    LangEnglish: TMenuItem;
    LangDutch: TMenuItem;
    ActionList1: TActionList;
    actLangEN: TAction;
    actLangNL: TAction;
    ColorPick1: TMenuItem;
    PrimTal: TAction;
    SecTal: TAction;
    imgDownloader: TIdHTTP;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Talents: TTabSheet;
    spdbtnPriSpec: TSpeedButton;
    spdbtnSecSpec: TSpeedButton;
    grpBxPriTal: TGroupBox;
    Panel3: TPanel;
    grpBxSecTal: TGroupBox;
    Panel2: TPanel;
    Reputation: TTabSheet;
    RepPanel: TPanel;
    RepBoxScroll: TScrollBox;
    TabSheet2: TTabSheet;
    StringGrid1: TStringGrid;
    TabSheet3: TTabSheet;
    CharImage: TImage;
    imgWrist: TImage;
    imgTabard: TImage;
    imgChest: TImage;
    imgShirt: TImage;
    imgHead: TImage;
    imgNeck: TImage;
    imgShoulder: TImage;
    imgBack: TImage;
    imgHands: TImage;
    imgWaist: TImage;
    imgLegs: TImage;
    imgFeet: TImage;
    imgFinger1: TImage;
    imgFinger2: TImage;
    imgTrinket1: TImage;
    imgTrinket2: TImage;
    imgMainhand: TImage;
    imgOffhand: TImage;
    spdTal11: TSpeedButton;
    tmpImage: TImage;
    spdTal12: TSpeedButton;
    spdTal14: TSpeedButton;
    spdTal13: TSpeedButton;
    spdTal16: TSpeedButton;
    spdTal15: TSpeedButton;
    spdTal26: TSpeedButton;
    spdTal25: TSpeedButton;
    spdTal24: TSpeedButton;
    spdTal23: TSpeedButton;
    spdTal22: TSpeedButton;
    spdTal21: TSpeedButton;
    grpbxTalDesc: TGroupBox;
    TalentClick: TAction;
    lblTalDescription: TLabel;
    lblCost: TLabel;
    lblCast: TLabel;
    lblCooldown: TLabel;
    ItemInfoChecker: TIdHTTP;
    Settings1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure actLangENExecute(Sender: TObject);
    procedure actLangNLExecute(Sender: TObject);
    procedure ColorPick1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RepBoxScrollMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure RepBoxScrollMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure spdbtnPriSpecClick(Sender: TObject);
    procedure spdbtnSecSpecClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TalentClickExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Settings1Click(Sender: TObject);
    procedure CheckSettingsFile();
  private
    { Private declarations }
    FWoWCharacter: TWowChar;
    FImagesToLoad: integer;
  public
    { Public declarations }
    function CreateWowCharFromJson(charData: TWowChar): Boolean;
    property WoWCharacter: TWowChar read FWoWCharacter;
    property ImageLoadCount: integer read FImagesToLoad;
    var
      deleteOnExit,formMaximized : boolean;



  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TForm1 }

procedure TForm1.actLangENExecute(Sender: TObject);
begin
  LangEnglish.Checked := true;
end;

procedure TForm1.actLangNLExecute(Sender: TObject);
begin
  LangDutch.Checked := true;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  RetrieveDataComponent: TERetrieveCharData;
begin
  RetrieveDataComponent:= TERetrieveCharData.Create(Self);
  RetrieveDataComponent.Show;
end;

procedure TForm1.CheckSettingsFile;
var
  settingsFile: TIniFile;
begin
  settingsFile := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\Settings\Settings.ini');
  with settingsFile do
  begin
    try
      if ReadBool('Application', 'DeleteImagesClose', false ) then deleteOnExit := true;
      if ReadBool('MainForm', 'InitMax', false) then
      begin
        WindowState := wsMaximized;
        formMaximized := true
      end
      else
        WindowState := wsNormal;
        formMaximized := false;
    finally
      settingsFile.Free;
    end;
  end;
end;

procedure TForm1.ColorPick1Click(Sender: TObject);
var
  form22 : TForm3;
  loading: TForm4;
begin
  loading := TForm4.Create(Self);
  loading.Show;
end;

procedure drawFactions(FactionSet: TList<TObjectList>);
var
  I, X, myTop, myLeft, myHeight, myWidth: integer;
  CatLbl, facNamelbl, facStandinglbl, Replbl, maxReplbl, percentComplbl: TLabel;
  progbar: TProgressBar;
  myFaction: TFaction;
  catName: string;
  factionCount: integer;
begin
  factionCount := 0;
  myTop := 10;
  myLeft := 10;

  for X := 0 to FactionSet.Count -1 do
  begin

    myLeft := 10;
    myFaction := FactionSet[X][0] as TFaction;
    CatLbl := TLabel.Create(Form1);
    CatLbl.Parent := Form1.RepBoxScroll;
    CatLbl.Left := myLeft;
    CatLbl.Top := myTop;
    CatLbl.Font.Size := 14;
    CatLbl.Caption := myFaction.Category;
    CatLbl.Name := 'Cat' + StringReplace(myFaction.Category, ' ', '_',[rfReplaceAll]);
    myTop := myTop + 40;
    myLeft := 50;

    for I := 0 to FactionSet[X].Count -1 do
    begin
      myFaction := FactionSet[X][I] as TFaction;
      catName := StringReplace(myFaction.Category, ' ', '_',[rfReplaceAll]);
      facNamelbl := TLabel.Create(Form1);
      facNamelbl.Parent := Form1.RepBoxScroll;
      facNamelbl.Left := myLeft;
      facNamelbl.Top := myTop;
      facNamelbl.Font.Size := 9;
      facNamelbl.Caption := myFaction.FactionName;
      facNamelbl.Name := 'facName' + catName + IntToStr(I);
      myLeft := myLeft + 200;

      Replbl := TLabel.Create(Form1);
      Replbl.Parent := Form1.RepBoxScroll;
      Replbl.Left := myLeft;
      Replbl.Top := myTop;
      Replbl.Font.Size := 9;
      Replbl.Caption := IntToStr(myFaction.CurrentRep) + '/' + IntToStr(myFaction.MaxRep);
      facNamelbl.Name := 'facRep' + catName + IntToStr(I);
      myLeft := myLeft + 100;

      progbar := TProgressBar.Create(Form1);
      progbar.Parent := Form1.RepBoxScroll;
      progbar.Left := myLeft;
      progbar.Top := myTop;
      progbar.Position := Round(myFaction.PercentCompleted);
      progbar.BarColor := myFaction.StandingColor;
      progbar.BackgroundColor := clGray;
      progbar.Width := 150;
      progbar.Style := pbstNormal;
      progbar.Name := 'progBar' + catName + IntToStr(I);
      myLeft := myLeft + 160;

      facStandinglbl := TLabel.Create(Form1);
      facStandinglbl.Parent := Form1.RepBoxScroll;
      facStandinglbl.Left := myLeft;
      facStandinglbl.Top := myTop;
      facStandinglbl.Font.Size := 9;
      facStandinglbl.Caption := myFaction.FactionStandingStr;
      facStandinglbl.Name := 'facStanding' + catName + IntToStr(I);
      myLeft := myLeft + 80;

      facStandinglbl := TLabel.Create(Form1);
      facStandinglbl.Parent := Form1.RepBoxScroll;
      facStandinglbl.Left := myLeft;
      facStandinglbl.Top := myTop;
      facStandinglbl.Font.Size := 9;
      facStandinglbl.Caption := Format('%.0f', [myFaction.PercentCompleted]) + '%';
      facStandinglbl.Name := 'facCompPercent' + catName + IntToStr(I);

      myTop := myTop + 30;
      myLeft := 50;

    end;

  end;

end;

procedure DownloadImage(downloadLink, saveLocation: string; totalImagesToGet: integer);
var
  MS: TMemoryStream;
  JPEG: TJPEGImage;
  nextStep: integer;
begin

  MS := TMemoryStream.Create;
  try
    JPEG := TJPEGImage.Create;
    try
      MS.Clear;
      try
        Form1.imgDownloader.Get(downloadLink, MS);
        MS.Position := 0;
        JPEG.LoadFromStream(MS);
        JPEG.SaveToFile(saveLocation);
        Form4.ProgressBar1.StepIt;
      finally
      end;
    finally
      JPEG.Free;
    end;
  finally
    MS.Free;
  end;
  Application.ProcessMessages;
end;

function CheckIfPathExists(): string;
var
  character: TWowChar;
  baseFilePath, baseImagePath: string;
begin
  baseFilePath := ExtractFilePath(Application.ExeName) + 'Images\Realms\';
  if not DirectoryExists(baseFilePath) then CreateDir(baseFilePath);
  baseFilePath := baseFilePath + Form1.WoWCharacter.Realm + '\';
  if not DirectoryExists(baseFilePath) then CreateDir(baseFilePath);
  baseFilePath := baseFilePath + Form1.WoWCharacter.Name + '\';
  if not DirectoryExists(baseFilePath) then CreateDir(baseFilePath);
  Result := baseFilePath;
end;

procedure CheckForImages(CharDetails: TWowCharStats; imagesToGet: integer);
var
  imageExists: Boolean;
  I, X: integer;
  basePath, baseDownloadLink, fileToGet: string;
  currentSpec: TWowCharacterTalentSpec;
begin
  basePath := ExtractFilePath(Application.ExeName) + '\Images\Classes\' + CharDetails.CharClass + '\Talents\Small\';
  baseDownloadLink := 'http://media.blizzard.com/wow/icons/18/';
  for I := 0 to 1 do
  begin
    if I = 0 then currentSpec := CharDetails.PrimaryTalents
    else currentSpec := CharDetails.SecondaryTalents;
    for X := 1 to 6 do
    begin
      case X of
        1: fileToGet := currentSpec.TalentsString.FirstTier.Icon + '.jpg';
        2: fileToGet := currentSpec.TalentsString.SecondTier.Icon + '.jpg';
        3: fileToGet := currentSpec.TalentsString.ThirdTier.Icon + '.jpg';
        4: fileToGet := currentSpec.TalentsString.FourthTier.Icon + '.jpg';
        5: fileToGet := currentSpec.TalentsString.FifthTier.Icon + '.jpg';
        6: fileToGet := currentSpec.TalentsString.SixthTier.Icon + '.jpg';
      end;

      imageExists := FileExists(basePath + fileToGet);
      if not imageExists then
      begin
        if fileToGet <> 'X.jpg' then DownloadImage(baseDownloadLink + fileToGet, basePath + fileToGet, imagesToGet);
      end;
    end;
  end;
end;

function CountMissingImages(CharDetails: TWowCharStats):integer;
var
  imageExists: Boolean;
  I, X, missingImages: integer;
  basePath, baseDownloadLink, fileToGet: string;
  currentSpec: TWowCharacterTalentSpec;
begin
  missingImages := 0;
  for I := 0 to 1 do
  begin
    if I = 0 then currentSpec := CharDetails.PrimaryTalents
    else currentSpec := CharDetails.SecondaryTalents;
    for X := 1 to 6 do
    begin
      case X of
        1: fileToGet := currentSpec.TalentsString.FirstTier.Icon + '.jpg';
        2: fileToGet := currentSpec.TalentsString.SecondTier.Icon + '.jpg';
        3: fileToGet := currentSpec.TalentsString.ThirdTier.Icon + '.jpg';
        4: fileToGet := currentSpec.TalentsString.FourthTier.Icon + '.jpg';
        5: fileToGet := currentSpec.TalentsString.FifthTier.Icon + '.jpg';
        6: fileToGet := currentSpec.TalentsString.SixthTier.Icon + '.jpg';
      end;
      imageExists := FileExists(basePath + fileToGet);
      if not imageExists then missingImages := missingImages +1;
    end;
  end;
  Result:= missingImages;
end;

procedure DisplayStats(charData: TWowChar);
var
  powerType: string;
begin
  powerType := charData.Stats.PowerType;
  Form1.edtRegion.Text := charData.Region;
  Form1.edtName.Text := charData.Name;
  Form1.edtRealm.Text := charData.Realm;

  Form1.Label1.Caption := 'Health: ' + IntToStr(charData.Stats.Health);
  Form1.Label2.Caption := 'Power amount: ' + IntToStr(charData.Stats.PowerAmount);
  if powerType = 'mana' then Form1.Label2.Font.Color := clBlue
  else if powerType = 'rage' then Form1.Label2.Font.Color := clRed
  else if powerType = 'energy' then Form1.Label2.Font.Color := clYellow
  else if powerType = 'focus' then Form1.Label2.Font.Color := clMaroon
  else if powerType = 'runic-power' then Form1.Label2.Font.Color := clAqua;

  Form1.Label3.Caption := 'Powertype: ' + charData.Stats.PowerType;
  Form1.Label4.Caption := 'Strength: ' + IntToStr(charData.Stats.Strength);
  Form1.Label5.Caption := 'Agility: ' + IntToStr(charData.Stats.Agility);
  Form1.Label6.Caption := 'Stamina: ' + IntToStr(charData.Stats.Stamina);
  Form1.Label7.Caption := 'Intellect: ' + IntToStr(charData.Stats.Intellect);
  Form1.Label8.Caption := 'Spirit: ' + IntToStr(charData.Stats.Spirit);
end;

procedure convertImageToBmp(charData: TWowChar);
var
  fs : TFileStream;
  OleGraphic: TOleGraphic;
  bmp: TBitmap;
  jpg: TJPEGImage;
  X,I: integer;
  basePath: string;
  talents: TWowCharacterTalentSpec;
begin
  basePath := ExtractFilePath(Application.ExeName) + '\Images\Classes\' +
  charData.Stats.CharClass + '\Talents\Small\';
  for X := 0 to 1 do
  begin
    if X = 0 then talents := charData.Stats.PrimaryTalents
    else if X = 1 then talents := charData.Stats.SecondaryTalents;
    for I := 1 to 6 do
    begin
      case I of
      1: Form1.tmpImage.Picture.LoadFromFile(basePath + talents.TalentsString.FirstTier.Icon + '.jpg');
      2: Form1.tmpImage.Picture.LoadFromFile(basePath + talents.TalentsString.SecondTier.Icon + '.jpg');
      3: Form1.tmpImage.Picture.LoadFromFile(basePath + talents.TalentsString.ThirdTier.Icon + '.jpg');
      4: Form1.tmpImage.Picture.LoadFromFile(basePath + talents.TalentsString.FourthTier.Icon + '.jpg');
      5: Form1.tmpImage.Picture.LoadFromFile(basePath + talents.TalentsString.FifthTier.Icon + '.jpg');
      6: Form1.tmpImage.Picture.LoadFromFile(basePath + talents.TalentsString.SixthTier.Icon + '.jpg');
      end;//end Case I
      bmp := TBitmap.Create;
      try
        bmp.Width := Form1.tmpImage.Picture.Graphic.Width;
        bmp.Height := Form1.tmpImage.Picture.Graphic.Height;
        bmp.Canvas.Draw(0,0, Form1.tmpImage.Picture.Graphic);
        case X of
          0:
            case I of
              1:
              begin
                Form1.spdTal11.Glyph := bmp;
                Form1.spdTal11.Caption := talents.TalentsString.FirstTier.Name;
              end;
              2:
              begin
                Form1.spdTal12.Glyph := bmp;
                Form1.spdTal12.Caption := talents.TalentsString.SecondTier.Name;
              end;
              3:
              begin
                Form1.spdTal13.Glyph := bmp;
                Form1.spdTal13.Caption := talents.TalentsString.ThirdTier.Name;
              end;
              4:
              begin
                Form1.spdTal14.Glyph := bmp;
                Form1.spdTal14.Caption := talents.TalentsString.FourthTier.Name;
              end;
              5:
              begin
                Form1.spdTal15.Glyph := bmp;
                Form1.spdTal15.Caption := talents.TalentsString.FifthTier.Name;
              end;
              6:
              begin
                Form1.spdTal16.Glyph := bmp;
                Form1.spdTal16.Caption := talents.TalentsString.SixthTier.Name;
              end;

            end;
          1:
            case I of
              1:
              begin
                Form1.spdTal21.Glyph := bmp;
                Form1.spdTal21.Caption := talents.TalentsString.FirstTier.Name;
              end;
              2:
              begin
                Form1.spdTal22.Glyph := bmp;
                Form1.spdTal22.Caption := talents.TalentsString.SecondTier.Name;
              end;
              3:
              begin
                Form1.spdTal23.Glyph := bmp;
                Form1.spdTal23.Caption := talents.TalentsString.ThirdTier.Name;
              end;
              4:
              begin
                Form1.spdTal24.Glyph := bmp;
                Form1.spdTal24.Caption := talents.TalentsString.FourthTier.Name;
              end;
              5:
              begin
                Form1.spdTal25.Glyph := bmp;
                Form1.spdTal25.Caption := talents.TalentsString.FifthTier.Name;
              end;
              6:
              begin
                Form1.spdTal26.Glyph := bmp;
                Form1.spdTal26.Caption := talents.TalentsString.SixthTier.Name;
              end;
            end;
        end;
      finally
        bmp.Free;
      end;
    end;//end For I
  end;//end For X
  Form1.tmpImage.Visible := false;
end;

procedure ShowTalentImages(charData: TWowChar);
var
  basePath: string;
begin
  basePath := ExtractFilePath(Application.ExeName) + '\Images\Classes\' + charData.Stats.CharClass + '\Talents\Small\';

  convertImageToBmp(charData);


  Form1.spdbtnPriSpec.Caption := charData.Stats.PrimaryTalents.TalentSpecName;
  Form1.spdbtnSecSpec.Caption := charData.Stats.SecondaryTalents.TalentSpecName;

  if charData.Stats.PrimaryTalents.IsSelected then
  begin
    Form1.Caption := 'Details: ' + charData.Name + ' Level ' + charData.Stats.Level + ' ' + charData.Stats.Race + ' ' + charData.Stats.PrimaryTalents.TalentSpecName + ' ' + charData.Stats.CharClass;
    Form1.grpBxPriTal.Visible := true;
    Form1.spdbtnPriSpec.Down := true;
  end
  else
  begin
    Form1.Caption := 'Details: ' + charData.Name + ' Level ' + charData.Stats.Level + ' ' + charData.Stats.Race + ' ' + charData.Stats.SecondaryTalents.TalentSpecName + ' ' + charData.Stats.CharClass;
    Form1.grpBxSecTal.Visible := true;
    Form1.spdbtnSecSpec.Down := true;
  end;
end;

procedure fillReputationGrid(charData: TwowChar);
var
  tmpFaction: TFaction;
  X,I,J: integer;
begin
  Form1.StringGrid1.RowCount := (charData.Stats.ReputationList[0].Count +
  charData.Stats.ReputationList[1].Count + charData.Stats.ReputationList[2].Count +
  charData.Stats.ReputationList[3].Count + charData.Stats.ReputationList[4].Count +
  charData.Stats.ReputationList[5].Count + charData.Stats.ReputationList[6].Count) +1;

  X := 1;
  for I := 0 to charData.Stats.ReputationList.Count -1 do
  begin
    for J := 0 to charData.Stats.ReputationList[I].Count -1 do
    begin
      tmpFaction := charData.Stats.ReputationList[I][J] as TFaction;
      Form1.StringGrid1.Cells[0,X] := tmpFaction.FactionId;
      Form1.StringGrid1.Cells[1,X] := tmpFaction.FactionName;
      Form1.StringGrid1.Cells[2,X] := tmpFaction.FactionStandingStr;
      Form1.StringGrid1.Cells[3,X] := IntToStr(tmpFaction.CurrentRep);
      Form1.StringGrid1.Cells[4,X] := IntToStr(tmpFaction.MaxRep);
      Form1.StringGrid1.Cells[5,X] := Format('%.1f', [tmpFaction.PercentCompleted]) + '%';
      Form1.StringGrid1.Cells[6,X] := tmpFaction.Category;
      Form1.StringGrid1.Cells[7,X] := tmpFaction.SubCategory;
      X := X+1;
    end;
  end;
end;

procedure DownloadItemImage(ImageToDownload: string);
begin

end;

procedure CheckIfItemImageExists(imageToCheck: string);
var
  basePath, baseDownloadLink: string;
  imageExists: boolean;
begin
  basePath := ExtractFilePath(Application.ExeName) + '\Images\Items\';
  baseDownloadLink := 'http://media.blizzard.com/wow/icons/56/';
  imageExists := FileExists(basePath + imageToCheck + '.jpg');
      if not imageExists then
      begin
        if imageToCheck <> 'X' then DownloadImage(baseDownloadLink + imageToCheck + '.jpg', basePath + imageToCheck + '.jpg', 1);
      end;
end;

procedure ShowItemImages(charData: TWowChar);
var
  charItems: TWowCharacterItems;
  basePath, icon: string;
begin
  basePath := ExtractFilePath(Application.ExeName) + '\Images\Items\';
  charItems := charData.Items;

  CheckIfItemImageExists(charItems.Head.ItemIcon);
  CheckIfItemImageExists(charItems.Neck.ItemIcon);
  CheckIfItemImageExists(charItems.Shoulder.ItemIcon);
  CheckIfItemImageExists(charItems.Back.ItemIcon);
  CheckIfItemImageExists(charItems.Chest.ItemIcon);
  CheckIfItemImageExists(charItems.Shirt.ItemIcon);
  CheckIfItemImageExists(charItems.Tabard.ItemIcon);
  CheckIfItemImageExists(charItems.Wrist.ItemIcon);
  CheckIfItemImageExists(charItems.Hands.ItemIcon);
  CheckIfItemImageExists(charItems.Waist.ItemIcon);
  CheckIfItemImageExists(charItems.Legs.ItemIcon);
  CheckIfItemImageExists(charItems.Feet.ItemIcon);
  CheckIfItemImageExists(charItems.Finger1.ItemIcon);
  CheckIfItemImageExists(charItems.Finger2.ItemIcon);
  CheckIfItemImageExists(charItems.Trinket1.ItemIcon);
  CheckIfItemImageExists(charItems.Trinket2.ItemIcon);
  CheckIfItemImageExists(charItems.MainHand.ItemIcon);
  CheckIfItemImageExists(charItems.Offhand.ItemIcon);

  icon := charItems.Head.ItemIcon;
  if LowerCase(icon) <> 'x' then Form1.imgHead.Picture.LoadFromFile(basePath + icon + '.jpg');
  icon := charItems.Neck.ItemIcon;
  if LowerCase(icon) <> 'x' then Form1.imgNeck.Picture.LoadFromFile(basePath + icon + '.jpg');
  icon := charItems.Shoulder.ItemIcon;
  if LowerCase(icon) <> 'x' then Form1.imgShoulder.Picture.LoadFromFile(basePath + icon + '.jpg');
  icon := charItems.Back.ItemIcon;
  if LowerCase(icon) <> 'x' then Form1.imgBack.Picture.LoadFromFile(basePath + icon + '.jpg');
  icon := charItems.Chest.ItemIcon;
  if LowerCase(icon) <> 'x' then Form1.imgChest.Picture.LoadFromFile(basePath + icon + '.jpg');
  icon := charItems.Shirt.ItemIcon;
  if LowerCase(icon) <> 'x' then Form1.imgShirt.Picture.LoadFromFile(basePath + icon + '.jpg');
  icon := charItems.Tabard.ItemIcon;
  if LowerCase(icon) <> 'x' then Form1.imgTabard.Picture.LoadFromFile(basePath + icon + '.jpg');
  icon := charItems.Wrist.ItemIcon;
  if LowerCase(icon) <> 'x' then Form1.imgWrist.Picture.LoadFromFile(basePath + icon + '.jpg');
  icon := charItems.Hands.ItemIcon;
  if LowerCase(icon) <> 'x' then Form1.imgHands.Picture.LoadFromFile(basePath + icon + '.jpg');
  icon := charItems.Waist.ItemIcon;
  if LowerCase(icon) <> 'x' then Form1.imgWaist.Picture.LoadFromFile(basePath + icon + '.jpg');
  icon := charItems.Legs.ItemIcon;
  if LowerCase(icon) <> 'x' then Form1.imgLegs.Picture.LoadFromFile(basePath + icon + '.jpg');
  icon := charItems.Feet.ItemIcon;
  if LowerCase(icon) <> 'x' then Form1.imgFeet.Picture.LoadFromFile(basePath + icon + '.jpg');
  icon := charItems.Finger1.ItemIcon;
  if LowerCase(icon) <> 'x' then Form1.imgFinger1.Picture.LoadFromFile(basePath + icon + '.jpg');
  icon := charItems.Finger2.ItemIcon;
  if LowerCase(icon) <> 'x' then Form1.imgFinger2.Picture.LoadFromFile(basePath + icon + '.jpg');
  icon := charItems.Trinket1.ItemIcon;
  if LowerCase(icon) <> 'x' then Form1.imgTrinket1.Picture.LoadFromFile(basePath + icon + '.jpg');
  icon := charItems.Trinket2.ItemIcon;
  if LowerCase(icon) <> 'x' then Form1.imgTrinket2.Picture.LoadFromFile(basePath + icon + '.jpg');
  icon := charItems.MainHand.ItemIcon;
  if LowerCase(icon) <> 'x' then Form1.imgMainhand.Picture.LoadFromFile(basePath + icon + '.jpg');
  icon := charItems.Offhand.ItemIcon;
  if LowerCase(icon) <> 'x' then Form1.imgOffhand.Picture.LoadFromFile(basePath + icon + '.jpg');

end;

function TForm1.CreateWowCharFromJson(charData: TWowChar): Boolean;
var
  powerType, Talents, profImage, profImagePath: string;
  StringList: TStringList;
  I, J, X: integer;
  tmpFaction: TFaction;
  tempRow: TStrings;
  swapped: boolean;
  MissingImages: integer;
  scrollbox: TScrollBox;
  items: TWowCharacterItems;
begin
  FWoWCharacter := charData;
  MissingImages := 0;
  StringList := TStringList.Create;
  grpBxSecTal.Left := 18;
  spdbtnPriSpec.Visible := true;
  spdbtnSecSpec.Visible := true;
  DisplayStats(charData);
  MissingImages := CountMissingImages(charData.Stats);
  FImagesToLoad := MissingImages;
  if MissingImages > 0 then
  begin
    CheckForImages(charData.Stats, MissingImages);
  end;
  ShowTalentImages(charData);
  profImagePath := CheckIfPathExists();
  profImage := 'http://' + LowerCase(charData.Region) + '.battle.net/static-render/' + LowerCase(charData.Region) + '/' + charData.Stats.ProfileImage;
  DownloadImage(profImage , CheckIfPathExists() + 'profImage.jpg', 1);
  CharImage.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\Images\Realms\' + charData.Realm + '\' + charData.Name + '\profImage.jpg');
  fillReputationGrid(charData);
  for I := Form1.RepBoxScroll.ControlCount -1 downto 0 do Form1.RepBoxScroll.Controls[I].Free;
  drawFactions(charData.Stats.ReputationList);
  ShowItemImages(charData);
  Result := true;
end;

procedure CheckAndCreateFolders();
var
  basePath: string;
  pathList, classList: TStringList;
  I: integer;
begin
  pathList := TStringList.Create;
  pathList.Add('\Images\');
  pathList.Add('\Images\Items\');
  pathList.Add('\Images\Classes\');
  pathList.Add('\Images\ClassImages\');
    pathList.Add('\Images\ClassImages\Large\');
    pathList.Add('\Images\ClassImages\Small\');
  pathList.Add('\Images\Factions\');
    pathList.Add('\Images\Factions\Large\');
    pathList.Add('\Images\Factions\Small\');
  pathList.Add('\Images\Races\');
    pathList.Add('\Images\Races\Large\');
    pathList.Add('\Images\Races\Small\');

  classList := TStringList.Create;
  classList.Add('\Images\Classes\Death Knight\');
  classList.Add('\Images\Classes\Druid\');
  classList.Add('\Images\Classes\Hunter\');
  classList.Add('\Images\Classes\Mage\');
  classList.Add('\Images\Classes\Monk\');
  classList.Add('\Images\Classes\Paladin\');
  classList.Add('\Images\Classes\Priest\');
  classList.Add('\Images\Classes\Rogue\');
  classList.Add('\Images\Classes\Shaman\');
  classList.Add('\Images\Classes\Warlock\');
  classList.Add('\Images\Classes\Warrior\');
  basePath := ExtractFilePath(Application.ExeName);

  for I := 0 to pathList.Count -1 do
  begin
    if not DirectoryExists(basePath + pathList[I]) then CreateDir(basePath + pathList[I]);  
  end;
  for I := 0 to classList.Count -1 do
    begin
      if not DirectoryExists(basePath + classList[I]) then 
      begin
        CreateDir(basePath + classList[I]);
        CreateDir(basePath + classList[I] + 'Talents\');
        CreateDir(basePath + classList[I] + 'Talents\Large\');
        CreateDir(basePath + classList[I] + 'Talents\Small\');
      end;
    end;
  

  
  basePath := basePath;
  

end;



procedure TForm1.FormCreate(Sender: TObject);
begin
  CheckSettingsFile;
  CheckAndCreateFolders;
  Left:=(Screen.Width-Width)  div 2;
  Top:=(Screen.Height-Height) div 2;
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  settingsFile: TIniFile;
  winState: boolean;
  ShOp: TSHFileOpStruct;
begin
  winState := (WindowState = wsMaximized);
  if (winState <> formMaximized) then
  begin
    settingsFile := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\Settings\Settings.INI');
    with settingsFile do
    begin
      try
        WriteBool('MainForm', 'InitMax', WindowState = wsMaximized);
        WriteDateTime('Application', 'WriteTime', Now);
      finally
        settingsFile.Free;
      end;
    end;
  end;
  CheckSettingsFile;
  if deleteOnExit then
  begin
    ShOp.Wnd := Self.Handle;
    ShOp.wFunc := FO_DELETE;
    ShOp.pFrom := PChar(ExtractFilePath(Application.ExeName) + '\Images'#0);
    ShOp.pTo := nil;
    ShOp.fFlags := FOF_NO_UI;
    SHFileOperation(ShOp);
  end;
end;

procedure TForm1.FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var
  activePage: integer;
  begin
  activePage := PageControl1.ActivePageIndex;
  //ShowMessage(IntToStr(activePage));
  if activePage = 2 then RepBoxScroll.SetFocus;  

end;

procedure TForm1.FormShow(Sender: TObject);
begin
  StringGrid1.Cells[0,0] := 'ID';
  StringGrid1.Cells[1,0] := 'Faction';
  StringGrid1.Cells[2,0] := 'Standing';
  StringGrid1.Cells[3,0] := 'Current';
  StringGrid1.Cells[4,0] := 'Max';
  StringGrid1.Cells[5,0] := 'Completed';
  StringGrid1.Cells[6,0] := 'Cat';
  StringGrid1.Cells[7,0] := 'Sub Cat';
end;

procedure TForm1.RepBoxScrollMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  TScrollBox(Sender).Perform(WM_VSCROLL,1,0);
end;

procedure TForm1.RepBoxScrollMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  TScrollBox(Sender).Perform(WM_VSCROLL,0,0);
end;

procedure TForm1.Settings1Click(Sender: TObject);
var
  settings: TfrmSettings;
begin
  settings := TfrmSettings.Create(Self);
  settings.Show;

end;

procedure TForm1.spdbtnPriSpecClick(Sender: TObject);
var
  I: integer;
begin
  for I := 0 to Panel3.ControlCount -1 do
  begin
    TSpeedButton(Panel2.Controls[I]).Down := false;
  end;
  grpBxPriTal.Visible := true;
  grpBxSecTal.Visible := false;
end;

procedure TForm1.spdbtnSecSpecClick(Sender: TObject);
var
  I: integer;
begin

//  spdTal11.Down := false;
  for I := 0 to Panel3.ControlCount -1 do
  begin
    TSpeedButton(Panel3.Controls[I]).Down := false;
  end;


  grpBxPriTal.Visible := false;
  grpBxSecTal.Visible := true;

end;

procedure TForm1.TalentClickExecute(Sender: TObject);
var
//  executerNumber: string;
  executerFound: boolean;
  buttonsChecked,executerNumber: integer;
  talentToUse: TWoWIndividualTalent;
begin
  executerFound := false;
  buttonsChecked := -1;

  if not executerFound then
  begin
    executerFound := spdTal11.Down;
    executerNumber := 11;
  end;
  if not executerFound then
  begin
    executerFound := spdTal12.Down;
    executerNumber := 12;
  end;
  if not executerFound then
  begin
    executerFound := spdTal13.Down;
    executerNumber := 13;
  end;
  if not executerFound then
  begin
    executerFound := spdTal14.Down;
    executerNumber := 14;
  end;
  if not executerFound then
  begin
    executerFound := spdTal15.Down;
    executerNumber := 15;
  end;
  if not executerFound then
  begin
    executerFound := spdTal16.Down;
    executerNumber := 16;
  end;
  if not executerFound then
  begin
    executerFound := spdTal21.Down;
    executerNumber := 21;
  end;
  if not executerFound then
  begin
    executerFound := spdTal22.Down;
    executerNumber := 22;
  end;
  if not executerFound then
  begin
    executerFound := spdTal23.Down;
    executerNumber := 23;
  end;
  if not executerFound then
  begin
    executerFound := spdTal24.Down;
    executerNumber := 24;
  end;
  if not executerFound then
  begin
    executerFound := spdTal25.Down;
    executerNumber := 25;
  end;
  if not executerFound then
  begin
    executerFound := spdTal26.Down;
    executerNumber := 26;
  end;

  case executerNumber of
  11: talentToUse := WoWCharacter.Stats.PrimaryTalents.TalentsString.FirstTier;
  12: talentToUse := WoWCharacter.Stats.PrimaryTalents.TalentsString.SecondTier;
  13: talentToUse := WoWCharacter.Stats.PrimaryTalents.TalentsString.ThirdTier;
  14: talentToUse := WoWCharacter.Stats.PrimaryTalents.TalentsString.FourthTier;
  15: talentToUse := WoWCharacter.Stats.PrimaryTalents.TalentsString.FifthTier;
  16: talentToUse := WoWCharacter.Stats.PrimaryTalents.TalentsString.SixthTier;

  21: talentToUse := WoWCharacter.Stats.SecondaryTalents.TalentsString.FirstTier;
  22: talentToUse := WoWCharacter.Stats.SecondaryTalents.TalentsString.SecondTier;
  23: talentToUse := WoWCharacter.Stats.SecondaryTalents.TalentsString.ThirdTier;
  24: talentToUse := WoWCharacter.Stats.SecondaryTalents.TalentsString.FourthTier;
  25: talentToUse := WoWCharacter.Stats.SecondaryTalents.TalentsString.FifthTier;
  26: talentToUse := WoWCharacter.Stats.SecondaryTalents.TalentsString.SixthTier;

  end;

  lblTalDescription.Caption := talentToUse.Description;
  grpbxTalDesc.Caption := 'Description ' + talentToUse.Name;
  lblCost.Caption := 'Cost: ' + talentToUse.Cost;
  lblCast.Caption := 'Casttime: ' + talentToUse.CastTime;
  lblCooldown.Caption := 'Cooldown: ' + talentToUse.Cooldown;

end;

end.

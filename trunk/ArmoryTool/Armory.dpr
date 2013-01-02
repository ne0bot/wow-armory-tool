program Armory;



uses
  Forms,
  Main in 'Main.pas' {Form1},
  RetrieveData in 'RetrieveData.pas' {ERetrieveCharData},
  WowCharacter in 'WowCharacter.pas',
  WowCharacterStats in 'WowCharacterStats.pas',
  SpecialCharacters in 'SpecialCharacters.pas',
  WoWTalents in 'WoWTalents.pas',
  WowCharacterTalentSpec in 'WowCharacterTalentSpec.pas',
  superobject in 'superobject.pas',
  superxmlparser in 'superxmlparser.pas',
  WowFaction in 'WowFaction.pas',
  colpick in 'colpick.pas' {Form3},
  WoWIndividualTalent in 'WoWIndividualTalent.pas',
  WowCharLoadingForm in 'WowCharLoadingForm.pas' {Form4},
  WowCharacterItems in 'WowCharacterItems.pas',
  WowItem in 'WowItem.pas',
  WowItemStats in 'WowItemStats.pas',
  WowItemStatConverter in 'WowItemStatConverter.pas',
  Settings in 'Settings.pas' {frmSettings};

{$R *.res}




begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.

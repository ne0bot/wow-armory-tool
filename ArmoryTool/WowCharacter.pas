unit WowCharacter;

interface
uses
  WowCharacterStats, WowCharacterItems, superobject, Dialogs, sysutils;

type
  TWowChar = Class(TObject)

  private
    FRegion: string;
    FCharacterName: string;
    FCharacterRealm: string;
    FJsonData: ISuperObject;
    FStats: TWowCharStats;
    FItems: TWowCharacterItems;

  public

    constructor Create(const ARegion: string; AJson: ISuperObject);
    function InitiateCharCreation(JSON: ISuperObject): Boolean;

    property Region: string read FRegion;
    property Name: string read FCharacterName;
    property Realm: string read FCharacterRealm;
    property Json: ISuperObject read FJsonData;
    property Stats: TWowCharStats read FStats;
    property Items: TWowCharacterItems read FItems;

  End;


implementation
uses
  Main;
{TWowChar}

constructor TWowChar.Create(const ARegion: string; AJson: ISuperObject);
begin
  FRegion := ARegion;
  FJsonData := AJson;
  InitiateCharCreation(FJsonData);

end;

function TWowChar.InitiateCharCreation(JSON: ISuperObject): Boolean;
var
  tmpitems: ISuperObject;
begin
  FCharacterName := JSON.AsObject.S['name'];
  FCharacterRealm := JSON.AsObject.S['realm'];
  FStats := TWowCharStats.Create(JSON);
  FItems := TWowCharacterItems.Create(JSON);
  Result := true;//Form1.CreateWowCharFromJson(JSON);
end;

end.


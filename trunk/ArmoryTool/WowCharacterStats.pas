unit WowCharacterStats;

interface
uses
  SysUtils, Contnrs, Dialogs, Classes, System.Generics.Defaults, Generics.Collections, WowTalents, WowCharacterTalentSpec, WowFaction, superobject;

type
  myObjectList = TObjectList<TFaction>;
  TWowCharStats = Class(TObject)

  private
    FTalents: TWowCharacterTalentSpec;
    FPrimaryTalents: TWowCharacterTalentSpec;
    FSecondaryTalents: TWowCharacterTalentSpec;
    FLevel: string;
    FClass: string;
    FClassInt: integer;
    FRace: string;
    FHealth: integer;
    FPowerAmount: integer;
    FPowerType: string;
    FIntellect: integer;
    FStrength: integer;
    FStamina: integer;
    FAgility: integer;
    FSpirit: integer;
    FMastery: integer;
    FTalentsString: TWowTalents;
    FReputation: TList<TObjectList>;
    FProfileImage: string;
  public

    constructor Create(const AData: ISuperObject);

    property Talents: TWowCharacterTalentSpec read FTalents;
    property PrimaryTalents: TWowCharacterTalentSpec read FPrimaryTalents;
    property SecondaryTalents: TWowCharacterTalentSpec read FSecondaryTalents;
    property Level: string read FLevel;
    property CharClass: string read FClass;
    property CharClassNumber: integer read FClassInt;
    property Race: string read FRace;
    property Health: integer read FHealth;
    property PowerAmount: integer read FPowerAmount;
    property PowerType: string read FPowerType;
    property Intellect: integer read FIntellect;
    property Strength: integer read FStrength;
    property Stamina: integer read FStamina;
    property Agility: integer read FAgility;
    property Spirit: integer read FSpirit;
    property Mastery: integer read FMastery;
    property TalentsString: TWowTalents read FTalentsString;
    property ReputationList: TList<TObjectList> read FReputation;
    property ProfileImage: string read FProfileImage;
  End;



implementation
uses
  Main;
{TWowChar}

function DetermineCharacterClass(classAsNumber: integer):string;
begin
  case classAsNumber of
    1: Result := 'Warrior';
    2: Result := 'Paladin';
    3: Result := 'Hunter';
    4: Result := 'Rogue';
    5: Result := 'Priest';
    6: Result := 'Death Knight';
    7: Result := 'Shaman';
    8: Result := 'Mage';
    9: Result := 'Warlock';
    10: Result := 'Monk';
    11: Result := 'Druid';
  end;
end;

function DetermineCharacterRace(raceAsNumber: integer): string;
begin
  case raceAsNumber of
    1: Result := 'Human';
    2: Result := 'Orc';
    3: Result := 'Dwarf';
    4: Result := 'Night Elf';
    5: Result := 'Undead';
    6: Result := 'Tauren';
    7: Result := 'Gnome';
    8: Result := 'Troll';
    9: Result := 'Goblin';
    10: Result := 'Blood Elf';
    11: Result := 'Draenei';
    22: Result := 'Worgen';
    24: Result := 'Pandaran(neutral)';
    25: Result := 'Pandaran(alliance)';
    26: Result := 'Pandaran(horde)';
  end;
end;

function CompareNames(faction1, faction2: Pointer): integer;
begin
  Result := CompareText(TFaction(faction1).FactionName, TFaction(faction2).FactionName);
end;

function CompareSubCat(faction1, faction2: Pointer): integer;
begin
  Result := CompareText(TFaction(faction1).SubCategory, TFaction(faction2).SubCategory);
end;



constructor TWowCharStats.Create(const AData: ISuperObject);
var
  dictItem: TPair<string,string>;
  dictKey, talentInfo, selOne, selTwo, FactionCat, thumbnail: string;
  tmpTalents, mainTalents, specOne, specTwo, stats, tmpRep: ISuperObject;
  factionCount, I, n, thumbnailDelimiter: integer;
  tmpFaction: ISuperObject;
  factionList, factionsMop, factionsCata, factionsWotlk, factionsTbc,
  factionsClassic, factionsGuild, factionsUnknown: TObjectList;
  tempFaction: TFaction;
  repCollection: TList<TObjectList>;
begin
  thumbnail := AData.AsObject.S['thumbnail'];
  thumbnailDelimiter := LastDelimiter('-', thumbnail);
  FProfileImage := Copy(thumbnail,1, thumbnailDelimiter) + 'profilemain.jpg';
  FLevel := AData.AsObject.S['level'];

  FClass := DetermineCharacterClass(AData.AsObject.I['class']);
  FClassInt := AData.AsObject.I['class'];
  FRace := DetermineCharacterRace(AData.AsObject.I['race']);
  stats := SO(AData.AsObject.S['stats']);
  FHealth := stats.AsObject.I['health'];
  FPowerAmount := stats.AsObject.I['power'];
  FPowerType := stats.AsObject.S['powerType'];
  FIntellect := stats.AsObject.I['int'];
  FStrength := stats.AsObject.I['str'];
  FStamina := stats.AsObject.I['sta'];
  FAgility := stats.AsObject.I['agi'];
  FSpirit := stats.AsObject.I['spr'];
  FMastery := stats.AsObject.I['mastery'];
  tmpTalents := SO(AData.AsObject.S['talents']);
  specOne := SO(tmpTalents.AsArray.S[0]);
  specTwo := SO(tmpTalents.AsArray.S[1]);


  FPrimaryTalents := TWowCharacterTalentSpec.Create(specOne, CharClassNumber, true);
  FSecondaryTalents := TWowCharacterTalentSpec.Create(specTwo, CharClassNumber, false);

  tmpRep := SO(AData.AsObject.S['reputation']);
  factionCount := tmpRep.AsArray.Length;

  factionList := TObjectList.Create;
  factionsMop := TObjectList.Create; 
  factionsCata := TObjectList.Create; 
  factionsWotlk := TObjectList.Create;
  factionsTbc := TObjectList.Create;
  factionsClassic := TObjectList.Create; 
  factionsGuild := TObjectList.Create;
  factionsUnknown := TObjectList.Create;
  repCollection := TList<TObjectList>.Create;
  
  try
    for I := 0 to factionCount-1 do
    begin
      tmpFaction:= SO(tmpRep.AsArray.S[I]);
      factionList.Add(TFaction.Create(tmpFaction));
    end;
  finally
    
    factionList.Sort(@CompareNames);
    for I := 0 to factionCount-1 do
    begin
      tempFaction := factionList[I] as TFaction;
      FactionCat := tempFaction.Category;
      //Cataclysm,Wrath of the Lich King,The Burning Crusade,Classic
      if FactionCat = 'Mists of Pandaria' then factionsMop.Add(tempFaction)
      else if FactionCat = 'Cataclysm' then factionsCata.Add(tempFaction)
      else if FactionCat = 'Wrath of the Lich King' then factionsWotlk.Add(tempFaction)
      else if FactionCat = 'The Burning Crusade' then factionsTbc.Add(tempFaction)
      else if FactionCat = 'Classic' then factionsClassic.Add(tempFaction)
      else if FactionCat = 'Guild' then factionsGuild.Add(tempFaction)
      else if FactionCat = 'Unknown' then factionsUnknown.Add(tempFaction)
    end;
    repCollection.Add(factionsMop);
    repCollection.Add(factionsCata);
    repCollection.Add(factionsWotlk);
    repCollection.Add(factionsTbc);
    repCollection.Add(factionsClassic);
    repCollection.Add(factionsGuild);
    repCollection.Add(factionsUnknown);

    for I := 0 to repCollection.Count -1 do repCollection[I].Sort(@CompareSubCat);
      
    FReputation := repCollection;
  end;

end;

end.


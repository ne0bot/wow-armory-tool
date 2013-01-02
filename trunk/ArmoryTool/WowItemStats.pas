unit WowItemStats;

interface
uses
  WowCharacterStats, superobject, sysutils, Dialogs, Generics.Collections,
  WowItemStatConverter, classes;

type
  TWowItemStats = Class(TObject)

  private
    FArmor: string;
    FStat1:  string;
    FStat2:  string;
    FStat3:  string;
    FStat4:  string;
    FStat5:  string;
    FStat6:  string;
    FStat7:  string;
    FStat8:  string;
    FStat9:  string;
    FStat10:  string;
    FEffect1:  string;
    FEffect2:  string;
    FEffect3:  string;
    FEffect4:  string;
    FEffect5:  string;
    FEffect6:  string;
    FEffect7:  string;
    FEffect8:  string;
    FEffect9:  string;
    FEffect10:  string;

  public

    constructor Create(const AItemStats: ISuperObject);
    procedure assignDefaultValues;

    property Armor: string read FArmor;
    property Stat1: string read FStat1;
    property Stat2: string read FStat2;
    property Stat3: string read FStat3;
    property Stat4: string read FStat4;
    property Stat5: string read FStat5;
    property Stat6: string read FStat6;
    property Stat7: string read FStat7;
    property Stat8: string read FStat8;
    property Stat9: string read FStat9;
    property Stat10: string read FStat10;
    property Effect1: string read FEffect1;
    property Effect2: string read FEffect2;
    property Effect3: string read FEffect3;
    property Effect4: string read FEffect4;
    property Effect5: string read FEffect5;
    property Effect6: string read FEffect6;
    property Effect7: string read FEffect7;
    property Effect8: string read FEffect8;
    property Effect9: string read FEffect9;
    property Effect10: string read FEffect10;
  End;


implementation
uses
  Main;
{TWowChar}

procedure TWowItemStats.assignDefaultValues;
begin
  FArmor := 'none';
  FStat1 := 'none';
  FStat2 := 'none';
  FStat3 := 'none';
  FStat4 := 'none';
  FStat5 := 'none';
  FStat6 := 'none';
  FStat7 := 'none';
  FStat8 := 'none';
  FStat9 := 'none';
  FStat10 := 'none';
  FEffect1 := 'none';
  FEffect2 := 'none';
  FEffect3 := 'none';
  FEffect4 := 'none';
  FEffect5 := 'none';
  FEffect6 := 'none';
  FEffect7 := 'none';
  FEffect8 := 'none';
  FEffect9 := 'none';
  FEffect10 := 'none';

end;

function CreateStatDict: TDictionary<integer,string>;
begin
  Result := TDictionary<integer,string>.Create;
  Result.Add(1, '+%s Health');
  Result.Add(2, '+%s Mana');
  Result.Add(3, '+%s Agility');
  Result.Add(4, '+%s Strength');
  Result.Add(5, '+%s Intellect');
  Result.Add(6, '+%s Spirit');
  Result.Add(7, '+%s Stamina');
  Result.Add(46, 'Equip: Restores %s health per 5 sec.');
  Result.Add(44, 'Equip: Increases your armor penetration rating by %s.');
  Result.Add(38, 'Equip: Increases attack power by %s.');
  Result.Add(15, 'Equip: Increases your shield block rating by %s.');
  Result.Add(48, 'Equip: Increases the block value of your shield by %s.');
  Result.Add(19, 'Equip: Improves melee critical strike rating by %s.');
  Result.Add(20, 'Equip: Improves ranged critical strike rating by %s.');
  Result.Add(32, 'Equip: Increases your critical strike rating by %s.');
  Result.Add(21, 'Equip: Improves spell critical strike rating by %s.');
  Result.Add(25, 'Equip: Improves melee critical avoidance rating by %s.');
  Result.Add(26, 'Equip: Improves ranged critical avoidance rating by %s.');
  Result.Add(34, 'Equip: Improves critical avoidance rating by %s.');
  Result.Add(27, 'Equip: Improves spell critical avoidance rating by %s.');
  Result.Add(12, 'Equip: Increases defense rating by %s.');
  Result.Add(13, 'Equip: Increases your dodge rating by %s.');
  Result.Add(37, 'Equip: Increases your expertise rating by %s.');
  Result.Add(40, 'Equip: Increases attack power by %s in Cat, Bear, Dire Bear, and Moonkin forms only.');
  Result.Add(28, 'Equip: Improves melee haste rating by %s.');
  Result.Add(29, 'Equip: Improves ranged haste rating by %s.');
  Result.Add(36, 'Equip: Increases your haste rating by %s.');
  Result.Add(30, 'Equip: Improves spell haste rating by %s.');
  Result.Add(16, 'Equip: Improves melee hit rating by %s.');
  Result.Add(17, 'Equip: Improves ranged hit rating by %s.');
  Result.Add(31, 'Equip: Increases your hit rating by %s.');
  Result.Add(18, 'Equip: Improves spell hit rating by %s.');
  Result.Add(22, 'Equip: Improves melee hit avoidance rating by %s.');
  Result.Add(23, 'Equip: Improves ranged hit avoidance rating by %s.');
  Result.Add(33, 'Equip: Improves hit avoidance rating by %s.');
  Result.Add(24, 'Equip: Improves spell hit avoidance rating by %s.');
  Result.Add(43, 'Equip: Restores %s mana per 5 sec.');
  Result.Add(49, 'Equip: Increases your mastery rating by %s.');
  Result.Add(14, 'Equip: Increases your parry rating by %s.');
  Result.Add(39, 'Equip: Increases ranged attack power by %s.');
  Result.Add(35, 'Equip: Increases your resilience rating by %s.');
  Result.Add(41, 'Equip: Increases damage done by magical spells and effects by up to %s.');
  Result.Add(42, 'Equip: Increases healing done by magical spells and effects by up to %s.');
  Result.Add(47, 'Equip: Increases spell penetration by %s.');
  Result.Add(45, 'Equip: Increases spell power by %s.');
end;

function GetItemDetailsFromAPI(itemId: integer): ISuperObject;
var
  memoryStream: TMemoryStream;
  obj: ISuperObject;
  APIUrl: string;
begin
  APIUrl := 'http://eu.battle.net/api/wow/item/' + IntToStr(itemId);
  memoryStream := TMemoryStream.Create;
  try
    Form1.ItemInfoChecker.Get(APIUrl, memoryStream);
    memoryStream.Position := 0;
    if memoryStream <> nil then
    begin
      obj := TSuperObject.ParseStream(memoryStream, true);
    end;
  finally
    memoryStream.Free;
  end;
  Result := obj;
end;

function GetSpellTrigger(trigger:string):string;
begin
  if trigger = 'ON_USE' then Result := 'Use: '
  else if trigger = 'ON_EQUIP' then Result := 'Equip: '
  else Result := 'Unknown: '
end;

constructor TWowItemStats.Create(const AItemStats: ISuperObject);
var
  tmpItem, tmpStat, tmpSpell, tmpSpellDetails, itemStats, itemSpells: ISuperObject;
  statCount, I, X, statToFill: integer;
  statDict: TDictionary<integer, string>;
  dictItem: TPair<integer,string>;
  need: boolean;
  trigger: string;
begin
  need:= true;
  statToFill := 1;
//  statDict := TDictionary<integer, string>.Create;
  statDict := CreateStatDict;
  tmpItem := GetItemDetailsFromAPI(AItemStats.AsObject.I['id']);
  itemStats := SO(tmpItem.AsObject.S['bonusStats']);
  itemSpells := SO(tmpItem.AsObject.S['itemSpells']);
  statCount := itemStats.AsArray.Length;

  FArmor := tmpItem.AsObject.S['armor'];

  for dictItem in statDict do
  begin
    for I := 0 to statCount -1 do
    begin
      tmpStat := SO(itemStats.AsArray.S[I]);
      if dictItem.Key = tmpStat.AsObject.I['stat'] then
      begin
        case I of
        0: FStat1 := StringReplace(dictItem.Value,'%s', tmpStat.AsObject.S['amount'], [rfReplaceAll]);
        1: FStat2 := StringReplace(dictItem.Value,'%s', tmpStat.AsObject.S['amount'], [rfReplaceAll]);
        2: FStat3 := StringReplace(dictItem.Value,'%s', tmpStat.AsObject.S['amount'], [rfReplaceAll]);
        3: FStat4 := StringReplace(dictItem.Value,'%s', tmpStat.AsObject.S['amount'], [rfReplaceAll]);
        4: FStat5 := StringReplace(dictItem.Value,'%s', tmpStat.AsObject.S['amount'], [rfReplaceAll]);
        5: FStat6 := StringReplace(dictItem.Value,'%s', tmpStat.AsObject.S['amount'], [rfReplaceAll]);
        6: FStat7 := StringReplace(dictItem.Value,'%s', tmpStat.AsObject.S['amount'], [rfReplaceAll]);
        7: FStat8 := StringReplace(dictItem.Value,'%s', tmpStat.AsObject.S['amount'], [rfReplaceAll]);
        8: FStat9 := StringReplace(dictItem.Value,'%s', tmpStat.AsObject.S['amount'], [rfReplaceAll]);
        9: FStat10 := StringReplace(dictItem.Value,'%s', tmpStat.AsObject.S['amount'], [rfReplaceAll]);
        end;
      end;
      statToFill := I;
    end;
  end;

  for X := 0 to itemSpells.AsArray.Length -1 do
  begin
    tmpSpell := SO(itemSpells.AsArray.S[X]);
    tmpSpellDetails := SO(tmpSpell.AsObject.S['spell']);
    trigger := GetSpellTrigger(tmpSpell.AsObject.S['trigger']);
    ShowMessage(trigger + tmpSpellDetails.AsObject.S['description']);
    case X of
    0: FEffect1 := trigger + tmpSpellDetails.AsObject.S['description'];
    1: FEffect2 := trigger + tmpSpellDetails.AsObject.S['description'];
    2: FEffect3 := trigger + tmpSpellDetails.AsObject.S['description'];
    3: FEffect4 := trigger + tmpSpellDetails.AsObject.S['description'];
    4: FEffect5 := trigger + tmpSpellDetails.AsObject.S['description'];
    5: FEffect6 := trigger + tmpSpellDetails.AsObject.S['description'];
    6: FEffect7 := trigger + tmpSpellDetails.AsObject.S['description'];
    7: FEffect8 := trigger + tmpSpellDetails.AsObject.S['description'];
    8: FEffect9 := trigger + tmpSpellDetails.AsObject.S['description'];
    9: FEffect10 := trigger + tmpSpellDetails.AsObject.S['description'];
    end;
  end;
  statDict.Destroy;
end;

end.


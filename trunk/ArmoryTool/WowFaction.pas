unit WowFaction;

interface
uses
  superobject, Graphics, SysUtils;

type
  TFaction = Class(TObject)

  private
    FFactionId: string;
    FFactionName: string;
    FFactionStanding: integer;
    FFactionStandingStr: string;
    FStandingColor: TColor;
    FCurrentRep: integer;
    FMaxRep: integer;
    FPercentCompleted: double;
    FCategory: string;
    FSubCategory: string;
  public

    constructor Create(const AFaction: ISuperObject);

    property FactionId: string read FFactionId;
    property FactionName: string read FFactionName;
    property FactionStanding: integer read FFactionStanding;
    property FactionStandingStr: string read FFactionStandingStr;
    property StandingColor: TColor read FStandingColor;
    property CurrentRep: integer read FCurrentRep;
    property MaxRep: integer read FMaxRep;
    property PercentCompleted: double read FPercentCompleted;
    property Category: string read FCategory;
    property SubCategory: string read FSubCategory;

  End;


implementation
uses
  Main;
{TWowChar}

function DetermineStandingString(standing, maxrep: integer): string;
begin
  case standing of
    0:
    begin
      if maxrep > 8400 then result := 'Hated'
      else result := 'Stranger';
    end;

    1: result := 'Hostile';
    2: result := 'Unfriendly';
    3: result := 'Neutral';
    4: result := 'Friendly';
    5: result := 'Honoured';
    6: result := 'Revered';
    7: result := 'Exalted';
  end;
end;

function DetermineStandingColor(standing: integer): TColor;
begin
  case standing of
  0,1,2: Result := 160;
  3: Result := $0000ACD2;
  4,5,6: Result := $0001AB51;
  7: Result := $0073BF00;

  else Result:= clLime;

  end;
end;

function DetermineRepCategory(factionId: integer): string;
begin
  case factionId of
  1375, 1269, 1271, 1270,
  1216, 1302, 1341, 1359,
  1337, 1345, 1272, 1277,
  1275, 1283, 1282, 1281,
  1279, 1273, 1276, 1278,
  1280, 1376: Result := 'Mists of Pandaria';

  1204, 1172, 1158, 1178,
  1173, 1135, 1171, 1174,
  1177: Result := 'Cataclysm';

  1106, 1090, 1098, 1156,
  1073, 1119, 1091, 1052,
  1067, 1124, 1064, 1085,
  1104, 1105, 1126, 1050,
  1094, 1037, 1068: Result := 'Wrath of the Lich King';

  1012, 942, 989, 1015,
  1038, 970, 933, 941,
  990, 967, 947, 922,
  1011, 1031, 1077, 932,
  934, 935, 978, 946: Result := 'The Burning Crusade';

  529, 87, 910, 609, 909,
  92, 749, 93, 349, 809,
  70, 59, 576, 270, 1133,
  530, 1352, 76, 911, 81,
  68, 1374, 729, 510, 889,
  21, 577, 369, 470, 72,
  730, 890, 509, 589, 1353,
  69, 930, 1419, 47, 1134, 54: Result := 'Classic';

  1168: Result := 'Guild';
  else Result := 'Unknown'
  end;

end;

function DetermineRepSubCategory(factionId: integer): string;
begin
  case factionId of
  1277, 1275, 1283, 1282, 1281,
  1279, 1273, 1276, 1278, 1280: Result := 'The Tillers';

  1067, 1124, 1064, 1085: Result := 'Horde Expidition';
  1126, 1050, 1094, 1068: Result := 'Alliance Vanguard';
  1104, 1105: Result := 'Sholazar Basin';

  1011, 1031, 1077, 932,
  934, 935: Result := 'Shattrath City';

  1133, 530, 1352, 76,
  911, 81, 68: Result := 'Horde';

  1353, 69, 930, 47,
  1134, 54: Result := 'Alliance';

  1374, 729, 510, 889: Result := 'Horde Forces';
  730, 890, 509, 1419: Result := 'Alliance Forces';
  21, 577, 369, 470: Result := 'Steemwheedle Cartel';

  else Result := 'None';

  end;

end;

constructor TFaction.Create(const AFaction: ISuperObject);
begin
//haha
  FFactionId := AFaction.AsObject.S['id'];
  FFactionName := AFaction.AsObject.S['name'];
  FFactionStanding := AFaction.AsObject.I['standing'];
  FCurrentRep := AFaction.AsObject.I['value'];
  FMaxRep := AFaction.AsObject.I['max'];
  FPercentCompleted := (CurrentRep/MaxRep) * 100;
  FFactionStandingStr := DetermineStandingString(FactionStanding, MaxRep);
  FStandingColor := DetermineStandingColor(FactionStanding);
  FCategory := DetermineRepCategory(StrToInt(FactionId));
  FSubCategory := DetermineRepSubCategory(StrToInt(FactionId));
end;

function Compare(faction1, faction2: Pointer): integer;
begin
  Result := CompareText(TFaction(faction1).FactionName, TFaction(faction2).FactionName);
end;


end.


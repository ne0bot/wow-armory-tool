unit WowCharacterTalentSpec;

interface
uses
  SysUtils, WowTalents, superobject;

type
  TWowCharacterTalentSpec = Class(TObject)

  private
    FTalentBuild: string;
    FTalentsString: TWowTalents;
    FTalentSpecName: string;
    FSpecRole: string;
    FIsSelected: boolean;
    FIsPrimary: boolean;
  public

    constructor Create(const ATalentInfo: ISuperObject; AClassNumber: integer; APrimary: boolean);

    property TalentBuild: string read FTalentBuild;
    property TalentsString: TWowTalents read FTalentsString;
    property TalentSpecName: string read FTalentSpecName;
    property SpecRole: string read FSpecRole;
    property IsSelected: boolean read FIsSelected;
    property IsPrimary: boolean read FIsPrimary;
  End;


implementation
uses
  Main;
{TWowChar}


function CreateSpec(specString: string):string;
var
  TalentString{, justTalents}: string;
  calcTalentPos: integer;
begin
  TalentString := specString;

  TalentString := StringReplace(TalentString, '.', 'X,', [rfReplaceAll]);
  TalentString := StringReplace(TalentString, '0', '0,', [rfReplaceAll]);
  TalentString := StringReplace(TalentString, '1', '1,', [rfReplaceAll]);
  TalentString := StringReplace(TalentString, '2', '2,', [rfReplaceAll]);
  TalentString := Copy(TalentString, 1, Length(TalentString) -1);

  Result := TalentString;

end;



constructor TWowCharacterTalentSpec.Create(const ATalentInfo: ISuperObject; AClassNumber: integer; APrimary: boolean);
var
  specialisation: ISuperObject;
  seperator: integer;
begin
  FTalentBuild := CreateSpec(ATalentInfo.AsObject.S['calcTalent']);
  FTalentsString := TWowTalents.Create(ATalentInfo);
  specialisation := SO(ATalentInfo.AsObject.S['spec']);
  FTalentSpecName := specialisation.AsObject.S['name'];
  FSpecRole := specialisation.AsObject.S['role'];
  FIsSelected := ATalentInfo.AsObject.B['selected'];
  FIsPrimary := APrimary;
end;

end.


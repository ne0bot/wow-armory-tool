unit WoWTalents;

interface
uses
  SysUtils, superobject, WoWIndividualTalent;

type
  TWowTalents = Class(TObject)

  private
    FCharClass: integer;
    FFirstTier: TWoWIndividualTalent;
    FSecondTier: TWoWIndividualTalent;
    FThirdTier: TWoWIndividualTalent;
    FFourthTier: TWoWIndividualTalent;
    FFifthTier: TWoWIndividualTalent;
    FSixthTier: TWoWIndividualTalent;
    FTalentsString: string;

  public

//    constructor Create(const AClass: integer; ATalents: string);
      constructor Create(const ATalents: ISuperObject);

    property CharClass: integer read FCharClass;
    property FirstTier: TWoWIndividualTalent read FFirstTier;
    property SecondTier: TWoWIndividualTalent read FSecondTier;
    property ThirdTier: TWoWIndividualTalent read FThirdTier;
    property FourthTier: TWoWIndividualTalent read FFourthTier;
    property FifthTier: TWoWIndividualTalent read FFifthTier;
    property SixthTier: TWoWIndividualTalent read FSixthTier;
    property TalentsString: string read FTalentsString;

  End;


implementation
uses
  Main;
{TWowChar}

constructor TWowTalents.Create(const ATalents: ISuperObject);
var
  talentObject, talentTier, talentSpell: ISuperObject;
  I: integer;
  firstTier, secondTier, thirdTier, fourthTier, fifthTier, sixthTier: string;
  emptyTal: TWoWIndividualTalent;
begin

  emptyTal := TWoWIndividualTalent.Create(SO('{"id": -1, "name": "None", '+
              '"icon": "X","description": "None", "powerCost": "None", '+
              '"castTime": "None", "cooldown": "None"}'));
  FFirstTier := emptyTal;
  FSecondTier := emptyTal;
  FThirdTier := emptyTal;
  FFourthTier := emptyTal;
  FFifthTier := emptyTal;
  FSixthTier := emptyTal;
  talentObject := SO(ATalents.AsObject.S['talents']);
  for I := 0 to talentObject.AsArray.Length -1 do
    begin
      talentTier := SO(talentObject.AsArray.S[I]);
      talentSpell := SO(talentTier.AsObject.S['spell']);
      case talentTier.AsObject.I['tier'] of
      0: FFirstTier := TWoWIndividualTalent.Create(talentSpell);
      1: FSecondTier := TWoWIndividualTalent.Create(talentSpell);
      2: FThirdTier := TWoWIndividualTalent.Create(talentSpell);
      3: FFourthTier := TWoWIndividualTalent.Create(talentSpell);
      4: FFifthTier := TWoWIndividualTalent.Create(talentSpell);
      5: FSixthTier := TWoWIndividualTalent.Create(talentSpell);
    end;
  end;
end;


end.


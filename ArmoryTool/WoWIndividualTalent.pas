unit WoWIndividualTalent;

interface
uses
  SysUtils, superobject, Dialogs;

type
  TWoWIndividualTalent = Class(TObject)

  private
    FSpellId: integer;
    FSpellName: string;
    FSpellIcon: string;
    FSpellDescription: string;
    FSpellCost: string;
    FSpellCastTime: string;
    FSpellCooldown: string;


  public


    constructor Create(const ATalent: ISuperObject);

    property SpellId: integer read FSpellId;
    property Name: string read FSpellName;
    property Icon: string read FSpellIcon;
    property Description: string read FSpellDescription;
    property Cost: string read FSpellCost;
    property CastTime: string read FSpellCastTime;
    property Cooldown: string read FSpellCooldown;

  End;


implementation
uses
  Main;
{TWowChar}

constructor TWoWIndividualTalent.Create(const ATalent: ISuperObject);
begin

  FSpellId := ATalent.AsObject.I['id'];
  FSpellName := ATalent.AsObject.S['name'];
  FSpellIcon := ATalent.AsObject.S['icon'];
  FSpellDescription := ATalent.AsObject.S['description'];
  FSpellCost := ATalent.AsObject.S['powerCost'];
  FSpellCastTime := ATalent.AsObject.S['castTime'];
  FSpellCooldown := ATalent.AsObject.S['cooldown'];
end;


end.


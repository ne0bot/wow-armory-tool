unit WowItem;

interface
uses
  WowCharacterStats, superobject, WowItemStats, Dialogs, sysutils;

type
  TWowItem = Class(TObject)

  private
    FSlot: string;
    FItemId: integer;
    FItemName: string;
    FItemIcon: string;
    FItemStats: TWowItemStats;

  public

    constructor Create(const AItem: ISuperObject; ASlot: string);

    property Slot: string read FSlot;
    property ItemId: integer read FItemId;
    property ItemName: string read FItemName;
    property ItemIcon: string read FItemIcon;
    property ItemStats: TWowItemStats read FItemStats;

  End;


implementation
uses
  Main;
{TWowChar}

constructor TWowItem.Create(const AItem: ISuperObject; ASlot: string);
begin
  FSlot := ASlot;
  FItemId := AItem.AsObject.I['id'];
  FItemName := AItem.AsObject.S['name'];
  FItemIcon := AItem.AsObject.S['icon'];

  if FItemId > -1 then
  begin
    FItemStats := TWowItemStats.Create(AItem);
  end;
end;

end.


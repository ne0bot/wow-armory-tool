unit WowCharacterItems;

interface
uses
  WowCharacterStats, WowItem, superobject, dialogs, sysutils;

type
  TWowCharacterItems = Class(TObject)

  private
    FHead: TWowItem;
    FNeck: TWowItem;
    FShoulder: TWowItem;
    FBack: TWowItem;
    FChest: TWowItem;
    FShirt: TWowItem;
    FTabard: TWowItem;
    FWrist: TWowItem;
    FHands: TWowItem;
    FWaist: TWowItem;
    FLegs: TWowItem;
    FFeet: TWowItem;
    FFinger1: TWowItem;
    FFinger2: TWowItem;
    FTrinket1: TWowItem;
    FTrinket2: TWowItem;
    FMainhand: TWowItem;
    FOffhand: TWowItem;
    FAvgIlvl: integer;
    FAvgEquipped: integer;

  public

    constructor Create(const AItems: ISuperObject);
    procedure GenerateEmptyItems();

    property Head: TWowItem read FHead;
    property Neck: TWowItem read FNeck;
    property Shoulder: TWowItem read FShoulder;
    property Back: TWowItem read FBack;
    property Chest: TWowItem read FChest;
    property Shirt: TWowItem read FShirt;
    property Tabard: TWowItem read FTabard;
    property Wrist: TWowItem read FWrist;
    property Hands: TWowItem read FHands;
    property Waist: TWowItem read FWaist;
    property Legs: TWowItem read FLegs;
    property Feet: TWowItem read FFeet;
    property Finger1: TWowItem read FFinger1;
    property Finger2: TWowItem read FFinger2;
    property Trinket1: TWowItem read FTrinket1;
    property Trinket2: TWowItem read FTrinket2;
    property MainHand: TWowItem read FMainhand;
    property Offhand: TWowItem read FOffhand;
    property AvgIlvl: integer read FAvgIlvl;
    property AvgEquipped: integer read FAvgEquipped;


  End;


implementation
uses
  Main;
{TWowChar}

procedure TWowCharacterItems.GenerateEmptyItems();
var
  emptyItem: ISuperObject;
begin
  emptyItem := SO('{"id": -1, "name": "None", '+
              '"icon": "X"}');
  FHead := TWowItem.Create(emptyItem, 'Head');
  FNeck := TWowItem.Create(emptyItem, 'Neck');
  FShoulder := TWowItem.Create(emptyItem, 'Shoulder');
  FBack := TWowItem.Create(emptyItem, 'Back');
  FChest := TWowItem.Create(emptyItem, 'Chest');
  FShirt := TWowItem.Create(emptyItem, 'Shirt');
  FTabard := TWowItem.Create(emptyItem, 'Tabard');
  FWrist := TWowItem.Create(emptyItem, 'Wrist');
  FHands := TWowItem.Create(emptyItem, 'Hands');
  FWaist := TWowItem.Create(emptyItem, 'Waist');
  FLegs := TWowItem.Create(emptyItem, 'Legt');
  FFeet := TWowItem.Create(emptyItem, 'Feet');
  FFinger1 := TWowItem.Create(emptyItem, 'Finger1');
  FFinger2 := TWowItem.Create(emptyItem, 'Finger2');
  FTrinket1 := TWowItem.Create(emptyItem, 'Trinket1');
  FTrinket2 := TWowItem.Create(emptyItem, 'Trinket2');
  FMainhand := TWowItem.Create(emptyItem, 'Mainhand');
  FOffhand := TWowItem.Create(emptyItem, 'Offhand');
end;


constructor TWowCharacterItems.Create(const AItems: ISuperObject);
var
  ItemCount, I: integer;
  myArray: TSuperArray;
  items: ISuperObject;
  Exists: Boolean;

begin
  items := SO(AItems.AsObject.S['items']);
//  ShowMessage(IntToStr(items.AsArray.Length));
  GenerateEmptyItems;
//  Exists := Length(items.AsObject.S['head']) > 0;
//  ShowMessage('Head found: ' + BoolToStr(Exists) + 'Name: ' + SO(items.AsObject.S['head']).AsObject.S['name']);
//  Exists := Length(items.AsObject.S['shirt']) > 0;
//  ShowMessage('Head found: ' + BoolToStr(Exists));


  Exists := Length(items.AsObject.S['head']) > 0;
  if Exists then FHead := TWowItem.Create(SO(items.AsObject.S['head']), 'Head');

  Exists := Length(items.AsObject.S['neck']) > 0;
  if Exists then FNeck := TWowItem.Create(SO(items.AsObject.S['neck']), 'Neck');

  Exists := Length(items.AsObject.S['shoulder']) > 0;
  if Exists then FShoulder := TWowItem.Create(SO(items.AsObject.S['shoulder']), 'Shoulder');

  Exists := Length(items.AsObject.S['back']) > 0;
  if Exists then FBack := TWowItem.Create(SO(items.AsObject.S['back']), 'Back');

  Exists := Length(items.AsObject.S['chest']) > 0;
  if Exists then FChest := TWowItem.Create(SO(items.AsObject.S['chest']), 'Chest');

  Exists := Length(items.AsObject.S['shirt']) > 0;
  if Exists then FShirt := TWowItem.Create(SO(items.AsObject.S['shirt']), 'Shirt');

  Exists := Length(items.AsObject.S['tabard']) > 0;
  if Exists then FTabard := TWowItem.Create(SO(items.AsObject.S['tabard']), 'Tabard');

  Exists := Length(items.AsObject.S['wrist']) > 0;
  if Exists then FWrist := TWowItem.Create(SO(items.AsObject.S['wrist']), 'Wrist');

  Exists := Length(items.AsObject.S['hands']) > 0;
  if Exists then FHands := TWowItem.Create(SO(items.AsObject.S['hands']), 'Hands');

  Exists := Length(items.AsObject.S['waist']) > 0;
  if Exists then FWaist := TWowItem.Create(SO(items.AsObject.S['waist']), 'Waist');

  Exists := Length(items.AsObject.S['legs']) > 0;
  if Exists then FLegs := TWowItem.Create(SO(items.AsObject.S['legs']), 'Legt');

  Exists := Length(items.AsObject.S['feet']) > 0;
  if Exists then FFeet := TWowItem.Create(SO(items.AsObject.S['feet']), 'Feet');

  Exists := Length(items.AsObject.S['finger1']) > 0;
  if Exists then FFinger1 := TWowItem.Create(SO(items.AsObject.S['finger1']), 'Finger1');

  Exists := Length(items.AsObject.S['finger2']) > 0;
  if Exists then FFinger2 := TWowItem.Create(SO(items.AsObject.S['finger2']), 'Finger2');

  Exists := Length(items.AsObject.S['trinket1']) > 0;
  if Exists then FTrinket1 := TWowItem.Create(SO(items.AsObject.S['trinket1']), 'Trinket1');

  Exists := Length(items.AsObject.S['trinket2']) > 0;
  if Exists then FTrinket2 := TWowItem.Create(SO(items.AsObject.S['trinket2']), 'Trinket2');

  Exists := Length(items.AsObject.S['mainHand']) > 0;
  if Exists then FMainhand := TWowItem.Create(SO(items.AsObject.S['mainHand']), 'Mainhand');

  Exists := Length(items.AsObject.S['offHand']) > 0;
  if Exists then FOffhand := TWowItem.Create(SO(items.AsObject.S['offHand']), 'Offhand');

  FAvgIlvl := items.AsObject.I['averageItemLevel'];
  FAvgEquipped := items.AsObject.I['averageItemLevelEquipped'];

end;

end.


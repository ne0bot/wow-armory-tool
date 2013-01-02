unit WowItemStatConverter;

interface
uses
  WowCharacterStats, superobject, SysUtils, Generics.Collections;

type
  TWowItemStatConverter = Class(TObject)

  private

  public

    function CreateItemStatDict(need: boolean): TDictionary<integer, string>;

  End;

implementation
uses
  Main;
{TWowChar}

function TWowItemStatConverter.CreateItemStatDict(need: boolean): TDictionary<integer, string>;
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

end.


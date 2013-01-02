unit SpecialCharacters;

interface
uses
  SysUtils, Generics.Collections;

  function FormatName(originalName: string): string;
  //function CreateSpecialCharDict(): TDictionary<string,string>;

implementation
uses
  Main;
{TWowChar}

function CreateSpecialCharDict: TDictionary<string, string>;
//var
  //dict: TDictionary<string,string>;
begin
  Result := TDictionary<string,string>.Create;
  Result.Add('�', '%C3%80');
  Result.Add('�', '%C3%81');
  Result.Add('�', '%C3%82');
  Result.Add('�', '%C3%83');
  Result.Add('�', '%C3%84');
  Result.Add('�', '%C3%85');
  Result.Add('�', '%C3%86');
  Result.Add('�', '%C3%87');
  Result.Add('�', '%C3%88');
  Result.Add('�', '%C3%89');
  Result.Add('�', '%C3%8A');
  Result.Add('�', '%C3%8B');
  Result.Add('�', '%C3%8C');
  Result.Add('�', '%C3%8D');
  Result.Add('�', '%C3%8E');
  Result.Add('�', '%C3%8F');
  Result.Add('�', '%C3%90');
  Result.Add('�', '%C3%91');
  Result.Add('�', '%C3%92');
  Result.Add('�', '%C3%93');
  Result.Add('�', '%C3%94');
  Result.Add('�', '%C3%95');
  Result.Add('�', '%C3%96');
  Result.Add('�', '%C3%98');
  Result.Add('�', '%C3%99');
  Result.Add('�', '%C3%9A');
  Result.Add('�', '%C3%9B');
  Result.Add('�', '%C3%9C');
  Result.Add('�', '%C3%9D');
  Result.Add('�', '%C3%9E');
  Result.Add('�', '%C3%9F');
  Result.Add('�', '%C3%A0');
  Result.Add('�', '%C3%A1');
  Result.Add('�', '%C3%A2');
  Result.Add('�', '%C3%A3');
  Result.Add('�', '%C3%A4');
  Result.Add('�', '%C3%A5');
  Result.Add('�', '%C3%A6');
  Result.Add('�', '%C3%A7');
  Result.Add('�', '%C3%A8');
  Result.Add('�', '%C3%A9');
  Result.Add('�', '%C3%AA');
  Result.Add('�', '%C3%AB');
  Result.Add('�', '%C3%AC');
  Result.Add('�', '%C3%AD');
  Result.Add('�', '%C3%AE');
  Result.Add('�', '%C3%AF');
  Result.Add('�', '%C3%B0');
  Result.Add('�', '%C3%B1');
  Result.Add('�', '%C3%B2');
  Result.Add('�', '%C3%B3');
  Result.Add('�', '%C3%B4');
  Result.Add('�', '%C3%B5');
  Result.Add('�', '%C3%B6');
  Result.Add('�', '%C3%B8');
  Result.Add('�', '%C3%B9');
  Result.Add('�', '%C3%BA');
  Result.Add('�', '%C3%BB');
  Result.Add('�', '%C3%BC');
  Result.Add('�', '%C3%BD');
  Result.Add('�', '%C3%BE');
  Result.Add('�', '%C3%BF');

end;

function FormatName(originalName: string): string;
var
  specialCharDict: TDictionary<string, string>;
  dictItem: TPair<string,string>;
  formattedName: string;
  characterPos: integer;
begin
  formattedName := originalName;
  specialCharDict := (CreateSpecialCharDict);
  for dictItem in specialCharDict do
    begin
      characterPos := LastDelimiter(dictItem.Key, originalName);
      if characterPos > 0 then
        formattedName := StringReplace(formattedName, dictItem.Key, dictItem.Value, [rfReplaceAll]);
    end;
  Result := formattedName;
end;

end.


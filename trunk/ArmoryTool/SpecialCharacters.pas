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
  Result.Add('À', '%C3%80');
  Result.Add('Á', '%C3%81');
  Result.Add('Â', '%C3%82');
  Result.Add('Ã', '%C3%83');
  Result.Add('Ä', '%C3%84');
  Result.Add('Å', '%C3%85');
  Result.Add('Æ', '%C3%86');
  Result.Add('Ç', '%C3%87');
  Result.Add('È', '%C3%88');
  Result.Add('É', '%C3%89');
  Result.Add('Ê', '%C3%8A');
  Result.Add('Ë', '%C3%8B');
  Result.Add('Ì', '%C3%8C');
  Result.Add('Í', '%C3%8D');
  Result.Add('Î', '%C3%8E');
  Result.Add('Ï', '%C3%8F');
  Result.Add('Ð', '%C3%90');
  Result.Add('Ñ', '%C3%91');
  Result.Add('Ò', '%C3%92');
  Result.Add('Ó', '%C3%93');
  Result.Add('Ô', '%C3%94');
  Result.Add('Õ', '%C3%95');
  Result.Add('Ö', '%C3%96');
  Result.Add('Ø', '%C3%98');
  Result.Add('Ù', '%C3%99');
  Result.Add('Ú', '%C3%9A');
  Result.Add('Û', '%C3%9B');
  Result.Add('Ü', '%C3%9C');
  Result.Add('Ý', '%C3%9D');
  Result.Add('Þ', '%C3%9E');
  Result.Add('ß', '%C3%9F');
  Result.Add('à', '%C3%A0');
  Result.Add('á', '%C3%A1');
  Result.Add('â', '%C3%A2');
  Result.Add('ã', '%C3%A3');
  Result.Add('ä', '%C3%A4');
  Result.Add('å', '%C3%A5');
  Result.Add('æ', '%C3%A6');
  Result.Add('ç', '%C3%A7');
  Result.Add('è', '%C3%A8');
  Result.Add('é', '%C3%A9');
  Result.Add('ê', '%C3%AA');
  Result.Add('ë', '%C3%AB');
  Result.Add('ì', '%C3%AC');
  Result.Add('í', '%C3%AD');
  Result.Add('î', '%C3%AE');
  Result.Add('ï', '%C3%AF');
  Result.Add('ð', '%C3%B0');
  Result.Add('ñ', '%C3%B1');
  Result.Add('ò', '%C3%B2');
  Result.Add('ó', '%C3%B3');
  Result.Add('ô', '%C3%B4');
  Result.Add('õ', '%C3%B5');
  Result.Add('ö', '%C3%B6');
  Result.Add('ø', '%C3%B8');
  Result.Add('ù', '%C3%B9');
  Result.Add('ú', '%C3%BA');
  Result.Add('û', '%C3%BB');
  Result.Add('ü', '%C3%BC');
  Result.Add('ý', '%C3%BD');
  Result.Add('þ', '%C3%BE');
  Result.Add('ÿ', '%C3%BF');

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


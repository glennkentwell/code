program Whatever;
uses crt;
var
  X: integer;
  C: char;
begin
  Clrscr;
  Repeat
    C:= ReadKey;
    For X:= 1 to 2000 do
      Write(Chr(Random(26) + 97));
  Until C = #27;
end.
program Dir;
var
  X: integer;

function LeadingZero(w : Word) : String;
var
  s : String;
begin
  Str(w:0,s);
  if Length(s) = 1 then
    s := '0' + s;
  LeadingZero := s;
end;

begin
  Repeat
    For X:= 1 to 8 do
      Write(Chr(Random(26) + 65));
    Write('.');
    For X:= 1 to 3 do
      Write(Chr(Random(26) + 65));
    Write(Random(22000):15);
    Write(' ');
    Write(LeadingZero(Random(12)):2);
    Write('-');
    Write(LeadingZero(Random(31)):2);
    Write('-');
    Write(Random(8) + 90);
    Write(Random(12):4);
    Write(':');
    Write(Random(60):2);
    Writeln('a');
  Until X = -1;
end.

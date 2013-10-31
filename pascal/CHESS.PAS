program Yeah;
uses Crt;
var
  X, Y, Z: integer;
  BlackOrWhite: Boolean;

begin
  ClrScr;
  Window(28, 8,52, 16);
  For Y:= 1 to 8 do
    begin
      Writeln;
      For X:= 1 to 8 do
        Write(#15#15,' ');
    end;
end.

program i;
uses Crt;
var
  Ch: char;
procedure One;
begin
  asm
    mov ax, 014h       { this is for 160x25 }
    int 10h
  end;
  Readln;
end;

procedure Two;
begin
  asm
    mov ax, 054h       { this is for 150x50}
    int 10h
  end;
  Readln;
end;

begin
  Writeln('[1]  160x25');
  Writeln('[2]  160x50');
  Ch:= ReadKey;
  if Ch = '1' then One;
  if Ch = '2' then Two;
end.

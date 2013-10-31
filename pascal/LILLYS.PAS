uses crt;
var x,y:integer;
s:string;
begin
clrscr;
writeln('Start Typing');
readln(s);
textbackground(red);
textcolor(blue);
clrscr;
for y:=1 to 25 do
begin
for x:= 1 to 40 do
begin
  gotoxy(x,y);
  write (s);
  delay(10);
  gotoxy(x,y);
  write(' ');
end;
  write (s);
end;
readkey;
end.
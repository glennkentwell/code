
uses crt;
var x,y:integer;
begin
x:=30;
y:=20;
textcolor(lightred);
textbackground(green);
clrscr;
for y:=1 to 25 do
begin
for x:=1 to 40 do
begin
gotoxy(x,y);
write('this will probably turn out very dumb?');
delay(10);
gotoxy(x,y);
write(' ');
end;
end;
end.
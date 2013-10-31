{$e+,n-}
uses crt;

var
screen: byte absolute $a000:000;
scr: array[1..64000] of byte;
h,j,k,J1:longint;
l,gd: INTEGER;
gm,col: byte;

procedure dither;
begin
for j:=320 to 63680 do
scr[j]:=(scr[j-319]+scr[j-321]+scr[j+321]
+scr[j+319]
) shr 2;
end;

procedure setpal(c: byte;r,g,b:byte);
begin
port[$3c8]:=c;
port[$3c9]:=r;
port[$3c9]:=g;
port[$3c9]:=b;
end;

begin
randomize;
clrscr;
write('Enter a speed 0..20 (20=fast): ');
readln(h);
h:=20-h;
asm
mov ah, 00
mov al, $13
int 10h
end;
for l:=0 to 256 do
setpal(l,0,0,0);
FOR J:=0 TO 319 DO
begin
for j1:= 0 to 199 do
begin
gm:=((ABS(159-j))+(ABS(99-j1)) SHR 1) XOR j1;
{gm:=((((abs(j-159)*abs(99-j1))div (63)) + ((ABS(159-j))+(ABS(99-j1)) SHR 1)) shr 1)xor j1;
{IF GM=256 THEN GM:= 255;}
{gm:= (abs(159-j)*abs(99-j1)) - (j1) ;}
if gm=0 then gm:=1;
scr[j1*320+J]:=gm;
end;
end;
FOR J1:= 1 TO 4 DO dither;
move(scr,screen,64000);
j:=-2;
repeat
RANDOMIZE;
inc(j,1);
for l:=7 To 254  do
begin
IF KEYPRESSED THEN H:=0;
port[$3c8]:=l+1;
port[$3c9]:=random(40);
port[$3c9]:=random(60);
port[$3c9]:=53;
Setpal(l-6,0,0,l shr 4);
delay(h);
END;
for l:=250 to 255 do
setpal(l,0,0,0);
for l:=249 downTo 2  do
begin
IF KEYPRESSED THEN H:=0;
port[$3c8]:=l-1;
port[$3c9]:=random(40);
port[$3c9]:=random(60);
port[$3c9]:=53;
Setpal(l+6,0,0,l shr 4);
delay(h);
END;
for l:=255 downto 250 do
setpal(l,0,0,0);
if j=1 then j:=-2;
until keypressed;
readkey;
asm
mov ah,00
mov al, $03
int 10h
end;
clrscr;
textmode(3);
textcolor(13);
gotoxy(30,12);
writeln('By Neil Hartner');
readkey;
end.
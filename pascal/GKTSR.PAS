{$M $800,0,0 }   { 2K stack, no heap }
{ This program causes a click each time
 a key is pressed.}
uses Crt, Dos;
var
  KbdIntVec : Procedure;
  Ch: char;
{$F+}
procedure Keyclick; interrupt;
begin
  if Port[$60] < $80 then
    { Only click when key is pressed }
    begin
    Sound(5000);
    Delay(1);
    Ch:= ReadKey;
    if Ch = #27 then Nosound;
     end;
  inline ($9C); { PUSHF -- Push flags }
  { Call old ISR using saved vector }
  KbdIntVec;
end;
{$F-}
begin
  { Insert ISR into keyboard chain }
  GetIntVec($9,@KbdIntVec);
  SetIntVec($9,Addr(Keyclick));
  Keep(0); { Terminate, stay resident }
end.

program KeyPer;
Uses Dos, Crt;
Var
  Ch: char;

begin
  GoToXY(10, 10); Write('Glenn''s TSR');
  Keep(3);
  if KeyPressed then Ch:= ReadKey;
  if Ch = #27 then
  ClrScr;
end.
Program Starfield;
Uses Crt, Graph, GrafBits;
Const
   OT : array[0..4] of shortint = (0, 1, -1, 2, -2);
type
  TPixel = object
    XPos, YPos, Rad: integer;
    Colour : Word;
    procedure GiveMeLife;
    procedure WhatDoIDo;
    procedure EraseMe;
    procedure DrawMe;
  end;

Var
  No, Ex, Why : integer;
  Del, Sz, DivX, DivY : integer;
  Bit: array[1..900] of TPixel;
  Bits, Co : integer;



procedure TPixel.GiveMeLife;
Const Col: array[0..1] of integer = (4, 12);
begin
  XPos := Random(99) - 50;
  YPos := Random(99) - 50;
  Rad := 1;
  if XPos = 0 then XPos := OT[Random(3) + 1];
  if YPos = 0 then YPos := OT[Random(3) + 1];
  Colour := Random(15);
end;

procedure TPixel.WhatDoIDo;
begin
  Inc(XPos,XPos div 4 + OT[Random(2)]);
  Inc(YPos,YPos div 4 + OT[Random(2)]);
  if Abs(XPos) > DivX div 4 then Rad := 2;
  if Abs(YPos) > DivY div 4 then Rad := 2;
  if Abs(XPos) > DivX div 2 then Rad := 3;
  if Abs(YPos) > DivY div 2 then Rad := 3;
  if Abs(XPos) > DivX then
  begin
    Bit[Co].GiveMeLife;
  end;
end;

procedure TPixel.DrawMe;
begin
  Point(DivX + XPos, DivY + YPos, Rad, Colour);
end;

procedure TPixel.EraseMe;
begin
  Point(DivX + XPos, DivY + YPos, Rad, 0);
end;

procedure Explosion;
begin
  Randomize;
  For Co := 1 to Bits do
  begin
    Bit[Co].GiveMeLife;
  end;
  Repeat
  if KeyPressed then Break;
  For Co := 1 to Bits do
  begin
    Bit[Co].DrawMe;
  end;
  For Co := 1 to Bits do
  begin
    Bit[Co].EraseMe;
    Bit[Co].WhatDoIDo;
  end;
  Until KeyPressed;{No > Bits div 2;}
  No := 0;
end;

begin
  GraphicsScreen;
  DivX := MaxX div 2;
  DivY := MaxY div 2;
  if ParamCount > 0 then
  begin
    Val(ParamStr(1), Bits, Co);
    if Bits = 0 then Bits:= 150;
  end
  else Bits:= 150;
  Sz := 5;
  While not KeyPressed do
    Explosion;
  ReadKey;
  CloseGraph;
end.

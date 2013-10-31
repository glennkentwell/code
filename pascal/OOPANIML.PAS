Program Animals;
Uses Crt, Graph, GrafBits;
Const
   OT : array[0..4] of shortint = (0, 1, -1, 2, -2);
   Bits = 100;
type
  TAnimal = object
    XSize, YSize,
    XPos , YPos : integer;
    Pic : Pointer;
    procedure ReadFrom(FString: string; XS, YS: integer);
    procedure MoveTo(X, Y : integer);
    procedure Erase;
  end;

  TPixel = object
    XPos, YPos, Rad: integer;
    Colour : Word;
    procedure GiveMeLife;
    procedure WhatDoIDo;
    procedure EraseMe;
    procedure DrawMe;
  end;

Var
  Dog, Cat: TAnimal;
  No, Ex, Why : integer;
  Del, Sz, DvX, DvY : integer;
  Bit: array[1..Bits] of TPixel;

procedure TPixel.GiveMeLife;
Const Col: array[0..1] of integer = (4, 12);
begin
  XPos := Random(9) - 5;
  YPos := Random(9) - 5;
  Rad := Random(Sz) + 1;
  if XPos = 0 then XPos := OT[Random(3) + 1];
  if YPos = 0 then YPos := OT[Random(3) + 1];
  Colour := Col[Random(1)];
end;

procedure TPixel.WhatDoIDo;
begin
  if XPos < 0 then Dec(XPos, Random(Abs(XPos)) + OT[Random(2)])
    else Inc(XPos,Random(Abs(XPos)) + OT[Random(2)]);
  if YPos < 0 then Dec(YPos, Random(Abs(YPos)) + OT[Random(2)])
    else Inc(YPos,Random(Abs(YPos)) + OT[Random(2)]);
  if XPos > GetMaxX then Inc(No);
end;

procedure TPixel.DrawMe;
begin
  Point(DvX + XPos, DvY + YPos, Rad, Colour);
end;

procedure TPixel.EraseMe;
begin
  Point(DvX + XPos, DvY + YPos, Rad, 0);
end;

procedure Explosion;
Var Co : integer;
    S : string;
begin
  Randomize;
  For Co := 1 to Bits do
  begin
    Bit[Co].GiveMeLife;
  end;
  Repeat
  if KeyPressed then Break;
  For Co := 1 to Bits do
    Bit[Co].DrawMe;
  For Co := 1 to Bits do
  begin
{    Bit[Co].EraseMe;}
    Bit[Co].WhatDoIDo;
  end;
  Until No > Bits div 2;
  No := 0;
end;

procedure TAnimal.ReadFrom(FString: string; XS, YS: integer);
Var
  F: file;
  Size, Result: Word;
begin
  XSize := XS;
  YSize := YS;
  Size:= ImageSize(0, 0, XS, YS);
  GetMem(Pic, Size);
  Assign(F, FString);
  Reset(F, Size);
  BlockRead(F, Pic^, 1, Result);
  Close(F);
end;

procedure TAnimal.MoveTo(X, Y : integer);
begin
  XPos := X;
  YPos := Y;
  PutImage(X, Y, Pic^, XORPut);
end;

procedure TAnimal.Erase;
begin
  PutImage(XPos, YPos, Pic^, XORPut);
end;

procedure CheckForCollisions;
begin
  if Why > DivY - 5 then
    if Why < DivY + 5 then
  begin
    Sound(0); Delay(0);
    Explosion;
    ClearDevice;
    Cat.MoveTo(DivX, Why);
    Dog.MoveTo(Ex, DivY);
  end;
  NoSound;
end;

procedure GetDel;
Var Code : Word;
begin
  Val(ParamStr(1), Del, Code);
  Val(ParamStr(2), Sz, Code);
  if ParamStr(2) = '' then Sz := 5;
end;

begin
  GraphicsScreen('');
  Cat.ReadFrom('CAT.PIC', 40, 40);
  Dog.ReadFrom('DOG.PIC', 75, 50);
  DvX := DivX + 15;
  DvY := DivY + 15;
  GetDel;
  While not KeyPressed do
  begin
    While Why <= GetMaxY - 40 do
    begin
      Cat.MoveTo(DivX, Why);
      Dog.MoveTo(Ex, DivY);
      CheckForCollisions;
      Delay(Del);
      Cat.Erase;
      Dog.Erase;
      if KeyPressed then Break;
      Inc(Why, 10);
      Inc(Ex, 13);
    end;
    While Why >= 0 do
    begin
      Cat.MoveTo(DivX, Why);
      Dog.MoveTo(Ex, DivY);
      CheckForCollisions;
      Delay(Del);
      Cat.Erase;
      Dog.Erase;
      if KeyPressed then Break;
      Dec(Why, 10);
      Dec(Ex, 13);
    end;
    Why := 0;
    Ex := 0;
  end;
  ReadKey;
  CloseGraph;
end.










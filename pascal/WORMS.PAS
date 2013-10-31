program WormBlits;

Uses Graph, Crt, GrafBits, WormPics;

const
  North: array[1..3] of Byte = (1, 2, 8);
  NorthEast: array[1..3] of Byte = (1, 2, 3);
  East: array[1..3] of Byte = (2, 3, 4);
  SouthEast: array[1..3] of Byte = (3, 4, 5);
  South: array[1..3] of Byte = (4, 5, 6);
  SouthWest: array[1..3] of Byte = (5, 6, 7);
  West: array[1..3] of Byte = (6, 7, 8);
  NorthWest: array[1..3] of Byte = (7, 8, 1);
  MaxSegs = 140;
  MaximumWorms = 200;

type
  TWorm = object
    NoFoodMoves,
    GenDirection, Direction: byte;
    Pos: array[1..MaxSegs, 1..2] of integer;
    NumSegs, Head, Tail: integer;
    Col: Word;
    Alive: Boolean;
    procedure IAmBorn;
    procedure WhereDoIGo;
    procedure DrawMyHead;
    procedure EraseMyTail;
    procedure TestForEdges;
  end;

Var
  I,
  Gd, Gm,
  WormCount, FoodCount,
  NumWorms, Survivors,
  X, Y: integer;
  Ch: char;
  Size: Word;
  MemWorm: TWorm;
  Worm: array[1..1000] of ^TWorm;
  MaxWorms, MinSegs,
  MoveDist, NumFoods, MaxNoFood: integer;

procedure TWorm.IAmBorn;
begin
  Alive:= True;
  X:= Random(DivX) + DivX div 2;
  Y:= Random(DivY) + DivY div 2;
  Col:= LightRed;
  if Col = 0 then Col:= 6;
  NumSegs:= Random(MaxSegs);
  SetColor(Col);
  SetFillStyle(1, Col);
  For I:= 1 to NumSegs do
  begin
    Pos[I, 1]:= X;
    Pos[I, 2]:= Y;
    FillEllipse(Pos[I, 1], Pos[I, 2], 2, 2);
    PutPixel(Pos[I, 1] + 1, Pos[I, 2] + 1, Red);
    PutPixel(Pos[I, 1] - 1, Pos[I, 2] - 1, Red);
    Inc(X, MoveDist);
    Inc(Y, Random(MoveDist * 2) - MoveDist);
  end;
  Tail:= NumSegs;
  Head:= 1;
  GenDirection:= Random(8) + 1;
  NoFoodMoves:= 0;
end;


procedure TWorm.TestForEdges;
begin
  if Pos[Head, 1] >= MaxX then
    if GenDirection = 2 then GenDirection:= West[Random(3) + 1]
    else if GenDirection = 3 then GenDirection:= West[Random(3) + 1]
      else if GenDirection = 4 then GenDirection:= West[Random(3) + 1];
  if Pos[Head, 2] >= MaxY then
    if GenDirection = 4 then GenDirection:= North[Random(3) + 1]
    else if GenDirection = 5 then GenDirection:= North[Random(3) + 1]
      else if GenDirection = 6 then GenDirection:= North[Random(3) + 1];
  if Pos[Head, 1] <= 0 then
    if GenDirection = 6 then GenDirection:= East[Random(3) + 1]
    else if GenDirection = 7 then GenDirection:= East[Random(3) + 1]
      else if GenDirection = 8 then GenDirection:= East[Random(3) + 1];
  if Pos[Head, 2] <= 0 then
    if GenDirection = 1 then GenDirection:= South[Random(3) + 1]
    else if GenDirection = 2 then GenDirection:= South[Random(3) + 1]
      else if GenDirection = 8 then GenDirection:= South[Random(3) + 1];
end;

procedure NewWorm;
begin
  Inc(NumWorms);
  Worm[NumWorms]^.IAmBorn;
end;

function Direct(Dir: Byte): Byte;
begin
  Case Dir of
    1: Direct:= North[Random(3) + 1];
    2: Direct:= NorthEast[Random(3) + 1];
    3: Direct:= East[Random(3) + 1];
    4: Direct:= SouthEast[Random(3) + 1];
    5: Direct:= South[Random(3) + 1];
    6: Direct:= SouthWest[Random(3) + 1];
    7: Direct:= West[Random(3) + 1];
    8: Direct:= NorthWest[Random(3) + 1];
  end;
end;

procedure TWorm.WhereDoIGo;
begin
  For I:= NumSegs downto 2 do
  begin
    Pos[I, 1]:= Pos[I - 1, 1];
    Pos[I, 2]:= Pos[I - 1, 2];
  end;
  Direction:= Direct(GenDirection);
  TestForEdges;
  Case Direction of
    1: Dec(Pos[Head, 2], MoveDist);  { North }
    2:
    begin
      Inc(Pos[Head, 1], MoveDist);   { North - East }
      Dec(Pos[Head, 2], MoveDist);
    end;
    3: Inc(Pos[Head, 1], MoveDist);  { East }
    4:
    begin
      Inc(Pos[Head, 1], MoveDist);  { South - East }
      Inc(Pos[Head, 2], MoveDist);
    end;
    5: Inc(Pos[Head, 2], MoveDist);  { South }
    6:
    begin
      Dec(Pos[Head, 1], MoveDist);  { South West }
      Inc(Pos[Head, 2], MoveDist);
    end;
    7: Dec(Pos[Head, 1], MoveDist);  { West }
    8:
    begin
      Dec(Pos[Head, 1], MoveDist);   { North - West }
      Dec(Pos[Head, 2], MoveDist);
    end;
  end;
end;

procedure TWorm.DrawMyHead;
begin
  SetColor(Col);
  SetFillStyle(1, Col);
  FillEllipse(Pos[Head, 1], Pos[Head, 2], 2, 2);
  PutPixel(Pos[I, 1] + 1, Pos[I, 2] + 1, Red);
  PutPixel(Pos[I, 1] - 1, Pos[I, 2] - 1, Red);
end;

procedure TWorm.EraseMyTail;
begin
  SetColor(Black);
  SetFillStyle(1, Black);
  FillEllipse(Pos[Tail, 1], Pos[Tail, 2], 2, 2);
end;

procedure InitGraphics;
begin
  GraphicsScreen;
  ScreenVars;
  SetFillStyle(1, Black);
  Bar(0, 0, MaxX, MaxY);
end;

procedure EnterStuff;
var
  Code: integer;
  S: string;
begin
  MoveDist:= 3;
  NumFoods:= 200;
  NumWorms:= 30;
  MoveDist:= 3;
end;

procedure RunTheThing;
begin
  InitGraphics;
  MemWorm.IAmBorn;
  CloseGraph;
  Repeat
    EnterStuff;
    MinSegs:= 3;
    Survivors:= NumWorms;
    InitGraphics;
    For WormCount:= 1 to NumWorms do
    begin
      GetMem(Worm[WormCount], SizeOf(MemWorm));
      Worm[WormCount]^.IAmBorn;
      Worm[Wormcount]^.EraseMyTail;
    end;
    if MoveDist <> -1 then
    While (not KeyPressed) and (Survivors > 0) do
    begin
    For WormCount:= 1 to NumWorms do
      begin
        Worm[Wormcount]^.DrawMyHead;
        Worm[Wormcount]^.WhereDoIGo;
        Worm[Wormcount]^.EraseMyTail;
      end;
    end;
    CloseGraph;
    if KeyPressed then Ch:= ReadKey;
  Until (MoveDist = -1) or (Ch = #27);
end;

begin
  Randomize;
  RunTheThing;
end.


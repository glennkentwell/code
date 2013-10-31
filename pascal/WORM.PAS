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
    procedure EatFood;
    procedure Die;
    procedure Multiply;
    function AliveOrNot: Boolean;
  end;

  TFood = object
    Pos: array[1..2] of integer;
    procedure NewFood;
    procedure EatenFood;
    procedure DrawFood;
    function XPos: integer;
    function YPos: integer;
  end;

  TBird = object
    JumpDistance,
    XPos, YPos: integer;
    PicSize: Word;
    Place, Image: Pointer;
    procedure DrawBird;
    procedure FindAPlace;
    procedure JumpToPlace;
  end;


Var
  I,
  Gd, Gm,
  BirdCount,
  WormCount, FoodCount,
  NumWorms, Survivors,
  X, Y: integer;
  Ch: char;
  Size: Word;
  MemWorm: TWorm;
  Worm: array[1..1000] of ^TWorm;
  Food: array[1..1000] of TFood;
  Bird: array[1..5] of TBird;
  MaxWorms, MinSegs,
  MoveDist, NumFoods, MaxNoFood: integer;

procedure TFood.NewFood;
begin
  Pos[1]:= Random(MaxX);
  Pos[2]:= Random(MaxY);
  PutPixel(Pos[1], Pos[2], Green);
  PutPixel(Pos[1] - 1, Pos[2] - 1, Green);
  PutPixel(Pos[1] + 1, Pos[2] - 1, Green);
  PutPixel(Pos[1] + 1, Pos[2] + 1, Green);
  PutPixel(Pos[1] - 1, Pos[2] + 1, Green);
end;

procedure TFood.DrawFood;
begin
  PutPixel(Pos[1], Pos[2], Green);
  PutPixel(Pos[1] - 1, Pos[2] - 1, Green);
  PutPixel(Pos[1] + 1, Pos[2] - 1, Green);
  PutPixel(Pos[1] + 1, Pos[2] + 1, Green);
  PutPixel(Pos[1] - 1, Pos[2] + 1, Green);
end;

procedure TFood.EatenFood;
var
  S: integer;
begin
  Pos[1]:= 3000;
  Pos[2]:= 3000;
  For S:= 1 to 10 do
  begin
    Sound(S * 100);
    Delay(1);
  end;
  NoSound;
end;

function TFood.XPos;
begin
  XPos:= Pos[1];
end;

function TFood.YPos;
begin
  YPos:= Pos[2];
end;

function TWorm.AliveOrNot;
begin
  AliveOrNot:= Alive;
end;

procedure TWorm.EatFood;
var
  FoodCounter: integer;
  GotOne: Boolean;
begin
  GotOne:= False;
  For FoodCounter:= 1 to NumFoods do
    if Pos[Head, 1] > Food[FoodCounter].XPos - 3 then
      if Pos[Head, 1] < Food[FoodCounter].XPos + 3 then
        if Pos[Head, 2] < Food[FoodCounter].YPos + 3 then
          if Pos[Head, 2] > Food[FoodCounter].YPos - 3 then
            begin
              Food[FoodCounter].EatenFood;
              Inc(NumSegs);
              if NumSegs > MaxSegs then NumSegs:= MaxSegs;
              Tail:= NumSegs;
              NoFoodMoves:= 0;
              GotOne:= True;
            end;
            if not GotOne then
            begin
              Inc(NoFoodMoves);
              if NoFoodMoves > MaxNoFood then
              begin
                Dec(NumSegs);
                if NumSegs < MinSegs then Die;
                EraseMyTail;
                Tail:= NumSegs;
                NoFoodMoves:= 0;
              end;
            end;
end;

procedure TWorm.IAmBorn;
begin
  Alive:= True;
  X:= Random(DivX) + DivX div 2;
  Y:= Random(DivY) + DivY div 2;
  Col:= LightRed;
  if Col = 0 then Col:= 6;
  NumSegs:= 3;
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

procedure TWorm.Die;
var
  Xx: integer;
begin
  Alive:= False;
  SetColor(Yellow);
  SetFillStyle(1, Red);
  For Xx:= 1 to 20 do
  begin
    FillEllipse(Pos[Head, 1], Pos[Head, 2], Xx, Xx);
    Sound(Xx * 100);
  end;
  NoSound;
  SetColor(Black);
  SetFillStyle(1, Black);
  FillEllipse(Pos[Head, 1], Pos[Head, 2], Xx, Xx);
  Dec(Survivors);
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

procedure TWorm.Multiply;
var
  Z: integer;
begin
  For Z:= NumSegs downto NumSegs div 2 do
    EraseMyTail;
  NumSegs:= NumSegs div 2;
  Sound(500);
  Delay(100);
  NoSound;
  NewWorm;
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

procedure TBird.DrawBird;
begin
  PutPixel(0, 2, Brown);
  PutPixel(1, 2, Brown);
  PutPixel(1, 3, Brown);
  SetColor(Yellow);
  Line(2, 1, 2, 6);
  Line(3, 0, 3, 6);
  Line(4, 1, 4, 7);
  Line(5, 5, 5, 7);
  Line(6, 7, 7, 7);
  PutPixel(6, 6, Yellow);
  SetColor(Brown);
  Line(3, 8, 3, 9);
  PutPixel(2, 9, Brown);
  PicSize:= ImageSize(0, 0, 7, 9);
  GetMem(Image, PicSize);
  GetMem(Place, PicSize);
  GetImage(0, 0, 7, 9, Image^);
  XPos:= Random(MaxX);
  YPos:= Random(MaxY);
  JumpDistance:= 50;
  ClearDevice;
end;

procedure TBird.FindAPlace;
begin
  PutImage(XPos - 4, YPos - 4, Place^, NormalPut);
  Repeat
    XPos:= Random(MaxX);
    YPos:= Random(MaxY);
  Until (XPos > 0) and (XPos < MaxX) and (YPos > 0) and (YPos < MaxY);
end;

procedure TBird.JumpToPlace;
begin
  Dispose(Place);
  GetMem(Place, PicSize);
  GetImage(XPos - 4, YPos - 4, XPos + 3, YPos + 5, Place^);
  PutImage(XPos - 4, YPos - 4, Image^, NormalPut);
end;

procedure InitGraphics;
begin
  GraphicsScreen;
  ScreenVars;
end;

procedure EnterStuff;
var
  Code: integer;
  S: string;
begin
  ClrScr;
  Writeln('                Move distance :                     [ Max = 7 ]');
  Writeln('              Number of foods :                     [ Max = 1000 ]');
  Writeln('   Maximum moves without food : ');
  Writeln('              Number of worms :                     [ Max = 200 ]');
  Writeln;
  Writeln('              Enter "quit" for Move Distance to quit');
  Writeln('  Leave each field blank for the default values');
  GoToXY(33, 1); Readln(S);
  if S <> '' then Val(S, MoveDist, Code) else MoveDist:= 3;
  if (S = 'quit') or (S = 'QUIT') or (S = 'Quit') then MoveDist:= -1;
  GoToXY(33, 2); Readln(S);
  if S <> '' then Val(S, NumFoods, Code) else NumFoods:= 200;
  GoToXY(33, 3); Readln(S);
  if S <> '' then Val(S, MaxNoFood, Code) else MaxNoFood:= MaxX div 10;
  GoToXY(33, 4); Readln(S);
  if S <> '' then Val(S, NumWorms, Code) else NumWorms:= 10;
  if MoveDist > 6 then MoveDist:= 6;
  if NumFoods > 1000 then NumFoods:= 1000;
  if NumWorms > MaximumWorms then NumWorms:= MaximumWorms;
end;

procedure DoBird(Burdee: integer);
begin
    Bird[Burdee].FindAPlace;
    Bird[Burdee].JumpToPlace;
{    For Y:= 1 to 2 do
    For X:= 5 to 10 do
    begin
      Sound(X * 500);
      Delay(20);
    end;
    NoSound;
    Delay(500);}
end;

procedure RunTheThing;
begin
  InitGraphics;
  MemWorm.IAmBorn;
  ClearDevice;
  For BirdCount:= 1 to 5 do Bird[BirdCount].DrawBird;
  CloseGraph;
  Repeat
    EnterStuff;
    MinSegs:= 3;
    Survivors:= NumWorms;
    InitGraphics;
    For FoodCount:= 1 to NumFoods do
      Food[FoodCount].NewFood;
    For WormCount:= 1 to NumWorms do
    begin
      GetMem(Worm[WormCount], SizeOf(MemWorm));
      Worm[WormCount]^.IAmBorn;
      Worm[Wormcount]^.EraseMyTail;
    end;
    if MoveDist <> -1 then
    While (not KeyPressed) and (Survivors > 0) do
    begin
 {    For FoodCount:= 1 to NumFoods do
        Food[FoodCount].DrawFood;
 }     For WormCount:= 1 to NumWorms do
        if Worm[WormCount]^.AliveOrNot = True then
          begin
            Worm[Wormcount]^.DrawMyHead;
            Worm[Wormcount]^.WhereDoIGo;
            Worm[Wormcount]^.EatFood;
            Worm[Wormcount]^.EraseMyTail;
          end;
        For BirdCount:= 1 to 5 do
          DoBird(BirdCount);
    end;
    CloseGraph;
    if KeyPressed then Ch:= ReadKey;
  Until (MoveDist = -1) or (Ch = #27);
end;

begin
  Randomize;
  RunTheThing;
end.


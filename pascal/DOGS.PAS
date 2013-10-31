program Aminals;
uses Crt, Graph, GrafBits, Animals;
const colr = Magenta;
var
  XDir, YDir: Boolean;
  X, Y,
  Gd, Gm: integer;

procedure GetNewDogs;
begin
  DrawStillDog;
  ClearDevice;
  DrawMovingDog;
  ClearDevice;
  Size:= ImageSize(0, 0, 85, 60);
  PutImage(10, 10, Dog^, normalPut);
  Dispose(Dog);
  GetMem(Dog, Size);
  GetImage(0, 0, 85, 60, Dog^);
  ClearDevice;
  PutImage(10, 10, MoveDog^, normalPut);
  Dispose(MoveDog);
  GetMem(MoveDog, Size);
  GetImage(0, 0, 85, 60, MoveDog^);
end;

procedure GetNewCat;
begin
  ClearDevice;
  SetFillStyle(1, Colr);
  FloodFill(1, 1, White);
  DrawCat;
  ClearDevice;
  SetFillStyle(1, Colr);
  FloodFill(1, 1, White);
  Size:= ImageSize(0, 0, 60, 60);
  PutImage(10, 10, Cat^, normalPut);
  Dispose(Cat);
  GetMem(Cat, Size);
  GetImage(0, 0, 85, 60, Cat^);
  SetFillStyle(1, Colr);
  FloodFill(1, 1, White);
end;

begin
  Gd:= VGA;
  Gm:= 2;
  InitGraph(Gd, Gm, '\tp\bgi');
  ScreenVars;
  GetNewDogs;
  GetNewCat;
  ClearDevice;
  SetFillStyle(1, Colr);
  FloodFill(1, 1, White);
  X:= 0;
  Y:= 0;
  XDir:= True;
  YDir:= True;
  While not KeyPressed do
  begin
    If XDir = True then
      Inc(X, 5)
      else Dec(X, 5);
    if X >= MaxX then
      XDir:= False;
    if X <= 0 then
      XDir:= True;
    PutImage(X, Y, Cat^, normalPut);
  end;
  ReadKey;
end.
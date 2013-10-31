program DrawCar;
uses
  Graph, Crt,
  GrafBits;

var
  Car: Pointer;
  Size: Word;
  X, Y, YCh, Ycc: integer;

begin
  GraphicsScreen;
  SetFillStyle(1, LightBlue);
  Bar(0, 18, 78, 42);
  SetFillStyle(1, DarkGray);
  SetColor(Black);
  Line(15, 41, 58, 41);  { driver's side windows }
  Line(20, 40, 50, 40);
  Line(15, 19, 58, 19);  { passenger side windows }
  Line(20, 20, 50, 20);
  Line(10, 20, 10, 40);  { rear window }
  Line(10, 20, 18, 21);
  Line(10, 40, 18, 39);
  Line(18, 39, 18, 21);
  FloodFill(14, 30, Black);
  Line(50, 22, 60, 21);  { front window }
  Line(50, 38, 60, 39);
  Line(60, 39, 60, 21);
  Line(50, 22, 50, 38);
  FloodFill(55, 30, Black);
  PutPixel(78, 18, Black);
  PutPixel(78, 42, Black);
  PutPixel(0, 18, Black);
  PutPixel(0, 42, Black);
  SetColor(Blue);
  Line(65, 30, 75, 30);
  Size:= ImageSize(0, 18, 78, 42);
  GetMem(Car, Size);
  GetImage(0, 18, 78, 42, Car^);
  ClearDevice;
  Bar(0, 0, DivX, DivY);
  SetColor(Black);
  Line(0, 6, 0, 11);
  Line(0, 28, 0, 24);
  PutImage(1, 5, Car^, NormalPut);
  FreeMem(Car, Size);
  SetFillStyle(1, DarkGray);
  Size:= ImageSize(0, 0, 79, 34);
  GetMem(Car, Size);
  GetImage(0, 0, 79, 34, Car^);
  PutImage(DivX, DivY, Car^, NormalPut);
  ReadKey;
  SetFillStyle(1, DarkGray);
  Bar(0, 0, MaxX, MaxY);
  Y:= DivY;
  YCh:= 0;
  Ycc:= 5;
  While not KeyPressed do
  For X:= 1 to MaxX - 80 do
  begin
    Inc(YCh, Ycc);
    if Ych > 10 then Ycc:= -2;
    if Ych < -10 then Ycc:= 2;
    Sound(1000 - Ych);
{200    Delay(0);          }
    PutImage(X, Y + YCh, Car^, NormalPut);
  end;
  NoSound;
  ReadKey;
  CloseGraph;
end.

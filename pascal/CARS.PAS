program Thhthhl;
uses
  Crt, Graph,
  GrafBits, Buttons;

var
  Size: Word;
  HCar, VCar: Pointer;
  Zinc,
  Pitch,
  X, Y, I: integer;
  Ch: char;

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
  PutPixel(78, 18, DarkGray);
  PutPixel(78, 42, DarkGray);
  PutPixel(0, 18, DarkGray);
  PutPixel(0, 42, DarkGray);
  SetColor(Blue);
  Line(65, 30, 75, 30);
  SetFillStyle(1, DarkGray);
  Bar(DivX div 2, 0, MaxX, 100);
  For X:= 0 to 35 do
    For Y:= 18 to 42 do
      PutPixel(DivX + Y, 73 - X, GetPixel(X, Y));
  For X:= 40 to 78 do
    For Y:= 18 to 42 do
      PutPixel(DivX + Y, 73 - X + 5, GetPixel(X, Y));
  Size:= ImageSize(DivX, 0, DivX + 60, 73);
  GetMem(HCar, Size);
  GetMem(VCar, Size);
  GetImage(0, 0, 42, 78, HCar^);
  GetImage(DivX, 0, DivX + 60, 73, VCar^);
  PutImage(DivX, DivY, VCar^, NormalPut);
  ReadKey;
  ClearDevice;
  Bar(DivX div 2, 0, DivX + DivX div 2, MaxY);
  X:= DivX - 30;
  Pitch:= 20;
  Repeat
    if Pitch > 1200 then Pitch:= 200;
    While not KeyPressed do
    For I:= 20 to Pitch do
      Sound(Pitch);
    Delay(Pitch div Pitch div 2);
    PutImage(X, MaxY - 80, VCar^, NormalPut);
    Ch:= ReadKey;
    if Ch = #0 then
    begin
      Ch:= ReadKey;
      Case Ch of
        #77: Inc(X, 5);
        #75: Dec(X, 5);
        #72: Inc(Pitch, 20);
      end;
    end;
  Until Ch = #27;
  NoSound;
  CloseGraph;
end.
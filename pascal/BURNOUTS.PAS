program Thhthhl;
uses
  Crt, Graph,
  GrafBits;

var
  Size: Word;
  Car: Pointer;
  Zinc,
  X, Y, I: integer;

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
  SetColor(Black);
  PutPixel(70, 16, Black);
  Size:= ImageSize(0, 18, 78, 42);
  GetMem(Car, Size);
  GetImage(0, 18, 78, 42, Car^);
  ClearDevice;
  Bar(0, 0, DivX, DivY);
  SetColor(Black);
  Line(0, 6, 0, 11);
  Line(0, 28, 0, 23);
  PutImage(1, 5, Car^, NormalPut);
  FreeMem(Car, Size);
  SetFillStyle(1, DarkGray);
  Size:= ImageSize(0, 0, 79, 34);
  GetMem(Car, Size);
  GetImage(0, 0, 79, 34, Car^);
  PutImage(DivX, DivY, Car^, NormalPut);
  While not KeyPressed do
  begin
  SetFillStyle(1, Green);
  Bar(0, 0, MaxX, MaxY);
  SetFillStyle(1, DarkGray);
  Bar(0, DivY - 25, MaxX, MaxY - DivY div 2);
  SetColor(White);
  X:= 0;
  While X < MaxX do
  begin
    Line(X, DivY + 40, X + 80, DivY + 40);
    Inc(X, 100);
  end;
  Line(0, DivY - 20, MaxX, DivY - 20);
  Line(0, MaxY - DivY div 2 - 5, MaxX, MaxY - DivY div 2 - 5);
  Y:= 0;
  X:= 0;
  PutImage(X, DivY, Car^, NormalPut);
  SetColor(Black);
  SetFillStyle(1, White);
  FillEllipse(60, DivY - 60, 50, 30);
  OutTextXY(40, DivY - 75, 'Pull');
  OutTextXY(20, DivY - 60, 'a burnie!!');
  Delay(1000);
  SetColor(Green);
  SetFillStyle(1, Green);
  FillEllipse(60, DivY - 60, 50, 30);
  SetColor(Black);
  SetFillStyle(1, White);
  FillEllipse(60, DivY + 80, 50, 30);
  OutTextXY(20, DivY + 80, 'No worries!');
  Delay(1000);
  SetColor(DarkGray);
  SetFillStyle(1, DarkGray);
  FillEllipse(60, DivY + 80, 50, 30);
  X:= 0;
  While X < DivX div 4 do
  begin
    Inc(X);
    Inc(Y, 1);
    PutImage(X, DivY, Car^, NormalPut);
      Line(X, DivY, X, DivY + 35);
      Sound(X);
      Delay(X);
  end;
  While X < MaxX - 80 do
  begin
    Inc(X);
    Inc(Y, 1);
    PutImage(X, DivY, Car^, NormalPut);
    if X > DivX then NoSound;
    if X > DivX + DivX div 4 then
    begin
      Line(X, DivY, X, DivY + 35);
      Sound(X div 2);
      Delay(1);
    end
    else
    begin
      if X > DivX then
        Line(X, DivY, X, DivY + 20);
      For I:= 1 to 100 do
        Sound(I * 40);
      Delay(5);
    end;
  end;
  Bar(MaxX - 80, DivY, MaxX, DivY + 35);
  NoSound;
  end;
  ReadKey;
  CloseGraph;
end.

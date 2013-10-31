program Burnout;
uses
  Crt, Graph,
  GrafBits;

var
  Ch: char;
  Size: Word;
  Car: Pointer;
  Cam, Revs,
  LastRevs, Gear,
  X, Y: integer;

procedure GetCar;
begin
  SetFillStyle(1, LightBlue);
  Bar(0, 18, 78, 42);
  SetFillStyle(1, DarkGray);
  SetColor(Black);
  Line(15, 41, 58, 41);  { driver's side windows }
  Line(20, 40, 50, 40);
  Line(15, 19, 58, 19);  { passenger side windows }
  Line(20, 20, 50, 20);
  SetColor(DarkGray);
  For X:= 10 to 13 do
    Line(X, 20, X, 40);
  For X:= 14 to 18 do
    Line(X, 21, X, 39);
  SetColor(Black);
  Line(10, 20, 10, 40);  { rear window }
  Line(10, 20, 18, 21);
  Line(10, 40, 18, 39);
  Line(18, 39, 18, 21);
  FloodFill(14, 30, Black);
  SetColor(DarkGray);
  For X:= 55 to 60 do    { front window }
    Line(X, 21, X, 39);
  For X:= 50 to 55 do
    Line(X, 22, X, 38);
  SetColor(Black);
  Line(50, 22, 60, 21);
  Line(50, 38, 60, 39);
  Line(50, 22, 50, 38);
  Line(60, 21, 60, 39);
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
  X:= 0;
  For Y:= 0 to 42 do
  begin
    X:= 0;
    While X < 80 do
    begin
      PutPixel(Y + 100, 42 - (X div 2), GetPixel(X, Y));
      Inc(X, 2);
    end;
  end;
  Size:= ImageSize(118, 0, 142, 42);
  GetMem(Car, Size);
  GetImage(118, 0, 142, 42, Car^);
end;

var
  S: string;
begin
  VGA256;
  GetCar;
  ClearDevice;
  PutImage(DivX - 12, DivY - 20, Car^, Normalput);
  SetColor(White);
  For Revs:= 1 to 10 do
  begin
    Str(Revs, S);
    OutTextXY(Revs * 15, MaxY - 20, S);
  end;
  Y:= 0;
  Cam:= 150;
  Revs:= 100;
  Gear:= 1;
  While Ch <> #27 do
  begin
  While not KeyPressed do
  For X:= 2 to 4 do
  begin
    Sound(X * Revs);
    Delay(Revs div 33);
    Inc(Y);
    if Y = Cam then
    begin
      NoSound;
      Delay(15);
      Y:= 0;
    end;
  end;
  Ch:= ReadKey;
  Delay(Gear * 5);
  LastRevs:= Revs;
  if Ch = #72 then Inc(Revs, 10);
  if Ch = #80 then Dec(Revs, 10);
  if Revs > 400 then
  begin
    Revs:= 100;
    Inc(Gear);
    if Gear > 5 then
    begin
      Gear:= 5;
      Revs:= 100;
    end;
  end;
  if Gear <> 1 then
  if Revs < 400 then
  begin
    Revs:= 200;
    Dec(Gear);
    if Gear < 1 then
      begin
        Gear:= 1;
        Revs:= 300;
      end;
    end
    else if Revs < 70 then Revs:= 70;
  Cam:= Revs * 10;
  SetColor(Black);
  Line(LastRevs div 3 - 10, MaxY - 10, LastRevs div 3 - 10, MaxY);
  SetColor(Yellow);
  Line(Revs div 3 - 10, MaxY - 10, Revs div 3 - 10, MaxY);
  end;
  NoSound;
  CloseGraph;
end.

program Rectangles;
uses
  Crt, Graph,
  GrafBits;

var
  Num,
  I, X, Y,
  WhichOne,
  XSize, YSize,
  XInc, YInc: integer;
  Ch: char;

procedure DrawBars;
begin
  Inc(X, Xinc);
  Inc(Y, Yinc);
  if X > MaxX - XSize then XInc:= - 1;
  if Y > MaxY - YSize then YInc:= - 1;
  if X < 0 then XInc:= 1;
  if Y < 0 then YInc:= 1;
  SetFillStyle(1, Random(15));
  Bar(X, Y, X + XSize, Y + YSize);
end;

procedure DrawRectangles;
begin
  Inc(X, Xinc);
  Inc(Y, Yinc);
  if X > MaxX - XSize then XInc:= - 1;
  if Y > MaxY - YSize then YInc:= - 1;
  if X < 0 then XInc:= 1;
  if Y < 0 then YInc:= 1;
  SetColor(Random(15));
  Rectangle(X, Y, X + XSize, Y + YSize);
end;

procedure DrawCircles;
begin
  Inc(X, Xinc);
  Inc(Y, Yinc);
  if X > MaxX - XSize then XInc:= - 1;
  if Y > MaxY - YSize then YInc:= - 1;
  if X < XSize then XInc:= 1;
  if Y < YSize then YInc:= 1;
  SetColor(Random(15));
  Ellipse(X, Y, 0, 360, XSize, YSize);
end;

procedure FillCircles;
var
  Col: integer;
begin
  Inc(X, Xinc);
  Inc(Y, Yinc);
  if X > MaxX - XSize then XInc:= - 1;
  if Y > MaxY - YSize then YInc:= - 1;
  if X < XSize then XInc:= 1;
  if Y < YSize then YInc:= 1;
  Col:= Random(15);
  SetColor(Col);
  SetFillStyle(1, Col);
  FillEllipse(X, Y, XSize, YSize);
end;

procedure DrawThem;
begin
  Case WhichOne of
    0: For Num:= 1 to 10000 do
         if not KeyPressed then DrawBars;
    1: For Num:= 1 to 10000 do
         if not KeyPressed then DrawRectangles;
    2: For Num:= 1 to 10000 do
         if not KeyPressed then DrawCircles;
    3: For Num:= 1 to 10000 do
         if not KeyPressed then FillCircles;
  end;
end;

begin
  GraphicsScreen;
  While not KeyPressed do
  begin
    ClearDevice;
    Randomize;
    XInc:= 1;
    YInc:= 1;
    XSize:= Random(50);
    YSize:= Random(50);
    WhichOne:= Random(4);
    DrawThem;
  end;
  Ch:= ReadKey;
  if KeyPressed then Ch:= ReadKey;
  ClearDevice;
  SetColor(LightRed);
  SetTextJustify(1, 1);
  SetTextStyle(10, 0, 5);
  if Ch <> #59 then
  Repeat
  Y:= -30;
  For X:= DivX - 10 to DivX + 10 do
  begin
    Inc(Y);
    SetColor(Random(15));
    OutTextXY(X, DivY div 2 + Y, 'Ha Ha Ha!!');
  end;
  SetColor(Red);
  OutTextXY(X, DivY div 2 + Y, 'Ha Ha Ha!!');
  For I:= 1000 downto 750 do
  begin
    Sound(I);
    Delay(I div 200);
  end;
  NoSound;
  For X:= DivX - 10 to DivX + 10 do
  begin
    Inc(Y);
    SetColor(Random(15));
    OutTextXY(X, DivY + DivY div 3 + Y, 'You thought it was');
  end;
  SetColor(Red);
  For I:= 700 downto 500 do
  begin
    Sound(I);
    Delay(I div 100);
  end;
  OutTextXY(X, DivY + DivY div 3 + Y, 'You thought it was');
  NoSound;
  For X:= DivX - 10 to DivX + 10 do
  begin
    Inc(Y);
    SetColor(Random(15));
    OutTextXY(X, DivY + (DivY div 3) * 2 + Y, 'QuikMenu!!!');
  end;
  SetColor(Red);
  For I:= 450 downto 200 do
  begin
    Sound(I);
    Delay(I div 50);
  end;
  NoSound;
  OutTextXY(X, DivY + (DivY div 3) * 2 + Y, 'QuikMenu!!!');
  Until X = 1;
  CloseGraph;
end.



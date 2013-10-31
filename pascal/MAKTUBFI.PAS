program Pipes;
Uses Graph, Crt, GrafBits;
Var X, Y, ZY, Col : integer;
    XorY : String;
    MaxX, MaxY : integer;
    Size : longint;

procedure DrawTubeLine(Ex, Why, Leng, Col : integer);
begin
  SetColor(Col);
  if XorY = 'Hor' then
  begin
    MoveTo(Ex, GetY + 1);
    LineTo(Ex + Leng, GetY);
  end;
  if XorY = 'Ver' then
  begin
    MoveTo(GetX + 1, Why);
    LineTo(GetX, Why + Leng);
  end;
end;  { DrawTubeLine }

procedure Tube(StartX, StartY, Length : integer; XoY : String);
{              'XoY' = Ver to draw horizontal tube
               'XoY' = Hor to draw vertical tube          }
begin
  XorY := XoY;
  MoveTo(StartX, StartY);
  DrawTubeLine(StartX, StartY, Length, 8);
  DrawTubeLine(StartX, StartY, Length, 0);
  DrawTubeLine(StartX, StartY, Length, 8);
  DrawTubeLine(StartX, StartY, Length, 8);
  DrawTubeLine(StartX, StartY, Length, 7);
  DrawTubeLine(StartX, StartY, Length, 7);
  DrawTubeLine(StartX, StartY, Length, 7);
  DrawTubeLine(StartX, StartY, Length, 15);
  DrawTubeLine(StartX, StartY, Length, 15);
  DrawTubeLine(StartX, StartY, Length, 15);
  DrawTubeLine(StartX, StartY, Length, 15);
  DrawTubeLine(StartX, StartY, Length, 7);
  DrawTubeLine(StartX, StartY, Length, 7);
  DrawTubeLine(StartX, StartY, Length, 7);
  DrawTubeLine(StartX, StartY, Length, 8);
  DrawTubeLine(StartX, StartY, Length, 8);
  DrawTubeLine(StartX, StartY, Length, 0);
  DrawTubeLine(StartX, StartY, Length, 8);
end;  { Tube }

procedure BackGround(Col : integer);
begin
  SetViewPort(25, 25, MaxX - 25, MaxY - 25, ClipOn);
  SetFillStyle(1, Col);
  FloodFill(100, 100, 15);
  SetViewPort(0, 0, GetMaxX, GetMaxY, ClipOn);
end;

procedure DrawBorder;
begin
  MaxX := GetMaxX;
  MaxY := GetMaxY;
  BackGround(9);
  Tube(50, 10, MaxX - 100, 'Hor');
  Tube(10, 50, MaxY - 100, 'Ver');
  Tube(MaxX - 30, 50, MaxY - 100, 'Ver');
  Tube(50, MaxY - 30, MaxX - 100, 'Hor');
  SetFillStyle(1, Brown);
  Bar(0, 0, 50, 50);
  Bar(MaxX - 50, 0, MaxX, 50);
  Bar(0, MaxY - 50, 50, MaxY);
  Bar(MaxX - 50, MaxY - 50, MaxX, MaxY);
  SetColor(Black);
{  Line(0, 55, MaxX, 55);
  Line(55, 0, 55, MaxY);
  Line(0, MaxY - 55, MaxX, MaxY - 55);
  Line(MaxX - 55, 0, MaxX - 55, MaxY);}
  SetColor(White);
{TL block's highlights}
  Line(3, 3, 47, 3);
  Line(47, 3, 47, 47);
{TR block's highlights}
  Line(MaxX - 47, 3, MaxX - 3, 3);
  Line(MaxX - 3, 3, MaxX - 3, 47);
{BL block's highlights}
  Line(3, MaxY - 47, 47, MaxY - 47);
  Line(47, MaxY - 47, 47, MaxY - 3);
{BR block's highlights}
  Line(MaxX - 47, MaxY - 47, MaxX - 3, MaxY - 47);
  Line(MaxX - 3, MaxY - 47, MaxX - 3, MaxY - 3);
  { LowLights }
  SetColor(Black);
{TL block's }
  Line(3, 3, 3, 47);
  Line(3, 47, 47, 47);
{TR block's }
  Line(MaxX - 47, 3, MaxX - 47, 47);
  Line(MaxX - 47, 47, MaxX - 3, 47);
{BL block's }
  Line(3, MaxY - 47, 3, MaxY - 3);
  Line(3, MaxY - 3, 47, MaxY - 3);
{BR block's }
  Line(MaxX - 47, MaxY - 47, MaxX - 47, MaxY - 3);
  Line(MaxX - 47, MaxY - 3, MaxX - 3, MaxY - 3);
end;

procedure SaveImage;
Var
  Result : Word;
  P : pointer;
  F : file;
  FString : String;
begin
  X := 160;
  Y := 0;
  Repeat
    Size := ImageSize(0, X - 160, MaxX, X); {320, 480}
    if GraphResult <> 0 then
     begin
       CloseGraph;
       Write('I stuffed up.');
       ReadKey;
     end;
    GetMem(P, Size);
    GetImage(0, X - 160, MaxX, X, P^);
    Str(Y, FString);
    Insert('C:\GLENNS\TEMP\TUBE', FString, 0);
    Insert('.GKI', FString, Length(FString) + 1);
    Assign(F, FString);
    ReWrite(F, Size);
    BlockWrite(F, P^, 1, Result);
    Close(F);
    Inc(Y);
    Inc(X, 160);
    FreeMem(P, SizeOf(P));
  Until X > 480;
end;

begin
  GraphicsScreen('C:\TP\BGI');
  DrawBorder;
  ReadKey;
  SaveImage;
  CloseGraph;
  Write(Size, ' ', GraphResult);
end.

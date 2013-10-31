program Whatever;
uses
  Crt, Graph,
  GrafBits;

const
  NumDots = 600;
  MovDist = 4;

type
  TPoint = object
    OldX, OldY,
    X, Y: integer;
    ColCount,
    XMov, YMov: shortint;
    Col: word;
    procedure StartMe;
    procedure MoveMe;
    procedure DrawMe;
  end;

var
  I: integer;
  BluePoint: array[1..NumDots] of TPoint;
  YellowPoint: array[1..NumDots] of TPoint;

procedure TPoint.StartMe;
begin
  X:= Random(MaxX);
  Y:= Random(MaxY);
  While (XMov = 0) or (YMov = 0) do
  begin
    XMov:= Random(MovDist) - MovDist div 2;
    YMov:= Random(MovDist) - MovDist div 2;
  end;
  Col:= LightBlue;
  ColCount:= 0;
end;

procedure TPoint.MoveMe;
begin
  OldX:= X;
  OldY:= Y;
  Inc(X, XMov);
  Inc(Y, YMov);
  if (X > MaxX) or (X < 0) then
  begin
    XMov:= -XMov;
    Inc(ColCount);
    if ColCount > 15 then ColCount:= 1;
    Col:= ColCount;
  end;
  if (Y > MaxY) or (Y < 0) then
  begin
    YMov:= -YMov;
    Inc(ColCount);
    if ColCount > 15 then ColCount:= 1;
    Col:= ColCount;
  end;
end;

procedure TPoint.DrawMe;
begin
  PutPixel(OldX, OldY, Black);
  PutPixel(X, Y, Col);
end;

procedure ChangeColours;
var
  X: integer;
begin
  Randomize;
  X:= Random(15) + 1;
  SetRGBPalette(X, Random(63), Random(63), Random(63));
end;

procedure RunEm;
var
  ChangeCols: shortint;
begin
  For I:= 1 to NumDots do
  begin
    BluePoint[I].StartMe;
    YellowPoint[I].StartMe;
  end;
  While not KeyPressed do
  begin
    For I:= 1 to NumDots do
    begin
      BluePoint[I].MoveMe;
      YellowPoint[I].MoveMe;
      BluePoint[I].DrawMe;
      YellowPoint[I].DrawMe;
    end;
    ChangeCols:= Random(50);
    if ChangeCols = 25 then ChangeColours;
  end;
  CloseGraph;
end;

begin
{  GraphicsScreen;
  VESAScreen(1);}
  VGA256;
  RunEm;
  CloseGraph;
end.

program Whatever;
uses
  Crt, Graph,
  GrafBits;

const
  NumDots = 200;
  MovDist = 4;

type
  TPoint = object
    Col: word;
    OldX, OldY,
    Ceiling, Bottom,
    X, Y: integer;
    YDir: Boolean;
    ColCount,
    XMov, YMov: shortint;
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
  Y:= Random(MaxY) + 10;
  While (XMov = 0) or (YMov = 0) do
  begin
    XMov:= Random(MovDist) - MovDist div 2;
    YMov:= 2;
  end;
  Col:= LightBlue;
  ColCount:= 0;
  YDir:= True;
  Ceiling:= 20;
  Bottom:= 1;
end;

procedure TPoint.MoveMe;
begin
  OldX:= X;
  OldY:= Y;
  YMov:= 1;
  if YDir then Y:= OldY + (YMov * (Y div 10))
    else Y:= OldY - (YMov * (Y div 10));
  if Y >= MaxY then
  begin
    YDir:= False;
    Inc(Bottom);
    if Bottom > 5 then Bottom:= 0;
    Case Bottom of
      0:  Ceiling:= 20;
      1: Ceiling:= MaxX div 3;
      2: Ceiling:= MaxX div 7;
      3: Ceiling:= MaxX div 11;
      4: Ceiling:= DivX div 2;
      5: Ceiling:= DivX div 6;
    end;
  end;
  if Y < Ceiling then YDir:= True;
{  Inc(ChgYMov);
  if ChgYMov > 10 then
  begin
    if YDir then Inc(YMov, YMov div Bottom)
    else Dec(YMov, YMov div Bottom);
    if YMov < 2 then YMov:= 2;
    ChgYMov:= 0;
  end;
  if (X > MaxX) or (X < 0) then
    XMov:= -XMov;
  if (Y > MaxY) or (Y < 0) then
  begin
    if Y >= MaxY then
    begin
      YDir:= False;
      Inc(Bottom);
      if Bottom > 4 then
      begin
        Bottom:= 1;
        Y:= 0;
      end;
    end;
    if Y < 0 then YDir:= True;
  end;
  Inc(X, XMov);
  if YDir then Inc(Y, YMov)
  else Dec(Y, YMov);}
end;

procedure TPoint.DrawMe;
begin
  PutPixel(OldX, OldY, Black);
  PutPixel(X, Y, Col);
end;

procedure RunEm;
begin
  For I:= 1 to NumDots do
  begin
    BluePoint[I].StartMe;
    YellowPoint[I].StartMe;
  end;
  While not KeyPressed do
  For I:= 1 to NumDots do
  begin
    BluePoint[I].MoveMe;
    YellowPoint[I].MoveMe;
    BluePoint[I].DrawMe;
    YellowPoint[I].DrawMe;
  end;
  CloseGraph;
end;

begin
  GraphicsScreen;
  RunEm;
  CloseGraph;
end.

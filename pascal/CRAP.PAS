program Bouncer;
Uses Crt, Graph, GrafBits;
const
  OT : array[0..4] of shortint = (0, 1, -1, 2, -2);
  Bits = 900;
Var
  X, Y,  Gd, Gm,
  Col, rx, ry, Counter, Clr : integer;
  No, Ex, Why : integer;
  Del, Sz, DvX, DvY : integer;
  GotBall, ChangeGraphics,
  DirX, DirY, DirRx, DirRy : Boolean;
  Ball: Pointer;
  Size: Word;
  XPos, YPos: array[1..2] of integer;
  Poly: array[1..5] of PointType;


procedure Operate;
begin
  if X < Rx then DirX := True;
  if X > MaxX - Rx then DirX := False;
  if Y < Ry then DirY := True;
  if Y > MaxY - Ry then DirY := False;
  Case DirX of
    True: Inc(X, Random(5));
    False: Dec(X, Random(5));
  end;
  Case DirY of
    True: Inc(Y, Random(5));
    False: Dec(Y, Random(5));
  end;
  Col:= Random(14) + 1;
  if Col < 0 then Col := 15;
  if DirRx = True then Inc(rx, Random(4))
    else Dec(rx, Random(4));
  if rx < 10 then DirRx := True;
  if rx > 50 then DirRx := False;
  if DirRy = True then
    Inc(ry, Random(4))
  else Dec(ry, Random(4));
  if ry < 10 then DirRy := True;
  if ry > 50 then DirRy := False;
  Inc(Counter);
end;

procedure Bounce;
Var Co: integer;
begin
  SetColor(Black);
  Randomize;
  Co:= 0;
  X := Random(MaxX);
  Y := Random(MaxY);
  Rx := 0;
  Ry := 0;
  Counter := 0;
  Col := 15;
  Repeat
    SetFillStyle(1, Col);
    FillEllipse(X, Y, rx, ry);
    Operate;
    Inc(Co);
  Until KeyPressed;
end;

begin
  GraphicsScreen('\tp\bgi');
  Bounce;
end.
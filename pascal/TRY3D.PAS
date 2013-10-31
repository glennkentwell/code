program Try3DShit;
uses Crt, Graph, GrafBits;
const
  MaxZ = 500;
  Size = 10;
var
  Radius,
  XDir, YDir, ZDir,
  ScreenX, ScreenY,
  X, Y, Z: integer;

procedure Init;
begin
  VGA256;
  Randomize;
  X:= Random(MaxX);
  Y:= Random(MaxY);
  Z:= Random(MaxZ);
  XDir:= 5;
  YDir:= 5;
  ZDir:= 1;
end;

procedure ChangeDir;
begin
  if X >= DivX then XDir:= -5;
  if X < -DivX then XDir:= 5;
  if Y >= DivY then YDir:= -5;
  if Y < -DivY  then YDir:= 5;
  if Z >= MaxZ then ZDir:= -1;
  if Z <= 10 then ZDir:= 1;
end;

begin
  Init;
  While not KeyPressed do
  begin
    SetColor(Black);
    SetFillStyle(1, Black);
    FillEllipse(DivX + ScreenX, DivY + ScreenY, Z div 20, Z div 20);
    ChangeDir;
    Inc(X, XDir);
    Inc(Y, YDir);
    Inc(Z, ZDir);
    ScreenX:= 50 * X div Z;
    ScreenY:= 50 * Y div Z;
    SetColor(Blue);
    SetFillStyle(1, Blue);
    FillEllipse(DivX + ScreenX, DivY + ScreenY, Z div 20, Z div 20);
    Delay(5);
  end;
  CloseGraph;
end.
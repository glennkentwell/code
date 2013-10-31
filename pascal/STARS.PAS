program Stars;
uses Graph, Crt, GrafBits;
const
  Max = 3538;
type
  TStar = object
    OldX, OldY,
    ScreenX, ScreenY,
    C, X, Y, Z: integer;
    Colour: Word;
    procedure New;
    procedure Move;
  end;

var
  ScreenDist: integer;
  Num, X: integer;
  Star: array[1..Max] of TStar;


procedure TStar.New;
begin
  X:= Random(640) - 320;
  Y:= Random(480) - 240;
  Z:= Random(256) + 1;
  C:= 0;
  Colour:= 0;
end;

procedure TStar.Move;
begin
  PutPixel(320 + ScreenX, 240 + ScreenY, Black);
  ScreenX:= ScreenDist * Y div Z;
  ScreenY:= ScreenDist * X div Z;
  Dec(Z);
  Colour:= 15 - (Z div 16);
  PutPixel(320 + ScreenX, 240 + ScreenY, Colour);
  if Z < 1 then New;
end;

begin
  GraphicsScreen;
  GradePalette(Grey);
  ScreenDist:= 100;
  Val(ParamStr(1), Num, X);
  if (Num < 1) or (Num > Max) then Num:= 100;
  For X:= 1 to Num do
    Star[X].New;
  X:= 1;
  While not KEyPressed do
  begin
    Inc(X);
    Star[X].Move;
    if X > Num - 1 then X:= 0;
  end;
 CloseGraph;
 if KeyPressed then Readkey;
end.




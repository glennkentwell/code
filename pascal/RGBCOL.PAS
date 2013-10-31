uses crt, graph, grafbits;
const
  Max = 10;
var
  Col,
  X, Y,
  Xinc, Yinc,
  Rinc, Binc, Ginc,
  R, G, B: integer;

procedure Saver;
var
  I, Ex : integer;
  Poly : array [1..Max] of PointType;
begin
  For Ex := 1 to Max do
    With Poly[Ex] do
    begin
      X := Random(MaxX);
      Y := Random(MaxY);
    end;
  ClearDevice;
  FillPoly (Max,Poly);
end;

begin
  VESAScreen(1);
  Randomize;
  SetColor(White);
  SetFillStyle(1, White);
  R:= 0;  G:= R;  B:= G;
  Rinc:= 1;
  Saver;
  Ginc:= 2;
  Binc:= 3;
  Xinc:= 1;
  Yinc:= 1;
  While not KeyPressed do
  begin
    Inc(R, Rinc);
    G:= G + Ginc;
    B:= B + Binc;
    if R > 62 then Rinc:= -1;
    if R < 1 then
    begin
      Rinc:= 1;
      Saver;
    end;
    Inc(X, Xinc);
    Inc(Y, Yinc);
    if X > MaxX then Xinc:= -1;
    if Y > MaxY then Yinc:= -1;
    if X < 0 then Xinc:= 1;
    if Y < 0 then Yinc:= 1;
    if G > 62 then Ginc:= -3;
    if G < 1 then Ginc:= 2;
    if B > 62 then Binc:= -3;
    if B < 1 then Binc:= 3;
    SetRGBPalette(63, R, G, B);
    SetColor(Black);
    SetFillStyle(1, Black);
    FillEllipse(X, Y, 10, 10);
    SetColor(White);
    SetFillStyle(1, White);
    FillEllipse(X, Y, 10, 10);
  end;
  ReadKey;
  CloseGraph;
end.
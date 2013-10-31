program Poly;
Uses Graph, Crt, GrafBits;
Const Max = 75;
Var MaxX, MaxY : integer;
procedure Init;
begin
  GraphicsScreen('C:\TP\BGI');
  MaxX := GetMaxX;
  MaxY := GetMaxY;
end;

procedure Saver;
var
  I, Ex : integer;
  Poly : array [1..Max] of PointType;
begin
  Repeat
    SetColor(Black);
    SetFillStyle (1,Random(14)+1);
    For Ex := 1 to Max do
      With Poly[Ex] do
      begin
        X := Random(MaxX);
        Y := Random(MaxY);
      end;
    FillPoly (Max,Poly);
    Delay(1000);
    ClearDevice;
  Until KeyPressed;
  CloseGraph;
end;

begin
  Init;
  Saver;
end.
program Polym;
Uses Graph, Crt, GrafBits;
Const Max = 1005;
var
  I, Ex : integer;
  Poly : array [1..Max] of PointType;
  MaxX, MaxY : integer;

procedure Init;
begin
  MaxX:= InstallUserDriver('VESA16', nil);
  MaxY:= 1;
  InitGraph(MaxX, MAxY, '\tp\bgi');
  MaxX := GetMaxX;
  MaxY := GetMaxY;
end;

procedure Starter;
begin
    For Ex := 1 to Max do
      With Poly[Ex] do
      begin
        X:= Random(MaxX);
        Y:= Random(MaxY);
      end;
{    FillPoly (Max, Poly);}
end;

procedure Mover;
var
  Ex: integer;
begin
  For Ex := 1 to Max do
    begin
      Inc(Poly[Ex].X, Random(15) - 7);
      Inc(Poly[Ex].Y, Random(15) - 7);
      if Poly[Ex].X > MaxX then Poly[Ex].X:= MaxX;
      if Poly[Ex].Y > MaxY then Poly[Ex].Y:= MaxY;
      if Poly[Ex].X < 0 then Poly[Ex].X:= 0;
      if Poly[Ex].Y < 0 then Poly[Ex].Y:= 0;
    end;
end;

procedure DrawPolies;
var
  Ex: integer;
begin
  While not KeyPressed do
  begin
    Randomize;
    Mover;
    SetColor(Random(14));
    For Ex := 1 to Max do
      Line(Poly[Ex - 1].X, Poly[Ex - 1].Y, Poly[Ex].X, Poly[Ex].Y);
  end;
end;

begin
  Init;
  Starter;
  DrawPolies;
  CloseGraph;
end.
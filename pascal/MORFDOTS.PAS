program Pointy;
uses Crt, Graph, GrafBits;
const
  Max = 15000;
type
  PointyType = record
    X, Y: integer;
  end;

var
  I,
  Gd, Gm: integer;
  Colour: word;
  Point: array[1..Max] of PointyType;

procedure GetPoints;
begin
  Colour:= Random(15) + 1;
  For I:= Max downto 1 do
  begin
    With Point[I] do
    if not KeyPressed then
    begin
      X:= Random(MaxX);
      Y:= Random(MaxY);
    end;
  end;
end;

procedure GivePoints;
begin
  Colour:= (Random(15) + 1);
  For I:= 1 to Max do
  begin
    With Point[I] do
    if not KeyPressed then
    begin
      PutPixel(X, Y, Colour);
    end;
  end;
end;

procedure TakePoints;
begin
  For I:= 1 to Max do
    With Point[I] do
    if not KeyPressed then
      PutPixel(X, Y, Black);
end;

begin
  GraphicsScreen;
  GetPoints;
  Colour:= 1;
  While not KeyPressed do
  begin
    GetPoints;
    GivePoints;
  end;
  CloseGraph;
end.

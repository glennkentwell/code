program Whatever;
uses
  Crt, Graph, GrafBits;
var
  X, Y: integer;

procedure FillCircle(XPos, YPos, Radius: integer; Colour: Word);
begin
  SetColor(Colour);
  SetFillStyle(10, Colour);
  FillEllipse(XPos, YPos, Radius, Radius);
end;

begin
  VGA256;
  While not KeyPressed do
  begin
  For X:= DivX downto 1 do
    FillCircle(DivX, DivY, X, X);
  For X:= 1 to DivX do
    FillCircle(DivX, DivY, X, Black);
  end;
  ReadKey;
  CloseGraph;
end.

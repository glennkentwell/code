program ShittyCircles;
uses Crt, Graph, GrafBits;
var
  X, Y, Rad, Circum, Arcs, Sec, Col, SecCol: integer;

begin
  GraphicsScreen;
  GradePalette(Re);
  X:= DivX;
  Y:= DivY;
  Randomize;
  Rad:= 45;
  Circum:= Round(Pi * (Rad * 2));
  Arcs:= Circum div 12;
  Col:= 0;
  While not KeyPressed do
  begin
    Dec(Col);
    if Col < 0 then Col:= 15;
    Inc(Rad);
    if Rad > 25 then Rad:= 1;
  For Sec:= 15 downto 0 do
  begin
    SecCol:= Sec + Col;
    if SecCol > 15 then SecCol:= SecCol - 15;
    SetColor(SecCol);
    Ellipse(X, Y, (Arcs * Sec) - Arcs, (Arcs * Sec),Rad, Rad);
    Delay(1);
  end;
  end;
  CloseGraph;
end.
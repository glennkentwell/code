program NewShit;
uses Crt, Graph, GrafBits;

var
  X, Y: integer;

begin
  GraphicsScreen;
  SetViewPort(DivX - 50, DivY - 25, DivX + 50, DivY + 25, ClipOn);
  SetColor(7);
  SetFillStyle(1, 7);
  Bar(0, 0, 100, 50);
  SetColor(15);
  Line(0, 0, 100, 0);
  Line(0, 0, 0, 50);
  Line(5, 45, 95, 45);
  Line(95, 45, 95, 5);
  SetColor(8);
  Line(100, 0, 100, 50);
  Line(0, 50, 100, 50);
  Line(5, 5, 95, 5);
  Line(5, 5, 5, 45);
  ReadKey;
  CloseGraph;
end.
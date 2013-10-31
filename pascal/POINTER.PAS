program TryGraphics;
Uses Crt, GrafBits, Graph;

begin
  GraphicsScreen('C:\TP\BGI');
  While not KeyPressed do
    Point (Random(GetMaxX), Random(GetMaxY),Random(5),Random(15));
  ReadKey;
  CloseGraph;
end.
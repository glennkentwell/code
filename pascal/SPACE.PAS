Program TryGraphics;
Uses Crt, Graph, GrafBits;
Var MaxX, MaxY, X, Y, Ex, Why : integer;
begin
  GraphicsScreen('C:\TP\BGI');
  SetColor (DarkGray);
  MaxX := GetMaxX;
  MaxY := GetMaxY;
  Why := MaxY - 150;
  For Y := Why to Why + 3 do
    Line (0,Y,MaxX,Y);
{  For Y := MaxY - 1 to MaxY + 2 do
    Line (0,Y,200,Y - 150);
  For Y := MaxY - 1 to MaxY + 2 do
    Line (MaxX - 200,Y - 150,MaxX, Y);
  Line (200, Why, 250, MaxY);
  Line (MaxX - 200, Why, MaxX - 250, MaxY);}
  SetColor (LightGray);
  Line (0,0,200,Why);
  Line (MaxX, 0, MaxX - 200,Why);
  Line (DivX, Why, DivX, 0);
  For Y := 1 to 800 do
    PutPixel (Random(MaxX),Random(Why - 1),15);
  ReadKey;
  CloseGraph;
end.


program Shit;
uses
 Crt, Graph, GrafBits;

var
  X, Y: longint;

begin
  VGA256;
  Randomize;
  While not KeyPressed do
  begin
  SetColor(Random(256));
  For X:= 0 to MaxX do
     Line(X, 0, X, MaxY);
  SetColor(Random(256));
  For X:= 0 to MaxX do
     Line(MaxX - X, 0, MaxX - X, MaxY);
  SetColor(Random(256));
  For X:= 0 to MaxY do
     Line(0, X, MaxX, X);
  SetColor(Random(256));
  For X:= 0 to MaxY do
     Line(0, MaxY - X, MaxX, MaxY - X);
  end;
  ReadKey;
  CloseGraph;
end.

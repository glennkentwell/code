program CircleyShit;
uses Crt, Graph, Grafbits;
var
  OldX, OldY,
  Degrees, Radius, Colour,
  X, Y: integer;

procedure DrawShape(X, Y, Degrees, Radius: integer);
begin
  Randomize;
  Ellipse(X, Y, 0, 360, Degrees, Radius);
end;

begin
  Randomize;
  GraphicsScreen;
  X:= Random(MaxX);
  Y:= Random(MaxY);
  Degrees:= 0;
  Radius:= 10;
  Repeat
    SetColor(Colour);
    DrawShape(X, Y, Degrees, Radius);
    OldX:= X;
    OldY:= Y;
    Inc(X, Random(20));
    Inc(Y, Random(20));
    If X > MaxX then X:= 1;
    If Y > MaxY then Y:= 1;
    Delay(50);
{    SetColor(Black);
    DrawShape(OldX, OldY, Degrees, Radius);}
    Inc(Colour);
    If Colour = 16 then Colour:= 1;
    Degrees:= Random(100) - 50;
    Radius:= Random(100) - 50;
  Until KeyPressed;
  ReadKey;
  CloseGraph;
end.

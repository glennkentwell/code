program XORorSomething;
uses Crt, Graph, GrafBits, Animals;
const
  Colour = 15;
var
  X, Y: integer;
  P, Q: Pointer;
  Size: Word;

procedure Draw;
begin
  SetFillStyle(1, Colour);
  Bar(0, 0, 50, 50);
  Bar(100, 0, 150, 50);
  Bar(100, 100, 150, 150);
  PutImage(100, 0, Cat^, NormalPut);
  For Y:= 0 to 50 do
    For X:= 100 to 150 do
      if (Y > 20) and (Y < 25) and (X > 115) and (X < 123) then GetPixel(0, 0)
      else if GetPixel(X, Y) = Black then PutPixel(X, Y, White);
  For X:= 1 to 15 do
  begin
    SetColor(X);
    Line(Random(50), Random(50), Random(50), Random(50));
  end;
  Size:= ImageSize(0, 0, 50, 50);
  GetMem(P, Size);
  GetImage(0, 0, 50, 50, P^);
  PutImage(50, 50, P^, XORPut);
  PutImage(100, 100, P^, XORPut);
end;

begin
  GraphicsScreen;
  DrawCat;
  Draw;
  ReadKey;
  CloseGraph;
end.
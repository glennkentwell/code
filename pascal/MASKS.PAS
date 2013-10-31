program Grafficks;
uses Graph, Crt, GrafBits;
var
  A, B,
  X, Y: integer;
  Size: Word;
  P, M: Pointer;

procedure DrawUFO(Color: word);
begin
  a := 100; b := 100;
  SetColor(DarkGray);
  ellipse (a,b,111,69,75,25);
  ellipse (a,b-7,179,0,35,5); {ufo body}
  ellipse (a,b,10,171,35,35); {ufo window}
  SetFillStyle(1, DarkGray);
  FloodFill(a, b, DarkGray);
  SetColor(LightGray);
  ellipse (a,b,20,60,73,22);
  SetColor(White);
  ellipse (a,b,20,61,72,21);
  SetColor(Color);
  ellipse (a,b,180,300,74,23);
  ellipse (a,b,180,285,74,22);
  ellipse (a,b,180,270,73,21);
  SetColor(LightBlue);
  ellipse (a,b-7,179,0,35,5); {ufo body}
  ellipse (a,b,30,70,30,30);  {foreground color}
  ellipse (a,b,10,171,35,35); {ufo window}
  SetFillStyle(1, Blue);
  FloodFill(a, b - 20, LightBlue);
  Size := (ImageSize (20,60,180,130));
  GetMem(P,Size);
  GetImage(23,63,177,127,P^);
end;

procedure MakeMask;
const
  Height = 64;
  Width = 154;
begin
  PutImage(300, 0, P^, NormalPut);
  For Y:= 0 to Height do
  For X:= 300 to 300 + Width do
    if GetPixel(X, Y) <> Black then PutPixel(X, Y, White)
      else PutPixel(X, Y, Black);
{  Line(300 + Width div 2, 0, 300 + Width div 2, Height);
  Line(300, Height div 2, 300 + Width, Height div 2);
  Rectangle(300, 0, Width + 300, Height);            }
  DrawUFO(Black);
  Size := (ImageSize (20,60,180,130));
  GetMem(M,Size);
  GetImage(300,0,477, Height,M^);
  PutImage(100, 50, P^, ORPut);
  ClearDevice;
 For X:= 1 to 10000 do PutPixel(Random(MaxX), Random(MAxY), Random(15));
  X:= 0;
    PutImage(100, 70, M^, ANDPut);
    PutImage(100, 140, M^, NormalPut);
    PutImage(100, 210, M^, ANDPut);
    PutImage(100, 280, M^, ORPut);
    PutImage(100, 70, P^, ANDPut);
    PutImage(100, 140, P^, NormalPut);
    PutImage(100, 210, P^, ORPut);
    PutImage(100, 210, P^, XORPut);

    PutImage(300, 210, P^, XORPut);
    PutImage(300, 210, P^, ORPut);
{  While (X < MaxX) and (not KEyPressed) do
  begin
    Inc(X, 4);
    PutImage(X, 210, P^, XORPut);
    PutImage(X, 210, P^, ORPut);
    PutImage(X, 210, P^, ORPut);
  end;}
end;

begin
  GraphicsScreen('\tp\bgi');
  DrawUFO(Black);
  MakeMask;
  ReadKey;
end.
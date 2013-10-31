Unit Animals;
Interface
procedure DrawMovingDog;
procedure DrawStillDog;
procedure DrawCat;
const
  OutLine = 7;  { Black }
  Fill = 6;     { Brown }
Var
  Cat, Dog, MoveDog, BlankDog : Pointer;
  Size, S : integer;

Implementation
Uses Graph, Crt, GrafBits;

procedure DrawMovingDog;
begin
  SetColor(OutLine);
  Line (10, 15, 10, 20);
  Line (10, 20, 0, 45);
  Line (0, 45, 20, 50);
  Line (45, 30, 55, 50);
  Line (55, 50, 73, 38);
  Line (60, 38, 60, 20);
  Line (55, 20, 65, 20);
  Line (55, 10, 68, 2);
  Line (25, 20, 50, 20);
  Line (25, 10, 40, 10);
  Line (50, 12, 50, 20);
  Line (45, 2, 50, 5);
  Line (50, 5, 57, 2);
{  SetColor (Magenta);}
  Ellipse (25, 15, 90, 270, 5, 5);
  Ellipse (25, 15, 10, 180, 15, 15);
  Ellipse (22, 33, 200, 5, 7, 7);
  Ellipse (40, 25, 215, 310, 15, 15);
  Ellipse (10, 45, 330, 60, 10, 10);
{  SetColor (Red);}
  Ellipse (66, 43, 30, 140, 6, 10);
  Ellipse (65, 10, 270, 78, 10, 10);
  Ellipse (50, 10, 10, 60, 10, 10);
  Ellipse (50, 10, 120, 270, 10, 10);
  Circle (69, 4, 3);
  SetFillStyle (1, Fill);
  FloodFill (40, 25, OutLine);
  SetColor (White);
  Circle (52, 10, 3);
  Circle (55, 10, 3);
  S := ImageSize(0, 0, 75, 50);
  GetMem(MoveDog, S);
  GetImage (0, 0, 75, 50, MoveDog^);
end;

procedure DrawStillDog;
begin
  SetColor(OutLine);
  Line (0, 50, 0, 15);
  Line (0, 50, 20, 50);
  Line (40, 30, 40, 50);
  Line (40, 50, 60, 50);
  Line (55, 30, 55, 40);
  Line (15, 20, 40, 20);
  Line (15, 10, 30, 10);
  Line (60, 10, 70, 10);
  Line (20, 50, 20, 45);
  Line (60, 50, 60, 45);
{  SetColor(Blue);}
  Ellipse (10, 30, 270, 0, 10, 10);
  Ellipse (15, 45, 0, 90, 5, 5);
  Ellipse (30, 25, 225, 315, 15, 15);
  Ellipse (15, 15, 90, 270, 5, 5);
  Ellipse (15, 15, 10, 180, 15, 15);
  Ellipse (55, 45, 0, 90, 5, 5);
  Ellipse (40, 15, 270, 0, 5, 5);
  Circle (72, 12, 3);
{  SetColor (Green);}
  Ellipse (60, 15, 225, 0, 15, 10);
  Ellipse (35, 0, 270, 0, 10, 5);
  Ellipse (45, 5, 180, 280, 10, 10);
  Ellipse (65, 0, 180, 270, 10, 5);
  Ellipse (60, 5, 270, 0, 5, 5);
{  SetColor (Red);}
  Line (45, 0, 50, 5);
  Line (50, 5, 55, 0);
  Line (55, 30, 60, 25);
  SetFillStyle (1, Fill);
  FloodFill (30, 25, OutLine);
  SetColor (White);
  Circle (52, 7, 3);
  Circle (55, 7, 3);
  Size := ImageSize(0, 0, 75, 50);
  GetMem(Dog, Size);
  GetImage (0, 0, 75, 50, Dog^);
end;

procedure DrawCat;
begin
  SetColor(Red);
  Line(0, 40, 17, 40);
  Line(23, 40, 40, 40);
  Line(17, 40, 17, 33);
  Line(23, 40, 23, 33);
  Line(30, 30, 30, 23);
  Line(25, 20, 40, 30);
  Line(40, 30, 35, 20);
  Line(35, 20, 40, 15);
  Line(40, 15, 35, 15);
  Line(35, 15, 40,  5);
  Line(40,  5, 25, 15);
  Line(30,  0, 30, 12);
  Line(30,  0, 25,  5);
  Line(15, 25, 25, 25);
  Line(20, 25, 20, 20);
{  SetColor(Green);}
  Line(10, 30, 10, 23); {line 5}
  Line(15, 20,  0, 30);
  Line( 0, 30,  5, 20);
  Line( 5, 20,  0, 15);
  Line( 0, 15,  5, 15);
  Line( 5, 15,  0,  5);
  Line( 0,  5, 15, 15);
  Line(10,  0, 10, 12);
  Line(10,  0, 15,  5);
{  SetColor(Blue);}
  Ellipse(10, 40, 90, 180, 10, 10);
  Ellipse(30, 40,  0,  90, 10, 10);
  Ellipse(20, 5, 0, 180, 5, 5);
  Ellipse(20, 30, 180, 0, 5, 5);
  SetFillStyle(1, LightRed);
  FloodFill(20, 5, Red);
  SetColor(White);
  Circle(17, 12, 3);
  Circle(23, 12, 3);
  SetColor(Black);
  Circle(20, 17, 3);
  S := ImageSize(0, 0, 40, 40);
  GetMem(Cat, S);
  GetImage(0, 0, 40, 40, Cat^);
end;
end.
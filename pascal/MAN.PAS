Program Cool;
Uses Crt, Graph, GrafBits;
Var Size, X, Y, Ex, Why, MaxY, Yi : integer;
    P, Pb, Pc, Head : Pointer;
begin
  GraphicsScreen('C:\TP\BGI');
  Why := DivY div 2;
  MaxY := GetMaxY;
  SetColor (15);
  ClearDevice;
  Circle (DivX, Why, 30);                   { Face }
  Point (DivX - 10, Why - 5, 4, 15);        { Left Eye }
  Point (DivX + 10, Why - 5, 4, 15);        { Right Eye }
  For X := DivX - 1 to DivX + 1 do
    Line (X, Why - 3, X, Why + 3);   { Nose }
  Ellipse (DivX, Why, 225, 315, 18,18);     { Mouth }
  Line (DivX, Why + 30, DivX, Why*2);        { Main body Stick }
  Line (DivX, Why + Why, DivX - 30, Why * 2 + 50);{ Left Leg }
  Line (DivX, Why*2, DivX + 30,Why*2 + 50);         { Right Leg }
  Line (DivX, Why + 60, DivX - 50, Why + 30);     { Left Arm }
  Line (DivX, Why + 60, DivX + 50, Why + 30);     { Right Arm }
  Size := ImageSize(DivX - 60, Why - 35, DivX + 60, Why*2 + 55);
  GetMem (P,Size);
  GetImage (DivX - 60, Why - 35, DivX + 60, Why*2 + 55,P^);
  Size := ImageSize(DivX - 31, Why - 35, DivX + 31, Why + 31);
  GetMem (Head,Size);
  GetImage (DivX - 31, Why - 35, DivX + 31, Why + 31,Head^);
  ClearDevice;
  Circle (DivX, Why, 30);                   { Face }
  Point (DivX - 10, Why - 5, 4, 15);        { Left Eye }
  Point (DivX + 10, Why - 5, 4, 15);        { Right Eye }
  For X := DivX - 1 to DivX + 1 do
    Line (X, Why - 3, X, Why + 3);   { Nose }
  Ellipse (DivX, Why, 225, 315, 18,18);     { Mouth }
  Line (DivX, Why + 30, DivX, Why*2);        { Main body Stick }
  Line (DivX, Why + Why, DivX - 30, Why * 2 + 50);{ Left Leg }
  Line (DivX, Why*2, DivX + 30,Why*2 + 50);         { Right Leg }
  Line (DivX - 55, Why + 60, DivX + 55, Why + 60);     { Arms }
  Size := ImageSize(DivX - 60, Why - 35, DivX + 60, Why*2 + 55);
  GetMem (Pb,Size);
  GetImage (DivX - 60, Why - 35, DivX + 60, Why*2 + 55,Pb^);
  ClearDevice;
  Circle (DivX, Why, 30);                   { Face }
  Point (DivX - 10, Why - 5, 4, 15);        { Left Eye }
  Point (DivX + 10, Why - 5, 4, 15);        { Right Eye }
  For X := DivX - 1 to DivX + 1 do
    Line (X, Why - 3, X, Why + 3);   { Nose }
  Ellipse (DivX, Why, 225, 315, 18,18);     { Mouth }
  Line (DivX, Why + 30, DivX, Why*2);        { Main body Stick }
  Line (DivX, Why + Why, DivX - 30, Why * 2 + 50);{ Left Leg }
  Line (DivX, Why*2, DivX + 30,Why*2 + 50);         { Right Leg }
  Line (DivX, Why + 60, DivX - 50, Why + 90);     { Left Arm }
  Line (DivX, Why + 60, DivX + 50, Why + 90);     { Right Arm }
  Size := ImageSize(DivX - 60, Why - 35, DivX + 60, Why*2 + 55);
  GetMem (Pc,Size);
  GetImage (DivX - 60, Why - 35, DivX + 60, Why*2 + 55,Pc^);
  ClearDevice;
  X := DivX;
  Y := 1;
  Yi := DivY - 40;
{  Repeat
  While Y < MaxY - (Yi) do
  begin
    Inc (Y,5);
    PutImage (X, Y, P^, NormalPut);
    if KeyPressed then Break;
  end;
  While Y > 200 do
  begin
    Dec (Y,3);
    PutImage (X, Y, P^, NormalPut);
    if KeyPressed then Break;
  end;
  Until KeyPressed;}
  X := 115;
  Repeat
    PutImage (X, Y,Head^, NormalPut);
    Inc (X, 1);
    Inc (Y, 1);
    Delay (5);
    if KeyPressed then
    begin
      ReadKey;
      Break;
    end;
  Until Y = DivY;
  Sound (120); Delay (20);
  NoSound;
  Repeat
    PutImage (DivX, DivY, P^, NormalPut);
    Delay (100);
    PutImage (DivX, DivY, Pb^, NormalPut);
    Delay (100);
    PutImage (DivX, DivY, Pc^, NormalPut);
    Delay (100);
  Until KeyPressed;
  ReadKey;
  CloseGraph;
end.

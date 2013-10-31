program LIFE;
uses Graph, Crt, Grafbits;
const
   Xsize = 1025;
   Ysize = 1;
   Plus = 0;
var
  Cel, Cell: array[0..XSize, 0..YSize] of Byte;
  Neighbs: array[0..XSize, 0..YSize] of byte;
  Pg: Shortint;
  Counter, Cc,
  Gd, Gm,
  X, Y: integer;

(*procedure Fred;
begin
  Cell[11 + Plus,  8 + Plus]:= True;
  Cell[11 + Plus,  9 + Plus]:= True;
  Cell[12 + Plus,  8 + Plus]:= True;
  Cell[12 + Plus,  9 + Plus]:= True;

  Cell[21 + Plus,  8 + Plus]:= True;
  Cell[21 + Plus,  9 + Plus]:= True;
  Cell[21 + Plus, 10 + Plus]:= True;
  Cell[22 + Plus,  9 + Plus]:= True;
  Cell[23 + Plus,  9 + Plus]:= True;
  Cell[24 + Plus,  9 + Plus]:= True;
  Cell[24 + Plus,  7 + Plus]:= True;
  Cell[24 + Plus,  6 + Plus]:= True;
  Cell[23 + Plus,  6 + Plus]:= True;
  Cell[23 + Plus, 13 + Plus]:= True;
  Cell[24 + Plus, 13 + Plus]:= True;
  Cell[24 + Plus, 12 + Plus]:= True;

  Cell[27 + Plus,  7 + Plus]:= True;
  Cell[28 + Plus,  8 + Plus]:= True;
  Cell[27 + Plus,  9 + Plus]:= True;

  Cell[30 + Plus,  8 + Plus]:= True;
  Cell[30 + Plus,  9 + Plus]:= True;
  Cell[30 + Plus,  6 + Plus]:= True;
  Cell[30 + Plus,  7 + Plus]:= True;

  Cell[34 + Plus,  6 + Plus]:= True;
  Cell[35 + Plus,  5 + Plus]:= True;
  Cell[36 + Plus,  6 + Plus]:= True;
  Cell[35 + Plus,  7 + Plus]:= True;
  Cell[36 + Plus,  7 + Plus]:= True;
  Cell[36 + Plus,  9 + Plus]:= True;
  Cell[35 + Plus,  9 + Plus]:= True;
  Cell[34 + Plus, 10 + Plus]:= True;
  Cell[36 + Plus, 11 + Plus]:= True;
  Cell[35 + Plus, 11 + Plus]:= True;
  Cell[36 + Plus, 10 + Plus]:= True;

  Cell[37 + Plus,  8 + Plus]:= True;
  Cell[38 + Plus,  8 + Plus]:= True;

  Cell[44 + Plus,  7 + Plus]:= True;
  Cell[45 + Plus,  7 + Plus]:= True;
  Cell[44 + Plus,  8 + Plus]:= True;
  Cell[45 + Plus,  8 + Plus]:= True;
end;

procedure GliderGun;
begin
  Cell[11, 11]:= True;
  Cell[11, 12]:= True;
  Cell[12, 11]:= True;
  Cell[12, 12]:= True;

  Cell[21, 10]:= True;
  Cell[21, 11]:= True;
  Cell[21, 12]:= True;
  Cell[22, 13]:= True;
  Cell[23, 14]:= True;
  Cell[24, 13]:= True;
  Cell[25, 12]:= True;
  Cell[25, 11]:= True;
  Cell[25, 10]:= True;
  Cell[26, 12]:= True;
  Cell[26, 11]:= True;
  Cell[26, 10]:= True;
  Cell[24,  9]:= True;
  Cell[23,  8]:= True;
  Cell[22,  9]:= True;

  Cell[31,  8]:= True;
  Cell[31,  9]:= True;
  Cell[31, 10]:= True;
  Cell[32,  7]:= True;
  Cell[32,  8]:= True;
  Cell[32, 10]:= True;
  Cell[32, 11]:= True;
  Cell[33,  7]:= True;
  Cell[33,  8]:= True;
  Cell[33, 10]:= True;
  Cell[33, 11]:= True;
  Cell[34,  7]:= True;
  Cell[34,  8]:= True;
  Cell[34,  9]:= True;
  Cell[34, 10]:= True;
  Cell[34, 11]:= True;
  Cell[34,  9]:= True;
  Cell[35,  6]:= True;
  Cell[35,  7]:= True;
  Cell[35, 11]:= True;
  Cell[35, 12]:= True;

  Cell[40, 10]:= True;
  Cell[40, 11]:= True;

  Cell[43,  9]:= True;
  Cell[43, 10]:= True;
  Cell[44,  9]:= True;
  Cell[44, 10]:= True;
end;

procedure PiHeptomino;
begin
  Cell[Plus + 1, Plus + 1]:= True;
  Cell[Plus + 1, Plus + 2]:= True;
  Cell[Plus + 1, Plus + 3]:= True;
  Cell[Plus + 2, Plus + 1]:= True;
  Cell[Plus + 3, Plus + 1]:= True;
  Cell[Plus + 3, Plus + 2]:= True;
  Cell[Plus + 3, Plus + 3]:= True;
end;

procedure RPentomino;
begin
  Cell[Plus + 2, Plus + 1]:= True;
  Cell[Plus + 3, Plus + 1]:= True;
  Cell[Plus + 1, Plus + 2]:= True;
  Cell[Plus + 2, Plus + 2]:= True;
  Cell[Plus + 2, Plus + 3]:= True;
end;

procedure Newies;
begin
  { This pattern is a glider, which doesn't stop }
  Cell[Plus + 2, Plus + 1]:= True;
  Cell[Plus + 3, Plus + 2]:= True;
  Cell[Plus + 1, Plus + 3]:= True;
  Cell[Plus + 2, Plus + 3]:= True;
  Cell[Plus + 3, Plus + 3]:= True;
end;

procedure Randoms;
begin
  For X:= 1 to 5100 do
    Cell[Random(XSize), Random(Ysize)]:= True;
end;

procedure Liney;
begin
  Cell[Plus + 1, Plus + 1]:= True;
  Cell[Plus + 2, Plus + 1]:= True;
  Cell[Plus + 3, Plus + 1]:= True;
  Cell[Plus + 4, Plus + 1]:= True;
  Cell[Plus + 5, Plus + 1]:= True;
  Cell[Plus + 6, Plus + 1]:= True;
  Cell[Plus + 7, Plus + 1]:= True;
  Cell[Plus + 8, Plus + 1]:= True;
  Cell[Plus + 9, Plus + 1]:= True;
  Cell[Plus + 10, Plus + 1]:= True;
end;*)

procedure OneDimension;
var T: shortint;
begin
  Randomize;
  For X:= 1 to 8 do
    Cell[Random(Xsize), 1]:= Random(3);
end;

function Neighbours: byte;
var N: byte;
begin
  N:= 0;
  if Cel[X - 1, 1] <> 3 then Inc(N);
  if Cel[X + 1, 1] <> 1 then Inc(N);
  if Cel[X - 2, 1] <> 0 then Inc(N);
  if Cel[X + 2, 1] <> 0 then Inc(N);
  Neighbours:= N;
end;

procedure AliveOrDead;
var
  Xx, Yy: integer;
begin
  For X:= 1 to Xsize  do
  begin
    if Neighbours = 0 then
      Cell[X, 1]:= 0
    else
    if Neighbours = 1 then
      Cell[X, 1]:= 1
    else
    if Neighbours = 2 then
      Cell[X, 1]:= 3
    else
    if Neighbours = 1 then
      Cell[X, 1]:= 3
    else
    if Neighbours = 4 then
      Cell[X, 1]:= 0;

    if Cel[X + 1, 1] = 3 then
      if Neighbours <> 0 then
        Cell[X, 1]:= 5;
    if Cel[X + 1, 1] <> 5 then
      if Neighbours = 1 then
        Cell[X, 1]:= 3;
    if Cel[X + 1, 1] = 0 then
      if Neighbours = 0 then
        Cell[X, 1]:= 1;
    if Cel[X + 1, 1] = 3 then
      if Neighbours <> 0 then
        Cell[X, 1]:= 14;
    if Cel[X + 1, 1] = 0 then
      if Neighbours = 4 then
        Cell[X, 1]:= 0;
    if Cel[X + 1, 1] < 1 then
      if Neighbours > 1 then
        Cell[X, 1]:= 0;
    if Cel[X - 1, 1] = 14 then
      if Neighbours = 1 then
        Cell[X, 1]:= 1;
    if Cel[X + 1, 1] = 14 then
      if Neighbours = 1 then
        Cell[X, 1]:= 2;
  end;
end;

procedure Draw;
begin
  For X:= 1 to Xsize do
    PutPixel(X, Counter, Cell[X, 1])
end;

procedure ControlThem;
begin
  Pg:= 0;
  OneDimension;
  Draw;
  Cel:= Cell;
  While not KeyPressed do
  begin
    AliveOrDead;
    Draw;
    Inc(Counter);
    if Counter > MaxY then
    begin
      ClearDevice;
      Counter:= 0;
    end;
    Cel:= Cell;
  end;
end;

procedure Graphics;
begin
  Gd:= InstallUSerDriver('VESA16', nil);
  Gm:= 1;
  InitGraph(Gd, Gm, '\tp\bgi');
  ScreenVars;
  SetViewPort(0, 0, xsize, Ysize, ClipOn);
end;

begin
  Graphics;
  ControlThem;
 end.
  InstallUserDriver('VGA256', nil);
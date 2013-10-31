program LIFE;
uses Graph, Crt, Grafbits;
const
   Xsize = 155;
   Ysize = 135;
   Plus = 10;
var
  Cel, Cell: array[0..XSize, 0..YSize] of Boolean;
  Neighbs: array[0..XSize, 0..YSize] of byte;
  Pg: Shortint;
  Counter, Cc,
  Gd, Gm,
  X, Y: integer;

procedure Fred;
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
end;

procedure AliveOrDead;
var
  Colour, Neighbours: shortint;
  Xx, Yy: integer;
begin
  For X:= 0 to Xsize do
    For Y:= 0 to Ysize do
    begin
      Neighbours:= 0;
      For Xx:= X - 1 to X + 1 do
        For Yy:= Y - 1 to Y + 1 do
          if (X <> Xx) or (Y <> Yy) then
            if Cel[Xx, Yy] = True then Inc(Neighbours);
      if Cell[X, Y] = True then
      begin
        if (Neighbours < 2) or (Neighbours > 3) then
          Cell[X, Y]:= False;
      end
      else if Cell[X, Y] = False then
        if Neighbours = 3 then Cell[X, Y]:= True;
      Neighbs[X, Y]:= Neighbours;
    end;
   Cel:= Cell;
end;

procedure Draw;
var P: shortint;
begin
  if Pg = 0 then P:= 1
    else P:= 0;
  For X:= 0 to Xsize do
    For Y:= 0 to Ysize do
      if Cell[X, Y] = True then
        PutPixel(X, Y, Green)
        else if Neighbs[X, Y] <> 0 then PutPixel(X, Y, Black);
end;

procedure ControlThem;
begin
  Pg:= 0;
{  Newies;
  RPentomino;
{  Liney;
  GliderGun; }
  Fred;
{  PiHeptomino;
  Randoms;}
  Draw;
  Cel:= Cell;
  While not KeyPressed do
  begin
    if Pg = 0 then Pg:= 1
      else Pg:= 0;
    AliveOrDead;
    Draw;
    Inc(Counter);
  end;
end;

procedure Graphics;
begin
  Gd:= CGA;
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
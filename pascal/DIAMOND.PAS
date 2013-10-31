program Cuba;
Uses Graph, Crt, GrafBits;
Type
  TPoint = object
    X, Y: integer;
    XDir, YDir: Boolean;
    procedure GiveMeLife(Ex, Why: integer);
    procedure GuideMe;
  end;

  TCube = object
   Vertice: array[1..12] of TPoint;
   XDir, YDir, XRotation, YRotation: Boolean;
   procedure GiveMeLife;
   procedure ChangeMe;
   procedure DrawMe;
  end;

Var
  I, Num, Gd, Gm: integer;
  DivX, DivY, MaxX, MaxY: integer;
  Cube: TCube;

procedure TPoint.GiveMeLife(Ex, Why: integer);
begin
  X:= Ex;
  Y:= Why;
  XDir:= True;
  YDir:= True;
end;

procedure TPoint.GuideMe;
begin
  if XDir = True then Inc(X, 2);
  if YDir = True then Inc(Y, 2);
  if XDir = False then Dec(X, 2);
  if YDir = False then Dec(Y, 2);
  if X> MaxX then XDir:= False;
  if Y> MaxY then YDir:= False;
  if X< 0 then XDir:= True;
  if Y< 0 then YDir:= True;
end;

procedure TCube.GiveMeLife;
begin
  Vertice[1].GiveMeLife(0, 0);
  Vertice[2].GiveMeLife(70, 0);
  Vertice[3].GiveMeLife(70, 30);
  Vertice[4].GiveMeLife(0, 30);
  Vertice[5].GiveMeLife(45, 10);
  Vertice[6].GiveMeLife(115, 10);
  Vertice[7].GiveMeLife(115, 40);
  Vertice[8].GiveMeLife(45, 40);
  Vertice[9].GiveMeLife(55, 90);
  Vertice[10].GiveMeLife(185, 20);
  Vertice[11].GiveMeLife(55, -50);
  Vertice[12].GiveMeLife(-70, 20);
  XDir:= True;
  YDir:= True;
end;

procedure TCube.ChangeMe;
begin
  For I:= 1 to 12 do
    Vertice[I].GuideMe;
end;

procedure TCube.DrawMe;
begin
  SetColor(Yellow);
  Line(Vertice[1].X, Vertice[1].Y, Vertice[5].X, Vertice[5].Y);
  Line(Vertice[2].X, Vertice[2].Y, Vertice[6].X, Vertice[6].Y);
  Line(Vertice[3].X, Vertice[3].Y, Vertice[7].X, Vertice[7].Y);
  Line(Vertice[4].X, Vertice[4].Y, Vertice[8].X, Vertice[8].Y);
  SetColor(Magenta);
  Line(Vertice[4].X, Vertice[4].Y, Vertice[9].X, Vertice[9].Y);
  Line(Vertice[3].X, Vertice[3].Y, Vertice[9].X, Vertice[9].Y);
  Line(Vertice[8].X, Vertice[8].Y, Vertice[9].X, Vertice[9].Y);
  Line(Vertice[7].X, Vertice[7].Y, Vertice[9].X, Vertice[9].Y);
  SetColor(Brown);
  Line(Vertice[2].X, Vertice[2].Y, Vertice[10].X, Vertice[10].Y);
  Line(Vertice[3].X, Vertice[3].Y, Vertice[10].X, Vertice[10].Y);
  Line(Vertice[6].X, Vertice[6].Y, Vertice[10].X, Vertice[10].Y);
  Line(Vertice[7].X, Vertice[7].Y, Vertice[10].X, Vertice[10].Y);
  SetColor(White);
  Line(Vertice[2].X, Vertice[2].Y, Vertice[11].X, Vertice[11].Y);
  Line(Vertice[1].X, Vertice[1].Y, Vertice[11].X, Vertice[11].Y);
  Line(Vertice[6].X, Vertice[6].Y, Vertice[11].X, Vertice[11].Y);
  Line(Vertice[5].X, Vertice[5].Y, Vertice[11].X, Vertice[11].Y);
  SetColor(Green);
  Line(Vertice[4].X, Vertice[4].Y, Vertice[12].X, Vertice[12].Y);
  Line(Vertice[1].X, Vertice[1].Y, Vertice[12].X, Vertice[12].Y);
  Line(Vertice[8].X, Vertice[8].Y, Vertice[12].X, Vertice[12].Y);
  Line(Vertice[5].X, Vertice[5].Y, Vertice[12].X, Vertice[12].Y);
  SetColor(Blue);
  Line(Vertice[1].X, Vertice[1].Y, Vertice[2].X, Vertice[2].Y);
  Line(Vertice[2].X, Vertice[2].Y, Vertice[3].X, Vertice[3].Y);
  Line(Vertice[3].X, Vertice[3].Y, Vertice[4].X, Vertice[4].Y);
  Line(Vertice[4].X, Vertice[4].Y, Vertice[1].X, Vertice[1].Y);
  SetColor(Red);
  Line(Vertice[5].X, Vertice[5].Y, Vertice[6].X, Vertice[6].Y);
  Line(Vertice[6].X, Vertice[6].Y, Vertice[7].X, Vertice[7].Y);
  Line(Vertice[7].X, Vertice[7].Y, Vertice[8].X, Vertice[8].Y);
  Line(Vertice[8].X, Vertice[8].Y, Vertice[5].X, Vertice[5].Y);
end;

begin
  Gd:= EGA;
  Gm:= 1;
  InitGraph(Gd, Gm,'');
  MaxX:= GetMaxX;
  MaxY:= GetMaxY;
  DivX:= MaxX div 2;
  DivY:= MaxY div 2;
  Cube.GiveMeLife;
  Cube.DrawMe;
  Repeat
    SetVisualPage(0);
    SetActivePage(1);
    Delay(15);
    ClearDevice;
    Cube.ChangeMe;
    Cube.DrawMe;
    SetVisualPage(1);
    SetActivePage(0);
    Delay(15);
    ClearDevice;
    Cube.ChangeMe;
    Cube.DrawMe;
  Until KeyPressed;
  CloseGraph;
end.

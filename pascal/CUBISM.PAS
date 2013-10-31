program Cucicle;
uses Crt, Graph, GrafBits;

type
  Point3D = record
    X, Y, Z: integer;
  end;
  Point2D = record
    X, Y: integer;
  end;
  TCube = object
    Point: array[1..8] of Point3D;
    Vertice: array[1..8] of Point2D;
    SideLength,
    RotationAngle: integer;
    procedure PointVals(Pnt, Xx, Yy, Zz: integer);
    procedure VerticeVals(Pnt, Xx, Yy: integer); 
    procedure ReadStuff;
    procedure Draw;
    procedure CalcPoints;
  end;

var
  X, Y,
  I, J: integer;
  Cube: TCube;

procedure TCube.PointVals;
begin
  Point[Pnt].X:= Xx;
  Point[Pnt].Y:= Yy;
  Point[Pnt].Z:= Zz;
end;

procedure TCube.VerticeVals;
begin
  Vertice[Pnt].X:= Xx;
  Vertice[Pnt].Y:= Yy;
end;

procedure TCube.ReadStuff;
begin
  CloseGraph;
  Write('Side length ');
  Readln(SideLength);
  Write('Rotation Angle ');
  Readln(RotationAngle);
  PointVals(1, 100, 100, 100);
  PointVals(2, SideLength + 100, 100, 100);
  PointVals(3, SideLength + 100, SideLength + 100, 100);
  PointVals(4, 100, SideLength + 100, 100);
  PointVals(5, 100, 100, SideLength + 100);
  PointVals(6, SideLength + 100, 100, SideLength + 100);
  PointVals(7, SideLength + 100, SideLength + 100, SideLength + 100);
  PointVals(8, 100, SideLength + 100, SideLength + 100);
  GraphicsScreen;
end;

procedure TCube.CalcPoints;
begin
  For X:= 1 to 8 do
    VerticeVals(X, Point[X].X + Round(SideLength * Cos(RotationAngle)),
                   Point[X].Y + Round(SideLength * Sin(RotationAngle)));
end;

procedure TCube.Draw;
begin
  For X:= 1 to 3 do
    Line(Vertice[X].X, Vertice[X].Y, Vertice[X + 1].X, Vertice[X + 1].Y);
  Line(Vertice[1].X, Vertice[1].Y, Vertice[4].X, Vertice[4].Y);
  For X:= 5 to 7 do
    Line(Vertice[X].X, Vertice[X].Y, Vertice[X + 1].X, Vertice[X + 1].Y);
  Line(Vertice[8].X, Vertice[8].Y, Vertice[5].X, Vertice[5].Y);
  For X:= 1 to 4 do
    Line(Vertice[X].X, Vertice[X].Y, Vertice[X + 4].X, Vertice[X + 4].Y);
end;

begin
  GraphicsScreen;
  Cube.ReadStuff;
  For Cube.RotationAngle:= 1 to 90 do
  begin
    Cube.CalcPoints;
    Cube.Draw;
    Delay(500);
  end;
  ReadKey;
  CloseGraph;
end.
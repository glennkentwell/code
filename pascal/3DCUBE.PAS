program Cube;
uses Crt,
     Graph, GrafBits;
type
  T3DPoint = record
    X, Y, Z: integer;
  end;
  T2DPoint = record
    X, Y: integer;
  end;
var
  Point3D: array[1..8] of T3DPoint;
  Point2D: array[1..8] of T2DPoint;
  ScreenDist, ScreenX, ScreenY,
  I: integer;

procedure InitCube;
begin
  Point3D[1].X:= 1;  Point3D[1].Y:= 1;  Point3D[1].Z:= 4;
  Point3D[2].X:= 2;  Point3D[2].Y:= 1;  Point3D[2].Z:= 4;
  Point3D[3].X:= 1;  Point3D[3].Y:= 2;  Point3D[3].Z:= 4;
  Point3D[4].X:= 2;  Point3D[4].Y:= 2;  Point3D[4].Z:= 4;
  Point3D[5].X:= 1;  Point3D[5].Y:= 1;  Point3D[5].Z:= 5;
  Point3D[6].X:= 2;  Point3D[6].Y:= 1;  Point3D[6].Z:= 5;
  Point3D[7].X:= 1;  Point3D[7].Y:= 2;  Point3D[7].Z:= 5;
  Point3D[8].X:= 2;  Point3D[8].Y:= 2;  Point3D[8].Z:= 5;
  For I:= 1 to 8 do
  begin
    Point3D[I].X:= Point3D[I].X;
    Point3D[I].Y:= Point3D[I].Y;
    Point3D[I].Z:= Point3D[I].Z;
  end;
  ScreenDist:= 200;
end;

procedure Calc2DPoints;
begin
  For I:= 1 to 8 do
  begin
    Point2D[I].X:= ScreenDist * Point3D[I].X div Point3D[I].Z;
    Point2D[I].Y:= ScreenDist * Point3D[I].Y div Point3D[I].Z;
    Point2D[I].X:= DivX - Point2D[I].X;
    Point2D[I].Y:= DivY - Point2D[I].Y;
  end;
end;

procedure DrawCube;
begin
  Line(Point2D[1].X, Point2D[1].Y, Point2D[2].X, Point2D[2].Y);
  Line(Point2D[2].X, Point2D[2].Y, Point2D[4].X, Point2D[4].Y);
  Line(Point2D[3].X, Point2D[3].Y, Point2D[4].X, Point2D[4].Y);
  Line(Point2D[3].X, Point2D[3].Y, Point2D[1].X, Point2D[1].Y);

  Line(Point2D[4].X, Point2D[4].Y, Point2D[8].X, Point2D[8].Y);
  Line(Point2D[6].X, Point2D[6].Y, Point2D[2].X, Point2D[2].Y);
  Line(Point2D[1].X, Point2D[1].Y, Point2D[5].X, Point2D[5].Y);
  Line(Point2D[7].X, Point2D[7].Y, Point2D[3].X, Point2D[3].Y);

  Line(Point2D[6].X, Point2D[6].Y, Point2D[5].X, Point2D[5].Y);
  Line(Point2D[6].X, Point2D[6].Y, Point2D[8].X, Point2D[8].Y);
  Line(Point2D[7].X, Point2D[7].Y, Point2D[5].X, Point2D[5].Y);
  Line(Point2D[8].X, Point2D[8].Y, Point2D[7].X, Point2D[7].Y);
end;

{Xv = -Xsiné + Ycosé

Yv = -X(cosé)(cosí) - Y(siné)(cosí) + Zsiní

Zv = -X(cosé)(siní) - Y(siné)(siní) - Zcosí + p}

procedure Play;
var
  Angle,
  X, Y, Z: integer;
begin
  if (Angle < 0) or (Angle > 360) then Angle:= 10;
  Inc(Angle, 5);
  For I:= 1 to 8 do
  begin
{    Inc(Point3D[I].Z);}
    Point3D[I].X:= Round((- Point3D[I].X * Sin(Angle)) - (Point3D[I].Y * Cos(Angle)));
    Point3D[I].Y:= Round((- Point3D[I].Y * Sin(Angle)) - (Point3D[I].Y * Cos(Angle)));
{    Round((- Point3D[I].X * Cos(10) * Cos(10)) +
                         (- Point3D[I].Y * Sin(10) * Cos(10))
                         + Point3D[I].Z * Sin(10));}
{    Dec(Point3D[I].X);
    Dec(Point3D[I].Y);}
  end;
end;

begin
  GraphicsScreen;
  InitCube;
  Repeat
    Calc2DPoints;
    DrawCube;
    Play;
    Delay(10);
    ClearDevice;
  until KeyPressed;
  ReadKey;
  CloseGraph;
end.

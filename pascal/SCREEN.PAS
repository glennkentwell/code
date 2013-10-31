program Screeny;
uses crt, graph, GrafBits;
const
  Browns: array[0..6] of integer = (183, 184, 185, 186, 112, 113, 114);
  Greens: array[0..17] of integer=(119, 115,
                                   188, 189, 190, 191, 192, 193,
                                   212, 213, 214, 215, 216, 217, 218, 194,  210, 187);
var
  X, Y, C, I: integer;

procedure Init;
begin
  VGA256;
end;

procedure BrownScreen;
begin
  Init;
  X:= 0;
  While X < MaxX do
  begin
  For C:= 0 to 6 do
  begin
    SetColor(Browns[C]);
    Line(0, X, MaxX, X);
    Inc(X);
  end;
  end;
  ReadKey;
  ClearDevice;
  For C:= 0 to MaxY do
  For X:= 0 to MaxX do
    PutPixel(X, C, Browns[Random(7)]);
  C:= 0;
  ReadKey;
  SetFillStyle(1, Browns[5]);
  Bar(0, 0, MaxX, MaxY);
  Line(0, C + 1, MaxX, C + 1);
  Line(0, C , MaxX, C);
  While C < MaxY do
  begin
    Inc(C, 10);
    SetColor(Browns[0]);
    Line(0, C, MaxX, C);
    SetColor(Browns[6]);
    Line(0, C + 1, MaxX, C + 1);
    Line(0, C + 2, MaxX, C + 2);
  end;
end;

procedure GreenScreen;
begin
  X:= 0;
  For C:= 45 to 49 do
  begin
    SetColor(C);
    Line(0, X, MaxX, X);
    Inc(X);
  end;
  For C:= 115 to 123 do
  begin
    SetColor(C);
    Line(0, X, MaxX, X);
    Inc(X);
  end;
  For C:= 138 to 146 do
  begin
    SetColor(C);
    Line(0, X, MaxX, X);
    Inc(X);
  end;
  For C:= 187 to 194 do
  begin
    SetColor(C);
    Line(0, X, MaxX, X);
    Inc(X);
  end;
  For C:= 210 to 220 do
  begin
    SetColor(C);
    Line(0, X, MaxX, X);
    Inc(X);
  end;
  ReadKey;
  ClearDevice;
  For X:= 0 to 17 do
  begin
    SetColor(Greens[X]);
    Line(0, X, MaxX, X);
  end;
  ReadKey;
  ClearDevice;
  C:= 0;
  I:= 1;
  For Y:= 0 to MaxY do
  For X:= 0 to MaxX do
  begin
    PutPixel(X, Y, Greens[C]);
    Inc(C, I);
    if C > 16 then I:= -1;
    if C < 1 then I:= 1;
  end;
  For Y:= 0 to MaxY do
  For X:= 0 to MaxX do
  begin
    PutPixel(X, Y, Greens[Random((Y + 40) div 18)]);
  end;
end;

begin
  Init;
  GreenScreen;
  ReadKEy;
  CloseGraph;
end.
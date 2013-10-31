program Shaded;
Uses Graph, Crt, GrafBits;
Var X, Y: integer;

procedure Shades;
begin
  For X:= MaxY downto 1 do
    For Y:= 0 to DivY do
    begin
      PutPixel(Random(MaxX), DivY - Random(Y), Blue);
      PutPixel(Random(MaxX), DivY + Random(Y), Green);
      if KeyPressed then Break;
    end;
  For Y:= 0 to DivY do
    For X:= 0 to MaxX do
    begin
      PutPixel(Random(X), Random(Y), Red);
      PutPixel(MaxX - Random(X), MaxY - Random(Y), LightRed);
      if KeyPressed then Break;
    end;
  For Y:= 0 to DivY do
    For X:= 0 to DivX do
    begin
      PutPixel(DivX - Random(X), DivY - Random(Y), Magenta);
      PutPixel(DivX + Random(X), DivY + Random(Y), Yellow);
      PutPixel(DivX - Random(X), DivY + Random(Y), LightBlue);
      PutPixel(DivX + Random(X), DivY - Random(Y), Cyan);
      if KeyPressed then Break;
    end;
  For Y:= 0 to MaxY do
    For X:= 0 to DivX do
    begin
      PutPixel(Random(DivX), Random(MaxY + 1), Black);
      PutPixel(Random(DivX) + DivX, Random(MaxY + 1), White);
      if KeyPressed then Break;
    end;
  For Y:= 0 to MaxY do
    For X:= 0 to DivX do
    begin
      PutPixel(X, Y, Black);
      PutPixel(MaxX - X, MaxY - Y, White);
      if KeyPressed then Break;
    end;
end;

begin
  GraphicsScreen;
  Randomize;
  While not KeyPressed do Shades;
  ReadKey;
  CloseGraph;
end.
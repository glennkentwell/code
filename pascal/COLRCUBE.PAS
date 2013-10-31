program Grafficks;
uses Graph, Crt, GrafBits;
var
  Red, Green, Blue: integer;

procedure DrawCube;
begin
    SetRGBPalette(1, Red, Green, Blue);
    SetColor(1);
    Line(43, 0, 0, 25);
    Line(0, 25, 43, 50);
    Line(43, 50, 43, 100);
    Line(0, 75, 43, 100);
    Line(0, 25, 0, 75);
    Line(43, 0, 86, 25);
    Line(86, 25, 86, 75);
    Line(86, 75, 43, 100);
    Line(43, 50, 86, 25);
end;

begin
  GraphicsScreen;
  SetViewPort(DivX - 43, DivY - 50, DivX + 43, DivY + 50, ClipOn);
  While not KEyPressed do
  begin
    For Red:= 0 to 63 do
    begin
      Green:= Red;
      Blue:= Green;
      DrawCube;
    end;
    Red:= 1;
    Green:= Red;
    Blue:= Green;
    While Red <> 0 do
    begin
    DrawCube;
    Inc(Red);
    if Red = 64 then
    begin
      Red:= 63;
      Inc(Green);
      if Green = 64 then
      begin
        Green:= 63;
        Inc(Blue);
        if Blue = 64 then
        begin
          Blue:= 0;
          Red:= 0;
          Green:= 0;
        end;
      end;
    end;
    end;
  end;
  ReadKey;
  CloseGraph;
end.

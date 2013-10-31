program Nuclear;
uses Crt, Graph, GrafBits;

var
  R, G, B: integer;
  X, Y: integer;

begin
  VGA256;
  X:= 0;
  R:= 0;
  G:= R;
  B:= R;
  For R:= 0 to 63 do
  begin
    SetRGBPalette(R, R, 0, 0);
    SetColor(R);
    Line(R, 0, R, 50);
    Line(126 - R, 0, 126 - R, 50);
  end;
  R:= 0;
  For G:= 0 to 63 do
  begin
    SetRGBPalette(G + 126, G, (G div 2) * 3, 0);
    SetColor(G + 126);
    Line(G, 60, G, 110);
    Line(126 - G, 60, 126 - G, 110);
  end;
  G:= 0;
  For B:= 0 to 63 do
  begin
    SetRGBPalette(B + 190, 0, 0, B);
    SetColor(B + 190);
    Line(B, 120, B, 170);
    Line(126 - B, 120, 126 - B, 170);
  end;
  For X:= 0 to 255 do
  begin
    SetColor(X);
    Line(X, 180, X, 199);
  end;
{  ReadKey;
  ClearDevice;
  For B:= 0 to 63 do
  begin
    SetRGBPalette(B + 126, 0, B, 0);
    SetColor(B + 126);
    Line(B, 0, B, MaxY);
    Line(126 - B, 0, 126 - B, MaxY);
    Line(MaxX - B, 0, MaxX - B, MaxY);
    Line(MaxX - 126 + B, 0, MaxX - 126 + B, MaxY);
  end;}
  ReadKEy;
  CloseGRaph;
end.
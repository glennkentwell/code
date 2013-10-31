program Nuclear;
uses Crt, Graph, GrafBits;
const
  NumSpheres = 250;
  Slow = 5;
  Wait = 1500;
var
  Colr: integer;
  XP, YP, Tmr,
  Col: integer;
  R, G, B: integer;
  X, Y: integer;

procedure SetThePalette;
var
  D: integer;
  S: string;
begin
  Y:= 0;
  X:= 0;  R:= 0;  G:= R;
  B:= R;  W:= R;  D:= 255;
  SetColor(D);
  SetTextJustify(1, 1);
  OutTextXY(DivX, DivY, 'Please wait...');
  For R:= 0 to 63 do
  begin
    SetRGBPalette(R, R, 0, 0);
    SetRGBPalette(R + 64, R, R, R);
    SetRGBPalette(R + 126, R, R, 0);
    SetRGBPalette(R + 192, 0, 0, R);
    SetRGBPalette(D, 63 - R, 63 - R, 63 - R);
    if R = 62 then
    begin
      SetFillStyle(1, 0);
      Bar(0, 0, MaxX, MaxY);
    end;
  end;
end;

procedure Draw;
begin
  Inc(Y);
  if Y > NumSpheres then
  begin
    Y:= 0;
    ClearDevice;
  end;
  For X:= Colr - 63 to Colr do
  begin
    Dec(R);
    SetFillStyle(1, X);
    SetColor(X);
    FillEllipse(XP, YP, R, Round((R / 2.5) * 2));
    Delay(Slow);
  end;
  Delay(Wait);
end;

procedure Bubbles;
begin
  Colr:= Random(4);
  if Colr = 0 then Colr:= 63;
  if Colr = 1 then Colr:= 192;
  if Colr = 2 then Colr:= 255;
  if Colr = 4 then Colr:= 127;
  R:= 0; X:= 0;
  XP:= Random(MaxX); YP:= Random(MaxY);
  While R < 10 do R:= Random(60);
  Draw;
end;

begin
  VGA256;
  SetThePalette;
  Randomize;
  While not KeyPressed do Bubbles;
  ReadKey;
  CloseGRaph;
end.
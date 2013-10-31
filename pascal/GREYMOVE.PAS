program Rad;
uses
  Crt, Graph,
  GrafBits;


var
  X, Y,
  Counter,
  XDir, YDir: integer;
  XRadius, YRadius, XRadDir, YRadDir, MaxXRad, MaxYRad,
  Colour, Greyness, GreyDir: integer;

procedure InfluentialStuff;
const Rnd = 2;
begin
  Randomize;
  MaxXRad:= Random(50) + 5;
  MaxYRad:= Random(50) + 5;
  if XDir > 0 then XDir:= Random(Rnd) + 1
    else XDir:= Random(Rnd) - Rnd;
  if YDir > 0 then YDir:= Random(Rnd) + 1
    else YDir:= Random(Rnd) - Rnd;
end;

procedure Move;
begin
  if X > MaxX then XDir:= -1;
  if Y > MaxY then YDir:= -1;
  if X < 1 then XDir:= 1;
  if Y < 1 then YDir:= 1;
  Inc(X, XDir);
  Inc(Y, YDir);
end;

procedure ChangeColourRadius;
begin
  if Colour >= 15 then GreyDir:= -1;
  if Colour <= 0 then GreyDir:= 1;
  Inc(Colour, GreyDir);
  SetColor(Colour);
  SetFillStyle(1, Colour);
  Inc(XRadius, XRadDir);
  Inc(YRadius, YRadDir);
  if XRadius > MaxXRad then XRadDir:= -1;
  if YRadius > MaxYRad then YRadDir:= -1;
  if XRadius < 1 then XRadDir:= 1;
  if YRadius < 1 then YRadDir:= 1;
end;

procedure Draw;
begin
  ChangeColourRadius;
  FillEllipse(X, Y, XRadius, YRadius);
end;

procedure DoTheFlashyStuff;
var
  Z: integer;
  Palette: PaletteType;
begin
  Y:= 0;
  While not KeyPressed do
  begin
    Inc(Y);
    if Y > 15 then Y:= 0;
    With Palette do
    begin
      Size:= 15;
      For X:= 0 to 15 do
      begin
        Colors[X]:= X + Y;
        if Colors[X] > 15 then Colors[X]:= Abs(Colors[X] - 16);
      end;
    end;
    SetAllPalette(Palette);
  end;
{  X:= 5;
  Z:= 0;
  Y:= 6;
  While not KeyPressed do
  begin
    Inc(X);
    Inc(Y);
    if X > 15 then
    begin
      X:= 1;
      Inc(Z);
      if Z > 15 then Z:= 0;
    end;
    if Y > 15 then Y:= 1;
    SetPalette(X + Z, Y);
  end;}

end;

procedure Initialize;
begin
  GraphicsScreen;
  GradePalette(Bl);
  Randomize;
  X:= Random(MaxX);
  Y:= Random(MaxY);
  XDir:= 1;
  YDir:= 1;
  XRadius:= 3; YRadius:= 3;
  XRadDir:= 1; YRadDir:= 1;
  Greyness:= 0;
  GreyDir:= 1;
  Counter:= 0;
end;

begin
  Initialize;
  InfluentialStuff;
  While (not KeyPressed) and (Counter < 10000) do
  begin
    Move;
    Draw;
    if Random(3) = 1 then InfluentialStuff;
    Inc(Counter);
  end;
  DoTheFlashyStuff;
  While KeyPressed do ReadKey;
  CloseGraph;
end.
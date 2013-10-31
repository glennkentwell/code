program Rad;
uses
  Crt, Graph,
  GrafBits;

const
   Hues: array[1..7] of Colour = (Gr, Aq, Bl, Pu, LPu, Re, Ye);

var
  X, Y,
  Counter,
  XDir, YDir: integer;
  Hue: Colour;
  Palette: PaletteType;
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

procedure Move;
begin
  if X > MaxX then XDir:= -1;
  if Y > MaxY then YDir:= -1;
  if X < 1 then XDir:= 1;
  if Y < 1 then YDir:= 1;
  Inc(X, XDir);
  Inc(Y, YDir);
end;

procedure Draw;
begin
  ChangeColourRadius;
  FillEllipse(X, Y, XRadius, YRadius);
end;

procedure MoveAndDraw;
begin
  While (not KeyPressed) and (Counter < 10000) do
  begin
    Move;
    Draw;
    if Random(3) = 1 then InfluentialStuff;
    Inc(Counter);
  end;
end;

procedure FlashyStuff;
var
  Z: integer;
  Colour: Word;
begin
  Y:= 0;  Z:= 0;
  GetPalette(Palette);
  While (not KeyPressed) and (Z < 10) do
  begin
    With Palette do
    begin
      Colour:= Colors[0];
      For X:= 0 to 14 do
        Colors[X]:= Colors[X + 1];
      Colors[15]:= Colour;
    end;
    SetAllPalette(Palette);
    Inc(Y);
    if Y = 16 then
    begin
      Inc(Z);
      Y:= 0;
    end;
  end;
end;

procedure ChangeHues;
begin
  X:= 0;  Y:= 0;
  While (not KeyPressed) and (Y < 14) do
  begin
    Inc(X);  Inc(Y);
    if X > 7 then X:= 1;
    GradePalette(Hues[X]);
  end;
end;

procedure CoolRectangle;
begin
  For Y:= 1 to 20 do
  For X:= 1 to 15 do
  begin
    SetColor(X);
    Rectangle(DivX - (X + (Y * 15)), DivY - (X + (Y * 15)), DivX + (X + (Y * 15)), DivY + (X + (Y * 15)));
  end;
end;

procedure TurnItBlack;
begin
  GetPalette(Palette);
  With Palette do
    For X:= 1 to 15 do
    begin
      Colors[X]:= Colors[0];
      SetAllPalette(Palette);
      Delay(100);
    end;
end;

procedure Initialize;
begin
  GraphicsScreen;
  Randomize;
  Hue:= Hues[Random(6) + 1];
  GradePalette(Hue);
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
  MoveAndDraw;
  FlashyStuff;
  ChangeHues;
  CoolRectangle;
  FlashyStuff;
  TurnItBlack;
  While KeyPressed do ReadKey;
  CloseGraph;
end.


{ this is the stupid flashy stuff }
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
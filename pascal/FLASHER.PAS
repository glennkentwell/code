program Nuclear;
uses Crt, Graph, GrafBits;
const
  NumFlashers = 2;
  NumSpheres = 3000;
  Slow = 0;
  Wait = 0;

type
  TFlasher = object
    Color,
    XPos, YPos: integer;
    R, G, B: integer;
    procedure SetThePalette;
    procedure Draw(Colour: integer);
  end;

var
  X, Y,
  Colr: integer;
  Flasher: array[1..2] of TFlasher;

procedure TFlasher.SetThePalette;
var
  I, D: integer;
begin
  D:= 255;
  SetColor(D);
  SetTextJustify(1, 1);
  OutTextXY(DivX, DivY, 'Please wait...');
  R:= 0;
  G:= 0;
  B:= 0;
  For I:= 0 to 63 do
  begin
    R:= I;
    SetRGBPalette(R, R, 0, 0);
    SetRGBPalette(R + 64, R, R, R);
    SetRGBPalette(R + 126, R, R, 0);
    SetRGBPalette(R + 192, 0, 0, R);
    SetRGBPalette(D, 63 - R, 63 - R, 63 - R);
{    if R = 62 then
    begin
      SetFillStyle(1, 0);
      Bar(0, 0, MaxX, MaxY);
    end;}
  end;
end;

procedure TFlasher.Draw;
var
  X: integer;
begin
  For X:= Colr - 63 to Colr do
  begin
    Dec(R);
    SetFillStyle(1, X);
    SetColor(X);
    FillEllipse(XPos, YPos, R, Round((R / 2.5) * 2));
  end;
end;

procedure Bubbles;
begin
  Colr:= Random(4);
  if Colr = 0 then Colr:= 63;
  if Colr = 1 then Colr:= 192;
  if Colr = 2 then Colr:= 255;
  if Colr = 4 then Colr:= 127;
  X:= 0;
  While X < 10 do X:= Random(60);
  Flasher[X].Draw(X);
end;

begin
  VGA256;
  For X:= 1 to NumFlashers do
    Flasher[X].SetThePalette;
  Randomize;
  While not KeyPressed do
    Bubbles;
  ReadKey;
  CloseGRaph;
end.
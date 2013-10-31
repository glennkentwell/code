unit grafbits;

interface
procedure GraphicsScreen;
procedure VESAScreen(Mode: integer);
procedure VGA256;
procedure GraphicsForce(Grd, Grm: integer; Path: string);
procedure ScreenVars;
procedure Button (x1,y1,x2,y2,os:integer);
procedure Point(Exx, Whyy, Size, Culla : integer);
                                  {X coord, Y coord, size in pixels, colour}

procedure DrawTubeLine(Ex, Why, Leng, Col : integer; XorY : String);
procedure Tube(StartX, StartY, Length : integer; XoY : String);
{              'XoY' = Ver to draw horizontal tube
               'XoY' = Hor to draw vertical tube          }

procedure InitBlocks;
procedure BlockArea(X1, Y1, X2, Y2 : integer);
procedure RGB256;
type
  Colour = (Grey, Bl, Gr, Re, Ye, Pu, LPu, Aq);

procedure GradePalette(Hue: Colour);

var
  DivX, DivY : integer;
  MaxX, MaxY : integer;
  L, W : integer;
  Block, Half : Pointer;

Var
  GraphDRiver, GraphMode, Errorcode : integer;

implementation
uses graph;

procedure GraphicsScreen;
Begin
  GraphDriver := Detect;
  InitGraph (GraphDriver,GraphMode, '');
  ErrorCode := GraphResult;
  If ErrorCode <> GrOK Then
    Begin
      Writeln ('Graphics error : ', grapherrormsg (errorcode));
      Writeln (' Program aborted...');
      Halt(1);
    End;
  MaxX := GetMaxX;
  MaxY := GetMaxY;
  DivX := GetMaxX Div 2;
  DivY := GetMaxY Div 2;
end;

procedure VESAScreen;
Begin
  GraphDriver:= InstallUserDriver('VESA16', nil);
  InitGraph (GraphDriver,Mode, '');
  ErrorCode := GraphResult;
  If ErrorCode <> GrOK Then
    Begin
      Writeln ('Graphics error : ', grapherrormsg (errorcode));
      Writeln (' Program aborted...');
      Halt(1);
    End;
  MaxX := GetMaxX;
  MaxY := GetMaxY;
  DivX := GetMaxX Div 2;
  DivY := GetMaxY Div 2;
end;

procedure VGA256;
Begin
  GraphDriver:= InstallUserDriver('VGA256', nil);
  GraphMode:= 0;
  InitGraph (GraphDriver, GraphMode, '');
  ErrorCode := GraphResult;
  If ErrorCode <> GrOK Then
    Begin
      Writeln ('Graphics error : ', grapherrormsg (errorcode));
      Writeln (' Program aborted...');
      Halt(1);
    End;
  MaxX := GetMaxX;
  MaxY := GetMaxY;
  DivX := GetMaxX Div 2;
  DivY := GetMaxY Div 2;
end;

procedure GraphicsForce;
Begin
  InitGraph (GrD,GrM, Path);
  ErrorCode := GraphResult;
  If ErrorCode <> GrOK Then
    Begin
      Writeln ('Graphics error : ', grapherrormsg (errorcode));
      Writeln (' Program aborted...');
      Halt(1);
    End;
  MaxX := GetMaxX;
  MaxY := GetMaxY;
  DivX := GetMaxX Div 2;
  DivY := GetMaxY Div 2;
end;

procedure ScreenVars;
begin
  MaxX := GetMaxX;
  MaxY := GetMaxY;
  DivX := GetMaxX Div 2;
  DivY := GetMaxY Div 2;
end;

procedure Point;
Var S, XInty, YInty : integer;
begin
  S := Size div 2;
  For XInty := Exx to Exx+S do
    For YInty := Whyy to Whyy+S do
      PutPixel (XInty,YInty,Culla);
end;

procedure button;
begin
  rectangle (x1,y1,x2,y2);
  line (x1,y1,x1+os,y1+os);
  line (x2,y2,x2-os,y2-os);
  line (x2,y1,x2-os,y1+os);
  line (x1,y2,x1+os,y2-os);
  rectangle (x1+os,y1+os,x2-os,y2-os);
end;

procedure DrawTubeLine;
begin
  SetColor(Col);
  if XorY = 'Hor' then
  begin
    MoveTo(Ex, GetY + 1);
    LineTo(Ex + Leng, GetY);
  end;
  if XorY = 'Ver' then
  begin
    MoveTo(GetX + 1, Why);
    LineTo(GetX, Why + Leng);
  end;
end;  { DrawTubeLine }

procedure Tube;
begin
  MoveTo(StartX, StartY);
  DrawTubeLine(StartX, StartY, Length, 8, XoY);
  DrawTubeLine(StartX, StartY, Length, 0, XoY);
  DrawTubeLine(StartX, StartY, Length, 8, XoY);
  DrawTubeLine(StartX, StartY, Length, 8, XoY);
  DrawTubeLine(StartX, StartY, Length, 7, XoY);
  DrawTubeLine(StartX, StartY, Length, 7, XoY);
  DrawTubeLine(StartX, StartY, Length, 7, XoY);
  DrawTubeLine(StartX, StartY, Length, 15, XoY);
  DrawTubeLine(StartX, StartY, Length, 15, XoY);
  DrawTubeLine(StartX, StartY, Length, 15, XoY);
  DrawTubeLine(StartX, StartY, Length, 15, XoY);
  DrawTubeLine(StartX, StartY, Length, 7, XoY);
  DrawTubeLine(StartX, StartY, Length, 7, XoY);
  DrawTubeLine(StartX, StartY, Length, 7, XoY);
  DrawTubeLine(StartX, StartY, Length, 8, XoY);
  DrawTubeLine(StartX, StartY, Length, 8, XoY);
  DrawTubeLine(StartX, StartY, Length, 0, XoY);
  DrawTubeLine(StartX, StartY, Length, 8, XoY);
end;  { Tube }

procedure InitBlocks;
Var
  X : integer;
  Size : Word;
begin
  { Full block }
  SetColor(Brown);
  SetFillStyle(1, Brown);
  L := 39;
  W := 20;
  Bar(0, 0, L, W);
  SetColor(LightGray);
  Line(2, 2, L - 2, 2);
  Line(L - 2, 2, L - 2, W - 2);
  SetColor(Black);
  Line(2, 2, 2, W - 2);
  Line(2, W - 2, L - 2, W - 2);
  For X := 1 to 50 do
    PutPixel(Random(36) + 1, Random(16) + 3, Black);
  Size := ImageSize(0, 0, L, W);
  GetMem(Block, Size);
  GetImage(0, 0, L, W, Block^);
  { End full block, start half block }
  L := 119;
  W := 19;
  SetColor(Brown);
  SetFillStyle(1, Brown);
  Bar(L - 20, 0, L, W);
  SetColor(LightGray);
  Line(L - 18, W - 17, L - 1, W - 17);
  Line(L - 1, W - 17, L - 1, W - 1);
  SetColor(Black);
  Line(L - 18, W - 18, L - 18, W - 1);
  Line(L - 18, W - 1, L - 1, W - 1);
  For X := 1 to 50 do
    PutPixel(Random(L - 3) + 100, Random(W - 3) + 3, Black);
  Size := ImageSize(100, 0, L, W);
  GetMem(Half, Size);
  GetImage(100, 0, L, W, Half^);
  { end half block }
end;

procedure BlockArea;
Var
  X, Y : integer;
  Lin : Boolean;
begin
  X := X1;
  Y := Y1;
  Lin := False;
  Repeat
    if Lin = True then
    begin
      PutImage(X, Y, Half^, NormalPut);
      Inc(X, 20);
    end;
    While X + 40 <= X2 do
    begin
      PutImage(X, Y, Block^, NormalPut);
      Inc(X, 40);
    end;
    if X = X2 - 20 then
    begin
      PutImage(X, Y, Half^, NormalPut);
      Inc(X, 20);
    end;
    Inc(Y, 20);
    X := X1;
    if Lin = True then Lin := False
      else Lin := True;
  Until Y >= Y2;
end;

procedure RestorePalette;
begin
end;

procedure GradePalette;
var
  G, R, X: integer;
begin
  X:= 0;  G:= 0;
  For X:= 1 to 15 do
    SetPalette(X, X);
  if Hue = Grey then
  For R:= 0 to 15 do
  begin
    SetRGBPalette(R, G, G, G);
    Inc(G, 4);
  end;
  if Hue = Bl then
  For R:= 0 to 15 do
  begin
    SetRGBPalette(R, 0, 0, G);
    Inc(G, 4);
  end;
  if Hue = Gr then
  For R:= 0 to 15 do
  begin
    SetRGBPalette(R, 0, G, 0);
    Inc(G, 4);
  end;
  if Hue = Re then
  For R:= 0 to 15 do
  begin
    SetRGBPalette(R, G, 0, 0);
    Inc(G, 4);
  end;
  if Hue = Ye then
  For R:= 0 to 15 do
  begin
    SetRGBPalette(R, G, G, 0);
    Inc(G, 4);
  end;
  if Hue = Pu then
  For R:= 0 to 15 do
  begin
    SetRGBPalette(R, G, 0, G);
    Inc(G, 4);
  end;
  if Hue = LPu then
  For R:= 0 to 15 do
  begin
    SetRGBPalette(R, G, G div 2, G);
    Inc(G, 4);
  end;
  if Hue = Aq then
  For R:= 0 to 15 do
  begin
    SetRGBPalette(R, 0, G, G);
    Inc(G, 4);
  end;
end;

procedure RGB256;
var
  R, G, B: integer;
  X, Y: integer;
begin
  For R:= 0 to 63 do
  begin
    SetRGBPalette(R, R, 0, 0);
    SetColor(R);
    MoveTo(0, 0);
    OutText('Just a sec...');
{    Line(R, 0, R, 50);
    Line(126 - R, 0, 126 - R, 50);}
  end;
  R:= 0;
  For G:= 1 to 63 do
  begin
    SetRGBPalette(G + 127, G, G + 127, 0);
    SetColor(G + 126);
{    Line(G, 60, G, 110);
    Line(126 - G, 60, 126 - G, 110);}
  end;
  G:= 0;
  For B:= 0 to 63 do
  begin
    SetRGBPalette(B + 190, 0, 0, B);
    SetColor(B + 190);
{    Line(B, 120, B, 170);
    Line(126 - B, 120, 126 - B, 170);}
  end;
  For X:= 0 to 255 do
  begin
    SetColor(X);
    Line(X, 180, X, 199);
  end;
end;
end.

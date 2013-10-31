program Graphics;
Uses
  Crt,
  Graph, GrafBits,
  Tones;
const
  OT : array[0..4] of shortint = (0, 1, -1, 2, -2);
  Bits = 900;
type
  TPixel = object
    XPos, YPos, Rad: integer;
    Colour : Word;
    procedure GiveMeLife;
    procedure WhatDoIDo;
    procedure EraseMe;
    procedure DrawMe;
  end;

Var
  OldPalette: PaletteType;
  Gd, Gm, Grd, Grm,
  X, Y, MaxRad, MinRad,
  Col, rx, ry, Counter, Clr : integer;
  Motion,
  No, Ex, Why : integer;
  Del, Sz, DvX, DvY : integer;
  Bit: array[1..Bits] of TPixel;
  GotBall, ChangeGraphics, Vesa,
  XDir, YDir, DirX, DirY, DirRx, DirRy : Boolean;
  Ball: Pointer;
  Size: Word;
  XPos, YPos: array[1..2] of integer;
  Poly: array[1..5] of PointType;

procedure TPixel.GiveMeLife;
begin
  XPos := Random(9) - 5;
  YPos := Random(9) - 5;
  Rad := Random(Sz) + 1;
  if XPos = 0 then XPos := OT[Random(3) + 1];
  if YPos = 0 then YPos := OT[Random(3) + 1];
  Colour := Random(Clr) + 1;
end;

procedure TPixel.WhatDoIDo;
begin
  if XPos < 0 then Dec(XPos, Random(Abs(XPos)) + OT[Random(2)])
    else Inc(XPos,Random(Abs(XPos)) + OT[Random(2)]);
  if YPos < 0 then Dec(YPos, Random(Abs(YPos)) + OT[Random(2)])
    else Inc(YPos,Random(Abs(YPos)) + OT[Random(2)]);
  if XPos > GetMaxX then Inc(No);
end;

procedure TPixel.DrawMe;
begin
  Point(DivX + XPos, DivY + YPos, Rad, Colour);
end;

procedure TPixel.EraseMe;
begin
  Point(DvX + XPos, DvY + YPos, Rad, 0);
end;

procedure Quitter;
begin
  ReadKey;
  CloseGraph;
  Halt(0);
end;

procedure Explosion;
Var Co : integer;
    S : string;
begin
  Randomize;
  Clr := 15;
  For Co := 1 to Bits do
  begin
    Bit[Co].GiveMeLife;
  end;
  Repeat
  if KeyPressed then Quitter;
  For Co := 1 to Bits do
    Bit[Co].DrawMe;
  For Co := 1 to Bits do
  begin
{    Bit[Co].EraseMe;}
    Bit[Co].WhatDoIDo;
  end;
  Until No > Bits div 2;
  No := 0;
end;

procedure Shades;
begin
  For X:= DivX downto 1 do
    For Y:= 0 to DivY do
    begin
      PutPixel(Random(MaxX), DivY - Random(Y), Blue);
      PutPixel(Random(MaxX), DivY + Random(Y), Green);
      if KeyPressed then Quitter;
    end;
  For Y:= 0 to DivY div 2 do
    For X:= 0 to DivX do
    begin
      PutPixel(Random(MaxX), Random(Y), LightBlue);
      PutPixel(Random(MaxX), MaxY - Random(Y), LightGreen);
      if KeyPressed then Quitter;
    end;
end;

procedure MiddleShades;
begin
  For Y:= 0 to DivY div 2 do
    For X:= 0 to DivX do
    begin
      PutPixel((DivX + DivX div 2) - Random(X), (DivY + DivY div 2) - Random(Y), Magenta);
      PutPixel(DivX div 2 + Random(X), DivY div 2 + Random(Y), Yellow);
      PutPixel((DivX + DivX div 2) - Random(X), DivY div 2 + Random(Y), Red);
      PutPixel(DivX div 2 + Random(X), (DivY + DivY div 2) - Random(Y), LightRed);
      if KeyPressed then Quitter;
    end;
  For Y:= 0 to DivY div 4 do
    For X:= 0 to DivX div 4 do
    begin
      PutPixel(DivX - Random(X), DivY - Random(Y), LightMagenta);
      PutPixel(DivX + Random(X), DivY + Random(Y), LightMagenta);
      PutPixel(DivX - Random(X), DivY + Random(Y), LightMagenta);
      PutPixel(DivX + Random(X), DivY - Random(Y), LightMagenta);
      if KeyPressed then Quitter;
    end;
end;

procedure UpDownLines;
Var Ln, C: integer;
begin
  SetWriteMode(NormalPut);
  Randomize;
  For C:= 7 downto 1 do
  begin
    X:= 0;
    While X < MaxX do
    begin
      Inc(X);
      SetColor(C);
      Ln:= Random(DivY);
      Line(X, DivY - Ln div 2, Random(X), DivY + Ln div 2);
      Inc(X);
      SetColor(7 + C);
      Ln:= Random(DivY);
      Line(X, DivY - Ln div 2, Random(X), DivY + Ln div 2);
      if KeyPressed then Quitter;
    end;
    X:= MaxX;
    While X > 0 do
    begin
      Dec(X);
      SetColor(C);
      Ln:= Random(DivY);
      Line(Random(X), DivY - Ln div 2, X, DivY + Ln div 2);
      if KeyPressed then Quitter;
      Dec(X);
      SetColor(7 + C);
      Ln:= Random(DivY);
      Line(Random(X), DivY - Ln div 2, X, DivY + Ln div 2);
    end;
  end;
  SetWriteMode(NormalPut);
end;

procedure Ellipses;
begin
  Col := GetMaxColor;
  SetColor(Col);
  Y := DivY;
  X := DivX;
  While X >= -10 do
  begin
    SetFillStyle(1, Col);
    FillEllipse(DivX, DivY, X, Y);
    Dec(X, 4);
    Dec(Y, 4);
    Dec(Col);
    if Col < 1 then Col := 15;
    if KeyPressed then Quitter;
  end;
end;

procedure Circles;
begin
  X := DivX;
  While X > 0 do
  begin
    SetFillStyle(1, Col);
    FillEllipse(DivX, DivY, X, X);
    Dec(X, 3);
    Dec(Col);
    if Col < 1 then Col := 15;
    if KeyPressed then Quitter;
  end;
end;

procedure Operate;
begin
  if X < Rx then DirX := True;
  if X > MaxX - Rx then DirX := False;
  if Y < Ry then DirY := True;
  if Y > MaxY - Ry then DirY := False;
  Case DirX of
    True: Inc(X, 3);
    False: Dec(X, 3);
  end;
  Case DirY of
    True: Inc(Y, 2);
    False: Dec(Y, 2);
  end;
  Dec(Col);
  if Col < 0 then Col := 15;
  if DirRx = True then Inc(rx, 1)
    else Dec(rx, 1);
  if rx < MinRad then DirRx := True;
  if rx > MaxRad then DirRx := False;
  if DirRy = True then Inc(ry, 1)
    else Dec(ry, 1);
  if ry < MinRad then DirRy := True;
  if ry > MaxRad then DirRy := False;
  Inc(Counter);
end;

procedure Bounce;
Var Co: integer;
begin
  MinRad:= MaxY div 45;
  MaxRad:= MaxY div 10;
  SetColor(Black);
  Randomize;
  Co:= 0;
  X := Random(MaxX);
  Y := Random(MaxY);
  Rx := 0;
  Ry := 0;
  Counter := 0;
  Col := 15;
  Repeat
    SetFillStyle(1, Random(Col));
    FillEllipse(X, Y, rx, ry);
    if KeyPressed then Quitter;
    Operate;
    Inc(Co);
  Until Co >= 1500;
end;

procedure Test(Colr, XYPix, XPos: integer);
begin
  if XYPix <= Colr then
    PutPixel(XPos, Y, Black)
    else if KeyPressed then Quitter;
end;

procedure BlackColours;
Var Co, XYP: shortint;
begin
  Co:= 0;
  While Co < 15 do
  begin
    Inc(Co, 8);
    For X:= 0 to DivX do
      For Y:= 0 to MaxY do
      begin
        XYP:= GetPixel(X, Y);
        Test(Co, XYP, X);
        XYP:= GetPixel(MaxX - X, Y);
        Test(Co, XYP, MaxX - X);
      end;
  end;
end;

procedure Dissolve;
Var
  Sx, Xx, Yy: integer;
  XLong: longint;
begin
  SetColor(Black);
  Yy:= 0;
  While Yy <= MaxY do
  begin
    Line(0, Yy, MaxX, Yy);
    Inc(Yy, 2);
  end;
  Yy:= MaxY;
  While Yy >= 0 do
  begin
    Line(0, Yy, MaxX, Yy);
    Dec(Yy, 2);
  end;
  ClearDevice;
end;

procedure Star;
begin
  Dissolve;
  For Y:= 0 to DivY do
    For X:= 0 to DivX do
    begin
      PutPixel(DivX - Random(X), DivY - Random(Y), LightBlue);
      PutPixel(DivX + Random(X), DivY + Random(Y), LightBlue);
      PutPixel(DivX - Random(X), DivY + Random(Y), LightBlue);
      PutPixel(DivX + Random(X), DivY - Random(Y), LightBlue);
      if KeyPressed then Quitter;
    end;
  For Y:= 0 to DivY div 2 do
    For X:= 0 to DivX div 2 do
    begin
      PutPixel(DivX - Random(X), DivY - Random(Y), Yellow);
      PutPixel(DivX + Random(X), DivY + Random(Y), Yellow);
      PutPixel(DivX - Random(X), DivY + Random(Y), Yellow);
      PutPixel(DivX + Random(X), DivY - Random(Y), Yellow);
      if KeyPressed then Quitter;
    end;
end;

procedure Spiral;
Var I: integer;
begin
  ScreenVars;
  X:= 1;
  Y:= 0;
  Col:= 0;
  For I:= 0 to 10 do
  begin
    X:= 1;
    Inc(Col);
    SetColor(Col);
    While X < DivX do
    begin
      Ellipse(DivX, DivY, Y, Y + 5 * I, X + I, X);
      Inc(Y, 5 * I);
      Inc(X, 1);
      if KeyPressed then Quitter;
    end;
  end;
end;

procedure BlackSpiral;
var Diag: integer;
begin
  Diag:= (MaxX div 4) * 5;
  Diag:= Diag div 2;
  SetFillStyle(1, Black);
  SetColor(Black);
  X:= 2;
  While X < DivX + (DivX div 2) do
  begin
    FillEllipse(DivX, DivY, X, X);
    Inc(X, X div 2);
    if KeyPressed then Quitter;
  end;
end;

procedure Polies;
Var Co, I: integer;
begin
  if Vesa = True then Star;
  if Vesa <> True then
  begin
  Co:= 0;
  Randomize;
  Repeat
    Inc(Co);
    Col:= Random(15);
    SetColor(Col);
    SetFillStyle (1,Col);
    I := Random(9) + 1;
    For Ex := 1 to I do
      With Poly[Ex] do
      begin
        X := Random(MaxX);
        Y := Random(MaxY);
      end;
    FillPoly (I,Poly);
    MaxX := GetMaxX;
    MaxY := GetMaxY;
    if KeyPressed then Quitter;
  Until Co >= 200;
  end;
  Dissolve;
end;

procedure RadialLines;
Var X2, Y2 : integer;
begin
  SetWriteMode(XORPut);
  X2 := DivX;
  Y2 := 0;
  SetLineStyle(0, 0, 3);
  While X2 >= 0 do
  begin
    SetColor(Col);
    Line(X, Y, X2, Y2);
    Dec(X2, 3);
    Dec(Col);
    if Col < 0 then Col := 15;
  end;
  While Y2 <= MaxY do
  begin
    SetColor(Col);
    Line(X, Y, X2, Y2);
    Inc(Y2, 3);
    Dec(Col);
    if Col < 0 then Col := 15;
  end;
  While X2 <= MaxX do
  begin
    SetColor(Col);
    Line(X, Y, X2, Y2);
    Inc(X2, 3);
    Dec(Col);
    if Col < 0 then Col := 15;
  end;
  While Y2 >= 0 do
  begin
    SetColor(Col);
    Line(X, Y, X2, Y2);
    Dec(Y2, 3);
    Dec(Col);
    if Col < 0 then Col := 15;
    if KeyPressed then Quitter;
  end;
  While X2 >= DivX do
  begin
    SetColor(Col);
    Line(X, Y, X2, Y2);
    Dec(X2, 3);
    Dec(Col);
    if Col < 0 then Col := 15;
  end;
  SetLineStyle(0, 0, 1);
  SetWriteMode(NormalPut);
end;

procedure BlackRadialLines;
Var X2, Y2 : integer;
begin
  X2 := DivX;
  Y2 := 0;
  Col:= Black;
  SetColor(Col);
  SetLineStyle(0, 0, 3);
  While X2 >= 0 do
  begin
    Line(X, Y, X2, Y2);
    Dec(X2, 3);
  end;
  While Y2 <= MaxY do
  begin
    Line(X, Y, X2, Y2);
    Inc(Y2, 3);
  end;
  While X2 <= MaxX do
  begin
    Line(X, Y, X2, Y2);
    Inc(X2, 3);
  end;
  While Y2 >= 0 do
  begin
    Line(X, Y, X2, Y2);
    Dec(Y2, 3);
    if KeyPressed then Quitter;
  end;
  While X2 >= DivX do
  begin
    Line(X, Y, X2, Y2);
    Dec(X2, 3);
  end;
  SetLineStyle(0, 0, 1);
  ClearDevice;
end;

procedure Lines;
var X2, Y2, X3, Y3, Times : integer;
begin
  Randomize;
  X := Random(MaxX);
  Y := Random(MaxY);
  X2 := Random(MaxX);
  Y2 := Random(MaxY);
  X3 := Random(MaxX);
  Y3 := Random(MaxY);
  SetLineStyle(0, 0, 3);
  if not Vesa then Times:= 2000
    else Times:= 3000;
  For Counter := 1 to Times do
  begin
    Operate;
    Rx := 0; Ry := 0;
    SetColor(Col);
    Line(X2, Y2, X, Y);
    Line(X3, Y3, X, Y);
    if KeyPressed then Quitter;
  end;
  SetLineStyle(0, 0, 1);
end;

{procedure CalcBall;
begin
  Case XDir of
    True: Inc(XPos, (DivY - Abs(Ypos)) div Motion);
    False: Dec(XPos, (DivY - Abs(Ypos)) div Motion);
  end;
  Case YDir of
    True: Inc(YPos, (DivX - Abs(XPos)) div Motion);
    False: Dec(YPos, (DivX - Abs(XPos)) div Motion);
  end;
  if XPos > DivX  then XDir := False;
  if XPos < -DivX + 30 then XDir := True;
  if YPos > DivY then YDir := False;
  if YPos < -DivY + 30 then YDir := True;
end;

procedure BallPatterns;
Var
  XDir, YDir: Boolean;
begin
  XDir := True;
  YDir := True;
  PutImage(DivX - XPos, DivY - YPos, Ball^, XORPut);
  Repeat
    CalcBall;
    PutImage(DivX - XPos, DivY - YPos, Ball^, XORPut);
    Delay(Y);
  Until Co = 5000;
  ReadKey;
  CloseGraph;
end.}

procedure ColourIt;
var Ex, Why : integer;
begin
  Ex:= 0;
  Why:= 0;
  While Ex <= DivX do
  begin
    SetColor(Random(16));
    SetFillStyle(1, Random(16));
    Rectangle(Ex, Why, MaxX - Ex, MaxY - Why);
    Inc(Ex); Inc(Why);
    if KeyPressed then Quitter;
  end;
end;

procedure BlackIt;
var Sx, Sy, Ex, Ey, Dif : integer;
begin
  DivX:= GetMaxX div 2;
  DivY:= GetMaxY div 2;
  Sx := DivX;
  Sy := DivY;
  Ex := DivX;
  Ey := DivY;
  if Vesa then Dif:= 8
    else Dif:= 2;
  While Sx >= -2 do
  begin
    SetColor(Black);
    SetFillStyle(1, Black);
    Bar(Sx, Sy, Ex, Ey);
    Dec(Sx, Dif); Dec(Sy, Dif);
    Inc(Ex, Dif); Inc(Ey, Dif);
    if KeyPressed then Quitter;
  end;
end;

function CalcBallMoveDist: integer;
var
  Divi, XMov: integer;
begin
  Divi:= 10;
  XMov:= 100;
  While XMov > 8 do
  begin
    Inc(Divi);
    XMov:= MaxX div Divi;
  end;
   CalcBallMoveDist:= Divi;
end;

procedure CalcBall(Distance, Nom: shortint);
begin
  Inc(XPos[Nom], MaxX div Distance);
  Inc(YPos[Nom], MaxY div Distance);
end;

procedure Screen;
begin
  if ChangeGraphics = True then
  begin
    if Vesa = True then
    begin
      Gd:= InstallUserDriver('VESA16', nil);
      Gm:= Grm;
    end
    else
    begin
      Gd:= VGA;
      Grm:= 2;
    end;
    CloseGraph;
    InitGraph(Gd, Grm, '');
    MaxX := GetMaxX;
    MaxY := GetMaxY;
    DivX := GetMaxX div 2;
    DivY := GetMaxY div 2;
  end
  else ClearDevice;
  DvX := DivX;
  DvY := DivY;
  Sz := 5;
  X := DivX;
  Y := DivY;
end;

procedure RedCircles;
begin
  X := 4;
  SetColor(Yellow);
  While X < DivX div 2 do
  begin
    SetFillStyle(1, Red);
    FillEllipse(DivX, DivY, X div 2, X div 4);
    Inc(X, X div 4);
    if KeyPressed then Quitter;
  end;
  X := 4;
  SetColor(Yellow);
  While X < MaxX do
  begin
    SetFillStyle(1, Red);
    FillEllipse(DivX, DivY, X, X div 2);
    Inc(X, X div 4);
    if KeyPressed then Quitter;
  end;
end;

procedure PixAcross(NegOrPos: Boolean);
begin
  if NegOrPos = True then
  For X:= 0 to MaxX do
  begin
    PutPixel(X, DivY - 3, Random(15) + 1);
    PutPixel(X, DivY - 2, Random(15) + 1);
    PutPixel(X, DivY - 1, Random(15) + 1);
    PutPixel(X, DivY, Random(15) + 1);
    PutPixel(X, DivY + 1, Random(15) + 1);
    PutPixel(X, DivY + 2, Random(15) + 1);
    PutPixel(X, DivY + 3, Random(15) + 1);
  end;
  if NegOrPos = False then
  For X:= MaxX downto 0 do
  begin
    PutPixel(X, DivY - 3, Random(15) + 1);
    PutPixel(X, DivY - 2, Random(15) + 1);
    PutPixel(X, DivY - 1, Random(15) + 1);
    PutPixel(X, DivY, Random(15) + 1);
    PutPixel(X, DivY + 1, Random(15) + 1);
    PutPixel(X, DivY + 2, Random(15) + 1);
    PutPixel(X, DivY + 3, Random(15) + 1);
  end;
end;

procedure GetBall;
begin
  GradePalette(Re);
  Y:= 120;
  For X:= 0 to 15 do
  begin
    Dec(Y);
    SetColor(X);
    SetFillStyle(1, X);
    FillEllipse(Y div 4, Y div 4, 15 - X, 15 - X);
  end;
  Size:= ImageSize(0, 0, 55, 50);
  GetMem(Ball, Size);
  GetImage(0, 0, 55, 50, Ball^);
end;

procedure BallSmash;
var
  Distance: shortint;
begin
  MaxX := GetMaxX;
  MaxY := GetMaxY;
  DivX := GetMaxX div 2;
  DivY := GetMaxY div 2;
  Distance:= CalcBallMoveDist;
  SetActivePage(0);
  if GotBall <> True then GetBall
    else GradePalette(Hues[Random(6) + 1]);
  GotBall:= True;
  For X:= 1 to 2 do
  begin
    XPos[X]:= 0;
    YPos[X]:= 0;
  end;
  Randomize;
  PutImage(MaxX, MaxY - 20, Ball^, XORPut);
  Repeat
    CalcBall(Distance, 1);
    PutImage(XPos[1], YPos[1], Ball^, NormalPut);
    CalcBall(Distance, 2);
    PutImage(MaxX - XPos[2], MaxY - YPos[2], Ball^, NormalPut);
    PutImage(MaxX - XPos[2], YPos[1], Ball^, NormalPut);
    PutImage(XPos[1], MaxY - YPos[2], Ball^, NormalPut);
    CalcBall(Distance, 1);
    PutImage(XPos[1], YPos[1], Ball^, NormalPut);
    CalcBall(Distance, 2);
    PutImage(MaxX - XPos[2], MaxY - YPos[2], Ball^, NormalPut);
    PutImage(MaxX - XPos[2], YPos[1], Ball^, NormalPut);
    PutImage(XPos[1], MaxY - YPos[2], Ball^, NormalPut);
    if KeyPressed then Quitter;
  Until YPos[1] >= DivY;
  SetFillStyle(1, Black);
  Bar(DivX, DivY, DivX * 2, DivY * 2);
  NormalColours;
  RedCircles;
  if not KeyPressed then
    PixAcross(False);
  if not KeyPressed then
  begin
    ClearDevice;
    PixAcross(True);
  end;
end;

procedure GetModes;
Var Moder: Integer;
begin
  if ParamCount > 0 then
  begin
    Val(ParamStr(1), Moder, Gd);
    Gd:= EGA;
    Case Moder of
      1: Gm:= 0;
      2: Gm:= 1;
      3:
      begin
        Gd:= VGA;
        Gm:= 2;
      end;
      4:
      begin
        Gd:= InstallUserDriver('VESA16', nil);
        Gm:= 0;
        Vesa:= True;
      end;
      5:
      begin
        Gd:= InstallUserDriver('VESA16', nil);
        Gm:= 1;
        Vesa:= True;
      end;
    end;
  end
  else
  begin
    Gd:= Detect;
    ChangeGraphics:= True;
  end;
  InitGraph(Gd, Gm, '');
end;

procedure Title;
Var Ca: integer;
begin
  Gd:= EGA;
  Gm:= 0;
  InitGraph(Gd, Gm, '');
  MaxX := GetMaxX;
  MaxY := GetMaxY;
  DivX := GetMaxX div 2;
  DivY := GetMaxY div 2;
  SetTextJustify(1, 1);
  SetTextStyle(1, 0, 5);
  SetUserCharSize(4, 2, 4, 3);
  SetColor(LightRed);
  For Ca:= 2 to 4 do
    OutTextXY(DivX + Ca, 60, 'Stuff');
  SetColor(Blue);
  For Ca:= -1 to 2 do
    OutTextXY(DivX + Ca, 60, 'Stuff');
  SetTextStyle(0, 0, 1);
  SetUserCharSize(5, 3, 5, 2);
  SetColor(Red);
  For Ca:= -1 to -0 do
    OutTextXY(0, 190, 'by Glenn Kentwell');
  SetColor(White);
  SetTextStyle(0, 0, 1);
  OutTextXY(MaxX - TextWidth('Press a key...'), 190, 'Press a key...');
  ReadKey;
  CloseGraph;
end;

begin
  GetModes;
  Repeat
    BallSmash;
    Shades;
    UpDownLines;
    MiddleShades;
    Bounce;
    RadialLines;
    BlackRadialLines;
    Spiral;
    BlackSpiral;
    Explosion;
    Lines;
    Circles;
    Dissolve;
    ColourIt;
    BlackIt;
    TonesRoutines;
  Until KeyPressed;
  CloseGraph;
  While KeyPressed do ReadKey;
end.
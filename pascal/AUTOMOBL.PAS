Program TryGraphics;
Uses Crt, Graph, GrafBits;
Var
  C, X, Y : Integer;
  Poly : array [1..10] of PointType;

procedure DrawFirstPoly;
begin
  SetFillStyle (6,Red);
  With Poly[1] do
  Begin
    X := 10;
    Y := 300;
  End;
  With Poly[2] do
  Begin
    X := 110;
    Y := 220;
  End;
  With Poly[3] do
  Begin
    X := 180;
    Y := 230;
  End;
  With Poly[4] do
  Begin
    X := 10;
    Y := 300;
  End;
  FillPoly (4,Poly);
end;

procedure MovePoly;
begin
  DrawFirstPoly;
  With Poly[1] do
  Begin
    X := 110;
    Y := 220;
  End;
  With Poly[2] do
  Begin
    X := 180;
    Y := 230;
  End;
  With Poly[3] do
  Begin
    X := 370;
    Y := 170;
  End;
  With Poly[4] do
  Begin
    X := 300;
    Y := 160;
  End;
  With Poly[5] do
  Begin
    X := 110;
    Y := 220;
  End;
  FillPoly (5,Poly);

  With Poly[1] do
  Begin
    X := 300;
    Y := 160;
  End;
  With Poly[2] do
  Begin
    X := 335;
    Y := 80;
  End;
  With Poly[3] do
  Begin
    X := 370;
    Y := 170;
  End;
  With Poly[4] do
  Begin
    X := 300;
    Y := 160;
  End;
  FillPoly (4,Poly);

  With Poly[1] do
  Begin
    X := 335;
    Y := 80;
  End;
  With Poly[2] do
  Begin
    X := 360;
    Y := 75;
  End;
  With Poly[3] do
  Begin
    X := 510;
    Y := 145;
  End;
  With Poly[4] do
  Begin
    X := 370;
    Y := 170;
  End;
  With Poly[5] do
  Begin
   X := 335;
   Y := 80;
  End;
  FillPoly (5,Poly);

  With Poly[1] do
  Begin
    X := 510;
    Y := 145;
  End;
  With Poly[2] do
  Begin
    X := 540;
    Y := 185;
  End;
  With Poly[3] do
  Begin
    X := 10;
    Y := 300;
  End;
  With Poly[4] do
  Begin
    X := 180;
    Y := 230;
  End;
    With Poly[5] do
  Begin
    X := 370;
    Y := 170;
  End;
  With Poly[6] do
  Begin
    X := 510;
    Y := 145;
  End;
  FillPoly (6,Poly);
end;

procedure Wheels2;
begin
  X := 500;
  Y := 180;
  For X := 500 to 550 do
    Ellipse (X,Y,0,360,30,40);
  Y := 250;
  For X := 180 to 220 do
    Ellipse (X,Y,0,360,30,40);
end;

procedure Wheels;
begin
  X := 500;
  Y := 180;
  For X := 500 to 550 do
    Ellipse (X,Y,0,360,30,40);
  Y := 240;
  For X := 80 to 120 do
    Ellipse (X,Y,0,360,30,40);
end;

procedure Soundy;
Var S1, S2, Ix : integer;
begin
  SetColor (Blue);
  OutTextXY (540,300,'RPM');
  OutTextXY (530,320,'x1000');
  OutTextXY (570,GetMaxY - 40,' 1');
  OutTextXY (570,GetMaxY - 80,' 2');
  OutTextXY (570,GetMaxY - 120,' 3');
  OutTextXY (570,GetMaxY - 160,' 4');
  OutTextXY (570,GetMaxY - 200,' 5');
  OutTextXY (570,GetMaxY - 240,' 6');
  OutTextXY (570,GetMaxY - 280,' 7');
  OutTextXY (570,GetMaxY - 320,' 8');
  OutTextXY (570,GetMaxY - 360,' 9');
  OutTextXY (570,GetMaxY - 400,'10');
  Setcolor (Red);
  Repeat
    S1 := 100;
    S2 := 60;
    Repeat
      Sound (S1);

      Sound (S2);
      Delay (30);
  SetFillStyle (1,0);
      Bar (600,0,630,GetMaxY);
  SetFillStyle (2,15);
      Bar (600,GetMaxY - S1,630,GetMaxY);
      Inc(S1,25);
      Inc(S2,20);
    Until S1 = 400;
    Repeat
      Sound (S1);

      Sound (S2);
      Delay (30);
  SetFillStyle (1,0);
      Bar (600,0,630,GetMaxY);
  SetFillStyle (2,15);
      Bar (600,GetMaxY - S1,630,GetMaxY);
      Dec(S1,20);
      Dec(S2,10);
    Until S1 = 20;
    S2 := 20;
    Ix := 0;
    Repeat
      Sound (S1);
      Sound (0); Delay (1);
      Sound (S2);
      Inc (Ix);
    Until Ix = 350;
    S1 := 100;
    S2 := 60;
  Until KeyPressed;
   NoSound;
end;

begin
  GraphicsScreen;
  Wheels;
  MovePoly;
    Wheels2;
  Soundy;
  ReadKey;
  CloseGraph;
end.

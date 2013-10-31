program Arcs;
Uses Graph, Crt, GrafBits;
Const
  XMove = 2;
  YMove = 2;
  StMove = 5;
  EnMove = -5;
  RMove = 1;
Var
  Buf,
  X, Y,
  X1, Y1,
  StAn, EnAn,
  SAn, EAn, R, R1: integer;
  XDir, YDir,
  X1Dir, Y1Dir, RDir, R1Dir: Boolean;
  ArcInfo : ArcCoordsType;

procedure Init;
Var Gd, Gm: integer;
begin
  Gd:= EGA;
  Gm:= 1;
  InitGraph(Gd, Gm, '');
  ScreenVars;
  StAn:= Random(90);
  EnAn:= Random(90);
  SAn:= Random(90);
  EAn:= Random(90);
  X:= Random(MaxX);
  Y:= Random(MaxY);
  X1:= Random(MaxX);
  Y1:= Random(MaxY);
  SetFillStyle(0, Black);
  R:= 60;
  R1:= 30;
end;

procedure Operate;
begin
    Inc(StAn, StMove);
    Inc(EnAn, EnMove);
    Inc(SAn, StMove);
    Inc(EAn, EnMove);
    Case XDir of
      True: Inc(X, XMove);
      False: Dec(X, XMove);
    end;
    Case YDir of
      True: Inc(Y, YMove);
      False: Dec(Y, YMove);
    end;
    if X > MaxX - R then XDir:= False;
    if X < R then XDir:= True;
    if Y > MaxY - R then YDir:= False;
    if Y < R then YDir:= True;
    Case RDir of
      True: Inc(R, RMove);
      False: Dec(R, RMove);
    end;
    Case X1Dir of
      True: Inc(X1, XMove);
      False: Dec(X1, XMove);
    end;
    Case Y1Dir of
      True: Inc(Y1, YMove);
      False: Dec(Y1, YMove);
    end;
    Case R1Dir of
      True: Inc(R1, RMove);
      False: Dec(R1, RMove);
    end;
    if X1 > MaxX - R1 then X1Dir:= False;
    if X1 < R1 then X1Dir:= True;
    if Y1 > MaxY - R1 then Y1Dir:= False;
    if Y1 < R1 then Y1Dir:= True;
    if R > 105 then RDir:= False;
    if R < 5 then RDir:= True;
    if R1 > 105 then R1Dir:= False;
    if R1 < 5 then R1Dir:= True;
end;

procedure Draw;
begin
    SetColor(Black);
    Arc(X, Y, StAn, EnAn, R);
    GetArcCoords(ArcInfo);
    with ArcInfo do
    begin
      SetColor(Magenta);
      Line(X, Y + 20, XStart, YStart);
      Line(X, Y - 20, XStart, YStart);
      Line(X + 20, Y, XStart, YStart);
      Line(X - 20, Y, XStart, YStart);
      SetColor(Yellow);
      Line(X, Y + 20, Xend, Yend);
      Line(X, Y - 20, Xend, Yend);
      Line(X + 20, Y, Xend, Yend);
      Line(X - 20, Y, Xend, Yend);
      SetColor(LightRed);
      Line(X, Y, Xend, Yend);
      Line(X, Y, XStart, YStart);
    end;
    SetColor(Black);
    Arc(X1, Y1, SAn, EAn, R1);
    GetArcCoords(ArcInfo);
    with ArcInfo do
    begin
      SetColor(Blue);
      Line(X, Y + 20, XStart, YStart);
      Line(X, Y - 20, XStart, YStart);
      Line(X + 20, Y, XStart, YStart);
      Line(X - 20, Y, XStart, YStart);
      SetColor(Green);
      Line(X, Y + 20, Xend, Yend);
      Line(X, Y - 20, Xend, Yend);
      Line(X + 20, Y, Xend, Yend);
      Line(X - 20, Y, Xend, Yend);
      SetColor(LightMagenta);
      Line(X, Y, Xend, Yend);
      Line(X, Y, XStart, YStart);
    end;
end;

begin
  Init;
  Repeat
    SetActivePage(1);
    SetVisualPage(0);
    ClearDevice;
    Operate;
    Draw;
    SetActivePage(0);
    SetVisualPage(1);
    ClearDevice;
    Operate;
    Draw;
  Until KeyPressed;
  CloseGraph;
  ReadKey;
end.

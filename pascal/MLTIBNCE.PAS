program TwoHundredAndFiftySixColours;
Uses Graph, Crt, GrafBits;
const Imgs = 5;
Var
  X, Y, DfX, DfY: array[0..Imgs] of integer;
  Inty, I,
  XP, YP, Tmr,
  Gd, Gm: integer;
  size:word;
  Img: array[0..Imgs] of pointer;
  XDir, YDir: array[0..Imgs] of boolean;

procedure Clear(xx: integer);
begin
  ClearDevice;
  if xx = 1 then
    X[xx]:= 0;
  if xx = 2 then
    Y[xx]:= 0;
end;

function TestXPos(xx: integer): Boolean;
begin
  if X[xx] > X[Inty] - 15 then
    if X[xx] < X[Inty] + 15 then
      TestXPos:= True;
end;

function TestYPos(xx: integer): Boolean;
begin
  if Y[xx] > Y[Inty] - 15 then
    if Y[xx] < Y[Inty] + 15 then
      TestYPos:= True;
end;

procedure CalcBall(xx: integer);
begin
  if X[xx] >= MaxX - 30 then
  begin
    XDir[xx] := False;
    X[xx] := MaxX - 30;
  end;
  if X[xx] < 0 then
  begin
    XDir[xx] := True;
    X[xx] := 0;
  end;
  if Y[xx] >= MaxY - 30 then
  begin
    YDir[xx] := False;
    Y[xx]:= MaxY - 31;
  end;
  if Y[xx] < 0 then
  begin
    YDir[xx] := True;
    Y[xx]:= 0;
  end;
  For Inty:= 0 to Imgs do
  begin
    if xx <> Inty then
    begin
      if TestXPos(xx) = True then
        if TestYPos(xx) = True then
        begin
          Case XDir[Inty] of
            True: XDir[Inty]:= False;
            False: XDir[Inty]:= True;
          end;
          Case YDir[Inty] of
            True: XDir[xx]:= False;
            False: YDir[xx]:= True;
          end;
        end;
     end;
  end;
  Case XDir[xx] of
    True: Inc(X[xx], DfX[xx]);
    False: Dec(X[xx], DfX[xx]);
  end;
  Case YDir[xx] of
    True: Inc(Y[xx], DfY[xx]);
    False: Dec(Y[xx], DfY[xx]);
  end;
end;

begin
  Gd:= Detect;
  InitGraph(Gd, Gm, '\tp\bgi');
  ScreenVars;
  Size:= ImageSize(0, 0, 30, 30);
  For I:= 0 to Imgs do
  begin
    Tmr:= Random(MaxColors) + 1;
    SetFillStyle(1, Tmr);
    SetColor(Tmr);
    XP:= MaxX div 100;
    YP:= MaxY div 100;
    YP:= YP * 2;
    FillEllipse(15, 15, XP, YP);
    GetMem(Img[I], Size);
    GetImage(0, 0, 30, 30, Img[I]^);
    X[I]:= Random(MaxX);
    Y[I]:= Random(MaxY);
    DfX[I]:= Random(5) + 1;
    DfY[I]:= Random(5) + 1;
  end;
  Randomize;
  ClearDevice;
  While not KeyPressed do
  begin
    For I:= 0 to Imgs do
    begin
      CalcBall(I);
      PutImage(X[I], Y[I], Img[I]^, normalput);
    end;
  end;
  ReadKey;
  CloseGraph;
end.




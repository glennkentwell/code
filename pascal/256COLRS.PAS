program FindColorIndices;
Uses Graph, Crt, GrafBits;
Var
  Gd, Gm,
  X, Y, Co: integer;
  Ch: char;
  Dir: Boolean;
  S: string;

procedure StartGraph;
begin
  Gd:= InstallUserDriver('VGA256', nil);
  InitGraph(Gd, Gm, '\tp\bgi');
  ScreenVars;
end;

procedure FindKey;
begin
  Ch:= ReadKey;
  if Ch <> #8 then
    Dir:= True
    else Dir:= False;
  if KeyPressed then ReadKey;
end;

procedure CalcPos;
Var
  Inca: shortint;
begin
  begin
  if Dir then
  begin
    Inc(X, 6);
    Inc(Co);
  end
  else
  begin
    Dec(X, 6);
    Dec(Co);
  end;
  if X > MaxX - 6 then
  begin
    X:= -1;
    Inc(Y, 6);
  end;
  if X < -1 then
  begin
    X:= 311;
    Dec(Y, 6);
  end;
  end;
end;

procedure TopBit;
begin
  X:= 6;
  Y:= 0;
  Co:= 0;
  For Co:= 0 to 255 do
  begin
    SetFillStyle(1, Co);
    Bar(X, Y, X + 4, Y + 4);
    Inc(X, 6);
    if X > MaxX - 6 then
    begin
      X:= 0;
      Inc(Y, 6);
    end;
  end;
end;

procedure DrawScreen;
begin
  TopBit;
  X:= -1;
  Y:= -1;
  Co:= 0;
  Dir:= True;
    SetFillStyle(1, Co);
    SetColor(Co);
    Rectangle(X, Y, X + 6, Y + 6);
    CalcPos;
    SetColor(White);
    Rectangle(X, Y, X + 6, Y + 6);
    Bar(0, 50, MaxX, MaxY);
    Str(Co - 1, S);
    OutTextXY(DivX, DivY, S);
    FindKey;
    Dec(Co);
  While Ch <> #27 do
  begin
    SetColor(Black);
    Rectangle(X, Y, X + 6, Y + 6);
    CalcPos;
    SetColor(Co);
    SetFillStyle(1, Co);
    SetColor(White);
    Rectangle(X, Y, X + 6, Y + 6);
    Bar(0, 50, MaxX, MaxY);
    Str(Co, S);
    OutTextXY(DivX, DivY, S);
    FindKey;
    end;
end;

begin
  StartGraph;
  DrawScreen;
end.

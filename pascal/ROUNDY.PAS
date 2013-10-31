program EGAGraphics;
Uses Graph, GrafBits, Crt, Animals;
Var
  Snd,
  X, Y, Ex, Wy,
  XPos, YPos,
  Col, Motion,
  Gd, Gm: integer;
  Size: Word;
  Ball: Pointer;
  MDir, XDir, YDir: Boolean;

procedure GetCmdLine;
begin
  if ParamCount <> 0 then Snd:= 5000
  else Snd:= 0;
end;

begin
  Gd:= InstallUserDriver('VGA256', nil);
  Gm:= 0;
  InitGraph(Gd, Gm, '\shoot');
  ScreenVars;
  GetCmdLine;
  Y:= 0;
  MDir:= True;
  Col:= Random(14) + 1;
  Motion := 1;
  SetLineStyle(7, 0, 1);
  SetWriteMode(NormalPut);
  Repeat
    Randomize;
    Inc(Col);
    if Col > 255 then Col:= 1;
    SetColor(Col);
    Sound(Snd);
    Delay(Snd div 5000);
    NoSound;
    X:= DivX;
    While X > 0 do
    begin
      Line(DivX, DivY div 2, X, Y);
      if KeyPressed then Break;
      Dec(X, Motion);
    end;
    Inc(Col);
    if Col > 255 then Col:= 1;
    SetColor(Col);
    Sound(Snd);
    Delay(Snd div 5000);
    NoSound;
    Y:= 0;
    While Y < MaxY do
    begin
      Line(DivX, DivY div 2, X, Y);
      if KeyPressed then Break;
      Inc(Y, Motion);
    end;
    Inc(Col);
    if Col > 255 then Col:= 1;
    SetColor(Col);
    Sound(Snd);
    Delay(Snd div 5000);
    NoSound;
    X:= 0;
    While X < MaxX do
    begin
      Line(DivX, DivY div 2, X, Y);
      if KeyPressed then Break;
      Inc(X, Motion);
    end;
    Inc(Col);
    if Col > 255 then Col:= 1;
    SetColor(Col);
    Sound(Snd);
    Delay(Snd div 5000);
    NoSound;
    Y:= MaxY;
    While Y > 0 do
    begin
      Line(DivX, DivY div 2, X, Y);
      if KeyPressed then Break;
      Dec(Y, Motion);
    end;
    Inc(Col);
    if Col > 255 then Col:= 1;
    SetColor(Col);
    Sound(Snd);
    Delay(Snd div 5000);
    NoSound;
    X:= MaxX;
    While X > DivX do
    begin
      Line(DivX, DivY div 2, X, Y);
      if KeyPressed then Break;
      Dec(X, Motion);
    end;
    Inc(Col);
    if Col > 255 then Col:= 1;
    SetColor(Col);
    Sound(Snd);
    Delay(Snd div 5000);
    NoSound;
    X:= DivX;
    While X > 0 do
    begin
      Line(DivX, DivY div 2, X, Y);
      if KeyPressed then Break;
      Dec(X, Motion);
    end;
    Inc(Col);
    if Col > 255 then Col:= 1;
    SetColor(Col);
    Sound(Snd);
    Delay(Snd div 5000);
    NoSound;
    Y:= 0;
    While Y < MaxY do
    begin
      Line(DivX, DivY div 2, X, Y);
      if KeyPressed then Break;
      Inc(Y, Motion);
    end;
    Inc(Col);
    if Col > 255 then Col:= 1;
    SetColor(Col);
    Sound(Snd);
    Delay(Snd div 5000);
    NoSound;
    X:= 0;
    While X < MaxX do
    begin
      Line(DivX, DivY div 2, X, Y);
      if KeyPressed then Break;
      Inc(X, Motion);
    end;
    Inc(Col);
    if Col > 255 then Col:= 1;
    SetColor(Col);
    Sound(Snd);
    Delay(Snd div 5000);
    NoSound;
    Y:= MaxY;
    While Y > 0 do
    begin
      Line(DivX, DivY div 2, X, Y);
      if KeyPressed then Break;
      Dec(Y, Motion);
    end;
    Inc(Col);
    if Col > 255 then Col:= 1;
    SetColor(Col);
    Sound(Snd);
    Delay(Snd div 5000);
    NoSound;
    X:= MaxX;
    While X > DivX do
    begin
      Line(DivX, DivY div 2, X, Y);
      if KeyPressed then Break;
      Dec(X, Motion);
    end;
    if KeyPressed then Break;
    if Motion > 400 then MDir:= False;
    if Motion < 4 then MDir:= True;
    Case MDir of
      True: Inc(Motion, 2);
      False: Dec(Motion, 4);
    end;
  Until KeyPressed;
  ReadKey;
  CloseGraph;
end.

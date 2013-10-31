program Nuclear;
uses Crt, Graph, GrafBits;

var
  Ball: Pointer;
  Size: Word;
  R, G, B: integer;
  X, Y,
  XMov, YMov: integer;

procedure Balls;
begin
  XMov:= 1;
  YMov:= 1;
  X:= 0;
  Y:= 0;
  ClearDevice;
  While not KeyPressed do
  begin
    PutImage(X, Y, Ball^, NormalPut);
    Inc(X, XMov);
    Inc(Y, YMov);
    if X > MaxX - 40 then XMov:= -1;
    if Y > MaxY - 40 then YMov:= -1;
    if X < 0 then XMov:= 1;
    if Y < 0 then YMov:= 1;
    Delay(5);
  end;
end;

begin
  GraphicsScreen;
  GradePalette(Re);
  Y:= 80;
  For X:= 0 to 15 do
  begin
    Dec(Y);
    SetColor(X);
    SetFillStyle(1, X);
    FillEllipse(Y div 4, Y div 4, 15 - X, 15 - X);
  end;
  Size:= ImageSize(0, 0, 40, 40);
  GetMem(Ball, Size);
  GetImage(0, 0, 40, 40, Ball^);
  PutImage(DivX, DivY, Ball^, NormalPut);
  Balls;
  ReadKey;
  CloseGraph;
end.

{ this looks cool, but i dont want it }
  Y:= 0;
  While Y < MaxX do
  begin
    For X:= 0 to 15 do
    begin
      SetColor(X);
      Line(Y + X, 0,  Y + X, MaxY);
      Line(Y - X, 0,  Y - X, MaxY);
      Line(0, Y + X, MaxX, Y + X);
      Line(0, Y - X, MaxX, Y - X);
    end;
    Inc(Y, 30);
  end;
  ReadKey;
  ClearDevice;

{ this is the old stuff it is dumb and this has no punctuation }
begin
  GraphicsScreen;
  X:= 0;  R:= 0;  G:= R;  B:= R;
  For X:= 1 to 15 do
    SetPalette(X, X);
  For R:= 0 to 15 do
  begin
    SetColor(R);
    SetFillStyle(1, R);
    SetRGBPalette(R, G, G, G);
    Line(R, 0, R, MaxY);
    Line(30 - R, 0, 30 - R, MaxY);
    Inc(G, 4);
  end;
  ReadKEy;
  CloseGRaph;
end.
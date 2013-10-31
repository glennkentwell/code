program Yeah;
uses Crt, Graph, GrafBits;
var
  Image: Pointer;
  X, Y, A, B: integer;
  Size: Word;

procedure ChangeColour;
var
 Z: integer;
begin
  A:= 0;
  Z:= Random(10);
  Case Z of
    1: GradePalette(Grey);
    2: GradePalette(Bl);
    3: GradePalette(Gr);
    4: GradePalette(Re);
    5: GradePalette(Ye);
    6: GradePalette(Pu);
    7: GradePalette(LPu);
    8: GradePalette(Aq);
  end;
end;

begin
  GraphicsScreen;
  GradePalette(Re);
  SetLineStyle(1, 1, ThickWidth);
  For X:= 1 to 15 do
  begin
    SetColor(X);
    Circle(15, 15, 16 - X);
  end;
  Size:= ImageSize(0, 0, 30, 30);
  GetMem(Image, Size);
  GetImage(0, 0, 30, 30, Image^);
    X:= Random(MaxX);
    Y:= Random(MaxY);
  While not KeyPressed do
  begin
    Inc(A);
    if A > 50 then
      ChangeColour;
    B:= A * (Random(20) - 10);
    Inc(X, A);
    Inc(Y, B);
    if (X > MaxX) or (Y > MaxY) or
       (X < 0) or (Y < 0) then
    begin
      X:= Random(MaxX);
      Y:= Random(MaxY);
    end;
    PutImage(X, Y, Image^, XORPut);
  end;
  ReadKey;
  CloseGraph;
end.


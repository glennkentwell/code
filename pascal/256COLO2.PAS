program DecipherColours;
Uses Graph, Crt;
Var
  Gd, Gm,
  I, X, Y: integer;
  Txt: String;

procedure WorkOutColours;
begin
  SetTextStyle(10, 0, 3);
  SetColor(Black);
  For I:= 1 to 255 do
  begin
    Str(I, Txt);
    SetFillStyle(1, I);
    Bar(X, Y, X+25, Y+8);
    OutTextXY(X, Y, Txt);
    Inc(X, 25);
    if X > GetMaxX then
    begin
      X:= 0;
      Inc(Y, 8);
    end;
  end;
end;

begin
  Gd:= InstallUserDriver('VGA256', nil);
  Gm:= 3;
  InitGraph(Gd, Gm, 'C:\Shoot');
  X:= 0;
  Repeat
  For I:= 16 to 31 do
  begin
    SetColor(I);
    Line(I+X, 0, I+X, GetMaxY);
  end;
  Inc(X, 16);
  For I:= 31 downto 16 do
  begin
    SetColor(I);
    Line((X+16)-I, 0, (X+16)-I, GetMaxY);
  end;
  Inc(X, 15);
  Until X > GetMaxX;
  SetColor(Red);
  SetTextJustify(1, 1);
  SetTextStyle(7, 0, 10);
  OutTextXY(100, 100, 'BARS');
end.

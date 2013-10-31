program TwoHundredAndFiftySixColours;
Uses Graph, Crt, GrafBits;
Var
  X, Y, I,
  XP, YP, Tmr,
  Gd, Gm: integer;
  size:word;
  Img: pointer;

procedure Writing;
begin
  SetColor(X);
  OutTextXY(DivX + XP, DivY - Y, 'Glenn''s 256 Colour');
  OutTextXY(DivX + XP, DivY + Y, 'Screen');
end;

procedure ChangeBkColour(Old, New: word);
Var Xix, Yiy: integer;
begin
  For Xix:= 320 downto DivX do
  For Yiy:= 0 to 200 do
    begin
      if GetPixel(Xix, Yiy) = Old then
        PutPixel(Xix, Yiy, New);
      if GetPixel(MaxX - Xix, Yiy) = Old then
        PutPixel(MaxX - Xix, Yiy, New);
    end;
end;

begin
  Gd:= InstallUserDriver('VGA256', nil);
  Gm:= 0;
  InitGraph(Gd, Gm, '\tp\bgi');
  ScreenVars;
(*  SetColor(Red);
  SetTextJustify(1, 1);
  SetTextStyle(1, 0, 4);
  SetUserCharSize(4, 4, 4, 3);
  Y:= TextHeight('M');
  XP:= -8;
  For X:= 16 to 31 do
  begin
    Writing;
    Inc(XP);
  end;
  XP:= 280;
  YP:= 140;
  Tmr:= 2;
  Y:= 15;
  For X:= 31 downto 16 do
  begin
    Inc(Y);
    SetFillStyle(1, Y);
    SetColor(Y);
    FillEllipse(XP, YP, ((X*3)-42) div Tmr, ((X*2)-26) div Tmr);
  end;
  XP:= 40;
  YP:= 140;
  Tmr:= 2;
  Y:= 15;
  For X:= 31 downto 16 do
  begin
    Inc(Y);
    SetFillStyle(1, Y);
    SetColor(Y);
    FillEllipse(XP, YP, ((X*3)-42) div Tmr, ((X*2)-26) div Tmr);
  end;
  ChangeBkColour(Blue, Red);
  ChangeBkColour(Red, Green);
  ChangeBkColour(Green, Magenta);
  ChangeBkColour(Magenta, 39);
  Y:= 16;
  For X:= 31 downto 16 do
  begin
    ChangeBkColour(X, Y);
    Inc(Y);
  end;*)
  SetFillStyle(1, Blue);
  SetColor(Blue);
  FillEllipse(15, 15, 10, 10);
  Size:= ImageSize(0, 0, 30, 30);
  GetMem(Img, Size);
  GetImage(0, 0, 30, 30, Img^);
  PutImage(100, 100, Img^, normalput);
end.




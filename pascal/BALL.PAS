program BallBuster;
Uses Graph, Crt, GrafBits;
Var
  XPos, YPos, Y, Gd, Gm, I: integer;
  Size: Word;
  Ball: Pointer;
  XDir, YDir: Boolean;
  Motion: Integer;
  R : real;

procedure Beginnings;
begin
  Gd := VGA;
  Gm := 1;
  InitGraph(Gd, Gm, '');
  SetColor(red);
  SetFillStyle(1, Red);
  FillEllipse(15, 10, 15, 10);
  SetColor(White);
  Ellipse(15, 10, 0, 70, 12, 8);
  Ellipse(15, 10, 80, 85, 12, 8);
  SetColor(Black);
  Ellipse(15, 10, 180, 270, 13, 9);
  Size:= ImageSize(0, 0, 30, 20);
  GetMem(Ball, Size);
  GetImage(0, 0, 30, 20, Ball^);
  ClearDevice;
  Randomize;
  XPos := DivX;
  Ypos := DivY;
  DivX := GetMaxX div 2;
  DivY := GetMaxY div 2;
end;

procedure GetDelay;
begin
  if ParamCount <> 0 then
  begin
    Val(ParamStr(1), R, I);
    if R < 1 then
    begin
      Y := Round(1000 * R);
      Motion := 30;
    end
    else
    begin
      Y := 0;
      Motion := Round(R);
    end;
  end
  else Motion := 20;
end;


procedure CalcBall;
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

begin
  Beginnings;
  GetDelay;
  XDir := True;
  YDir := True;
  PutImage(DivX - XPos, DivY - YPos, Ball^, XORPut);
  Repeat
    SetVisualPage(1);
    SetActivePage(2);
    ClearDevice;
    CalcBall;
    PutImage(DivX - XPos, DivY - YPos, Ball^, XORPut);
    Delay(Y);
    SetVisualPage(2);
    SetActivePage(1);
    ClearDevice;
    CalcBall;
    PutImage(DivX - XPos, DivY - YPos, Ball^, XORPut);
    Delay(Y);
  Until KeyPressed;
  ReadKey;
  CloseGraph;
end.


      Delay(Y);
      SetVisualPage(1);
      PutImage(XPos, YPos, Ball^, XORPut);
      SetActivePage(2);
      Inc(XPos, 1);
      if XPos > GetMaxX - 80 then
      begin
        Inc(YPos, 50);
        XPos := 10;
      end;
      if YPos > GetMaxY - 40 then YPos := 1;
      PutImage(XPos, YPos, Ball^, XORPut);
      Delay(Y);
      SetVisualPage(2);
      PutImage(XPos, YPos, Ball^, XORPut);

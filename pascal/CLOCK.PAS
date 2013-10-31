program Whatever;
Uses Graph, Crt, DateTime, GrafBits, Dos;
Var
  Dir : String;
  col, BkCol: Word;
  MaxX, MaxY : integer;
  Ho, Mi, Se, Hu : Integer;
begin
  VGA256;
  MaxX := GetMaxX;
  MaxY := GetMaxY;
  Col:= 97;
  BkCol:= 177;
  SetColor (Col);
  SetTextJustify (1,1);
  SetTextStyle (0, 0, 3);
  SetFillStyle(1, BkCol);
  Bar(0, 0, MaxX, MaxY);
  Repeat
    GetTime(H, Min, Sec, Hund);
    if Sec <> Se then
    begin
      if Min <> Mi then
      begin
        if H <> Ho then
          begin
            Bar(DivX - TextWidth('hh:mm:'), DivY - TextHeight('M'), DivX - TextWidth(':mm')+5, DivY + TextHeight('M'));
            OutTextXY(DivX - TextWidth('hh:m'),DivY, LeadingZero(H) + ':');
            Ho := H;
          end;
          Bar(DivX - TextWidth('mm:')+10, DivY - TextHeight('M'), DivX + TextWidth('m') - 10, DivY + TextHeight('M'));
          OutTextXY(DivX - TextWidth('m'), DivY, LeadingZero(Min) + ':');
          Mi := Min;
      end;
      Bar(DivX + TextWidth(':'), DivY - TextHeight('M'), DivX + TextWidth('mm:'), DivY + TextHeight('M'));
      OutTextXY(DivX + TextWidth('m:'), DivY, LeadingZero(Sec));
      Se := Sec;
    end;
  Until KeyPressed;
  ReadKey;
  CloseGraph;
end.
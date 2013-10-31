program Slide;
Uses Graph, GrafBits, Crt;
Var
  X, Y, S, Gd, Gm: integer;
  Image: Pointer;
  Size: Word;

begin
  Gd:= VGA;
  Gm:= 0;
  InitGraph(Gd, Gm, 'C:\TP\BGI');
  MaxX:= GetMaxX;  MaxY:= GetMaxY;
  DivX:= GetMaxX div 2;  DivY:= GetMaxY div 2;
  SetTextJustify(1, 1);
  S:= 4;
  SetTextStyle(1, 0, S);
  SetUserCharSize(S, 2, S, 3);
  SetColor(LightBlue);
  OutTextXY(DivX + 4, DivY, 'Level One');
  OutTextXY(DivX + 5, DivY, 'Level One');
  SetColor(Blue);
  OutTextXY(DivX, DivY, 'Level One');
  OutTextXY(DivX + 1, DivY, 'Level One');
  OutTextXY(DivX + 2, DivY, 'Level One');
  OutTextXY(DivX + 3, DivY, 'Level One');
  S:= 2;
  SetTextStyle(7, 0, S);
  SetUserCharSize(S, 2, S, 3);
  SetColor(LightGreen);
  OutTextXY(DivX + 2, DivY + TextHeight('a') * 2, 'The First');
  SetColor(Green);
  OutTextXY(DivX, DivY + TextHeight('a') * 2, 'The First');
  OutTextXY(DivX + 1, DivY + TextHeight('a') * 2, 'The First');
  ReadKey;
  CloseGraph;
end.

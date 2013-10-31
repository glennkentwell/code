program Whatever;
uses
  Graph, Crt,
  GrafBits;
const
  BlueColours: array[1..6] of integer = (111, 9, 1, 32, 33, 34);
var
  X, Y, I, J: integer;
  Inca: shortint;
  M: longint;
begin
  VGA256;
  Inca:= 5;
  Y:= 15;
{  For X:= 177 to 178 do
  begin
    Dec(Y, Inca);
    SetColor(X);
    SetFillStyle(1, X);
    FillEllipse(100, 100, Y, Y);
  end;
  For X:= 199 to 201 do
  begin
    Dec(Y, Inca);
    SetColor(X);
    SetFillStyle(1, X);
    FillEllipse(100, 100, Y, Y);
  end;}
  X:= Blue;
    Dec(Y, Inca);
    SetColor(X);
    SetFillStyle(1, X);
    FillEllipse(100, 100, Y, Y);
  Inca:= 2;
  For X:= 32 to 34 do
  begin
    Dec(Y, Inca);
    SetColor(X);
    SetFillStyle(1, X);
    FillEllipse(100, 100, Y, Y);
  end;
  Inca:= 1;
  X:= LightBlue;
    Dec(Y, Inca);
    SetColor(X);
    SetFillStyle(1, X);
    FillEllipse(100, 100, Y, Y);
  For X:= 111 downto 111 do
  begin
    Dec(Y, Inca);
    SetColor(X);
    SetFillStyle(1, X);
    FillEllipse(100, 100, Y, Y);
  end;
    J:= MAxY;
  For I:= 1 to (MaxX div 7) * 3 do
  For M:= 1 to 1100 do
    PutPixel(Random(I), Random(MAxY), BlueColours[Random(2) + 1]);
  For I:= 1 to (MaxX div 3) * 2 do
    For M:= 1 to 1100 do
    PutPixel(DivX + (Random(I) - I div 2), Random(MaxY), BlueColours[Random(3) + 2]);
  For I:= 1 to (MaxX div 7) * 3 do
    For M:= 1 to 1100 do
      PutPixel(MaxX - Random(I), Random(MaxY), BlueColours[Random(2) + 3]);
  SetTextStyle(1, 0, 3);
  SetTextJustify(1, 1);
  For I:= 40 to 44 do
  begin
    SetColor(I);
    OutTextXY(DivX - 40 + I ,DivY - 40 + I, 'The Blue Thing');
  end;
  Inc(I);
  SetColor(14);
    OutTextXY(DivX - 40 + I ,DivY - 40 + I, 'The Blue Thing');
  ReadKey;
  CloseGraph;
end.

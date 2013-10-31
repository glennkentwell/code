program Screener;
uses
  Crt, Graph,
  GrafBits;
var
  I, X, Y: integer;
  Col: Word;

procedure TitleScreen;
begin
  SetColor(White);
  SetFillStyle(1, White);
  SetTextJustify(1, 1);
  SetTextStyle(10, 0, 5);
  Y:= 0;
  While Y < DivY - 50 do
  begin
  For X:= 44 downto 32 do
  begin
    SetColor(X);
    OutTextXY(DivX, Y, 'HANGMAN');
    Inc(Y);
  end;
  For X:= 32 to 44 do
  begin
    SetColor(X);
    OutTextXY(DivX, Y, 'HANGMAN');
    Inc(Y);
  end;
  end;
  For X:= 16 to 31 do
  begin
    SetColor(X);
    Line(X, DivY, X, MaxY);
    Line(31 + (32 - X), DivY, 31 + (32 - X), MaxY);
    SetColor(31 + 16 - X);
    Line(X, DivY - 16 + X, 100, DivY - 16 + X);
{    Line(X + 16, DivY + (31 - X), X + 116, DivY + (31 - X));}
  end;
  ReadKey;
end;

begin
  VGA256;
  TitleScreen;
  CloseGraph;
end.
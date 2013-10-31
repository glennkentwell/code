program Drawings;
uses
  Crt, Graph,
  GrafBits, Buttons;

var
  Col: Word;
  X, Y: integer;

procedure Draw;
begin
  Col:= 1;
  Key.GetKeys;
  While Key.KeyOne <> #27 do
  begin
    if Key.KeyTwo = Up[2] then Dec(Y);
    if Key.KeyTwo = Down[2] then Inc(Y);
    if Key.KeyTwo = Left[2] then Dec(X);
    if Key.KeyTwo = Right[2] then Inc(X);
    if Key.KeyTwo = Home[2] then
    begin
      Dec(Y);
      MoveTo(X, Y);
      PutPixel(X, Y, Col);
      Dec(Y);
    end;
    if Key.KeyTwo = _End[2] then
    begin
      Inc(Y);
      MoveTo(X, Y);
      PutPixel(X, Y, Col);
      Inc(Y);
    end;
    if Key.KeyTwo = Del[2] then
    begin
      Dec(X);
      MoveTo(X, Y);
      PutPixel(X, Y, Col);
      Dec(X);
    end;
    if Key.KeyTwo = PgDn[2] then
    begin
      Inc(X);
      MoveTo(X, Y);
      PutPixel(X, Y, Col);
      Inc(X);
    end;
    if Key.KeyOne = Space[1] then
    begin
      Inc(Col);
      SetFillStyle(1, Col);
      Bar(MaxX - 20, MaxY - 20, MaxX, MaxY);
    end;
    MoveTo(X, Y);
    PutPixel(X, Y, Col);
    Key.GetKeys;
  end;
end;

begin
  GraphicsScreen;
  Draw;
  CloseGraph;
end.
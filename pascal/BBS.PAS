program DrawANSIGraphics;
uses
  Crt,
  Buttons, Cursor;

const
  NumSquares = 1760;
type
  PenState = (PUp, PDown);
  TSpace = record
    Ch: char;
    ForeColour, BackColour: Word;
  end;
  SpaceArray = array[1..NumSquares] of TSpace;

var
  Pen: PenState;
  Spce: SpaceArray;
  ForeCol, BackCol: Word;
  X, Y,
  Counter,
  Character: integer;

procedure HeadingColour(Focus: Boolean);
begin
  if Focus then
  begin
    TextColor(Yellow);
    TextBackGround(Black);
  end
  else
  begin
    TextColor(LightGray);
    TextBackGround(Black);
  end;
end;

procedure DoForeColour(Focus: Boolean);
begin
  GoToXY(1, 1);
  HeadingColour(Focus);
  Write('Foregd Colour : ');
  For X:= 0 to 15 do
  begin
    TextColor(X);
    if X = ForeCol then TextColor(X + Blink);
    if (ForeCol = 0) and (X = 0) then
    begin
      TextColor(White + Blink);
      TextBackGround(White);
      For Y:= 1 to 4 do Write('*');
    end
    else
      For Y:= 1 to 4 do Write(#219);
  end;
end;

procedure SelectFore;
begin
  Repeat
    DoForeColour(True);
    Key.GetKeys;
    if Key.Key = Right then
      if ForeCol < 15 then Inc(ForeCol)
        else ForeCol:= 0;
    if Key.Key = Left then
      if ForeCol > 0 then Dec(ForeCol)
        else ForeCol:= 15;
  Until Key.Key = Enter;
  DoForeColour(False);
end;

procedure DoBackColour(Focus: Boolean);
begin
  GoToXY(1, 2);
  HeadingColour(Focus);
  Write('Backgd Colour : ');
  For X:= 0 to 15 do
  begin
    TextColor(X);
    if X = BackCol then TextColor(X + Blink);
    if (BackCol = 0) and (X = 0) then
    begin
      TextColor(White + Blink);
      For Y:= 1 to 4 do Write('*');
    end
    else
      For Y:= 1 to 4 do Write(#219);
  end;
end;

procedure SelectBack;
begin
  Repeat
    DoBackColour(True);
    Key.GetKeys;
    if Key.Key = Right then
      if BackCol < 15 then Inc(BackCol)
        else BackCol:= 0;
    if Key.Key = Left then
      if BackCol > 0 then Dec(BackCol)
        else BackCol:= 15;
  Until Key.Key = Enter;
  DoBackColour(False);
end;

procedure DoChar(Focus: Boolean);
begin
  GoToXY(1, 3);
  HeadingColour(Focus);
  Write('Character ');
  TextColor(ForeCol);
  For X:= 176 to 223 do
  begin
    if X = Character then TextColor(ForeCol + Blink)
    else TextColor(ForeCol);
    Write(Chr(X));
  end;
end;

procedure SelectChar;
begin
  Repeat
    DoChar(True);
    TextBackGround(Black);
    Key.GetKeys;
    if Key.Key = Right then
      if Character < 223 then Inc(Character)
        else Character:= 176;
    if Key.Key = Left then
      if Character > 176 then Dec(Character)
        else Character:= 223;
  Until Key.Key = Enter;
  DoChar(False);
end;

procedure Select(Number: integer);
begin
  Window(1, 23, 80, 25);
  if Number = 1 then SelectFore;
  if Number = 2 then SelectBack;
  if Number = 3 then SelectChar;
  Window(1, 1, 80, 22);
  NormCursor;
end;

procedure ToolBar;
var
  X, Y: integer;
begin
  Window(1, 23, 80, 25);
  TextColor(LightGray);
  TextBackGround(Black);
  ClrScr;
  NoCursor;
  DoForeColour(False);
  DoBackColour(False);
  DoChar(False);
end;

procedure Init;
begin
  Window(1, 1, 80, 25);
  TextColor(LightGray);
  TextBackGround(Black);
  ClrScr;
  ForeCol:= LightGray;
  BackCol:= Black;
  Character:= 176;
end;

procedure DrawSpace;
begin
  TextColor(ForeCol);
  TextBackGround(BackCol);
  Write(Chr(Character));
end;

procedure DrawLeft;
begin
  if Counter > 1 then Dec(Counter);
  if Pen = PDown then
  begin
    Spce[Counter].Ch:= Chr(Character);
    Spce[Counter].ForeColour:= ForeCol;
    Spce[Counter].BackColour:= BackCol;
    if WhereX > 1 then
    begin
      GoToXY(WhereX - 1, WhereY);
      DrawSpace;
      GoToXY(WhereX - 1, WhereY);
    end
    else
    begin
      if WhereY <> 1 then
        GoToXY(80, WhereX - 1);
        DrawSpace;
      if WhereY <> 1 then
        GoToXY(80, WhereX - 1);
    end;
  end
  else
    if WhereX > 1 then GoToXY(WhereX - 1, WhereY)
    else if WhereY > 1 then GoToXY(80, WhereY - 1);
end;

procedure DrawRight;
begin
  if Counter < NumSquares then Inc(Counter);
  if Pen = PDown then
    DrawSpace;
end;

procedure DrawUp;
begin
end;

procedure DrawDown;
begin
end;

procedure TogglePen;
begin
  if Pen = PDown then Pen:= PUp
    else Pen:= PDown;
  TextColor(LightGreen);
  Window(2, 22, 80, 22);
  ClrScr;
  Write('Pen is ');
  if Pen = PDown then write ('down ') else
    Write('up ');
  For X:= WhereX to 78 do Write(#196);
  Window(1, 1, 80, 21);
end;

procedure Draw;
begin
  Window(1, 1, 80, 22);
  ClrScr;
  NormCursor;
  Repeat
    Key.GetKeys;
    if (Key.Key = F) or (Key.Key = f) then Select(1);
    if (Key.Key = B) or (Key.Key = b) then Select(2);
    if (Key.Key = C) or (Key.Key = c) then Select(3);
    if Key.Key = Left then DrawLeft;
    if Key.Key = Right then DrawRight;
    if Key.Key = Down then DrawDown;
    if Key.Key = Up then DrawUp;
    if Key.Key = Space then TogglePen;
  Until Key.Key = Esc;
end;

begin
  Init;
  ToolBar;
  Draw;
end.
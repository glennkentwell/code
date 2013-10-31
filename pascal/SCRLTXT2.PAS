program Shit;
uses Crt, Cursor;
const
  OneCol = Yellow;
  TwoCol = Red;
var
  X, Y: integer;
  S: string;

begin
  If ParamCount = 0 then
    S:= 'This shit is fucking Ph@'
    Else
    begin
      S:= '';
      For X:= 1 to ParamCount do
        S:= S + ' ' + ParamStr(X);
    end;
  ClrScr;
  NoCursor;
  TextColor(TwoCol);
  TextBackGround(Black);
  Write(S);
  Repeat
  Window(1, 1, 80, 25);
  ClrScr;
  X:= Random(80 - Length(S));
  Y:= Random(25);
  Window(X, Y, X + Length(S), Y);
  GoToXY(1, 1);
  For X:= 1 to Length(S) do
  if not KeyPressed then
  begin
    TextColor(OneCol);
    Write(S[X]);
    GoToXY(WhereX - 1, WhereY);
    Delay(50);
    TextColor(TwoCol);
    Write(S[X]);
  end;
  For X:= Length(S) downto 1 do
  if not KeyPressed then
  begin
    GoToXY(X, WhereY);
    TextColor(OneCol);
    Write(S[X]);
    Delay(50);
    GoToXY(WhereX - 1, WhereY);
    TextColor(TwoCol);
    Write(S[X]);
  end;
  Until KeyPressed;
end.
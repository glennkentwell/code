program WindowsDemo;
uses Crt;
var
  Co,
  X1, Y1,
  X2, Y2: integer;

procedure RandomWindow;
begin
  X1:= 0;
  Y1:= 0;
  X2:= 0;
  Y2:= 0;

  X1:= Random(80);
  Y1:= Random(26);
  X2:= Random(80);
  Y2:= Random(26);
  Co:= Random(15);
  TextColor(Co);
  TextBackGround(Co);
  Window(X1, Y1, X2, Y2);
  ClrScr;
end;

begin
  textmode(co80);
  While not KeyPressed do
    RandomWindow;
end.


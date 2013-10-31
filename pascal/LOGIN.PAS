program Login;
uses Crt, Buttons;
var
  X, Y: integer;

procedure SecretReadln;
begin
  Key.GetKeys;
  While Key.Key <> Enter do Key.GetKeys;
end;

begin
  TextColor(Blue);
  TextBackGround(LightGray);
  ClrScr;
  Write('login: ');
  Readln;
  Write('Password: ');
  SecretReadln;
  For Y:= 1 to 40 do
  begin
    TextColor(Red);
    For X:= 1 to 25 do
    begin
      GoToXY(1, X);
      Write('Login successful!!!!!!!!!!!!');
      Delay(10);
    end;
    TextColor(Yellow);
    For X:= 25 downto 1 do
    begin
      GoToXY(1, X);
      Write('Login successful!!!!!!!!!!!!');
      Delay(10);
    end;
  end;
end.
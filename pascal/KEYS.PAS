program Keysish;
uses
  Crt, Buttons;

begin
  While Key.KeyOne <> #27 do
  begin
    Key.GetKeys;
    ClrScr;
    GoToXY(25, 10); Write(Ord(Key.Key[1]));
    GoToXY(25, 12); Write(Ord(Key.KeyTwo));
  end;
end.
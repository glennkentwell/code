program QikMnu;
uses
  Crt;

const
  Qestn = 'Do you want to load QuikMenu? [Y/N]';
  Blank = '                                   ';

var
  X, Y, I: integer;

procedure Downer;
begin
  X:= 40 - Length(Qestn) div 2;
  For Y:= 1 to 12 do
  begin
    if Y <> 1 then
    begin
      GoToXY(X, Y - 1); Write(Blank);
      GoToXY(X, 25 - Y); Write(Blank);
    end;
    GoToXY(X, Y); Write(Qestn);
    GoToXY(X, 24 - Y); Write(Qestn);
    Delay(50);
  end;
end;

begin
  TextColor(LightGray);
  TextBackGround(Black);
  ClrScr;
  Downer;
end.

program QikMnu;
uses
  Crt;

const
  Qestn: array[1..2] of string = ('Do you want to load QuikMenu? [Y/N]', 'Default is Yes in 15 seconds');
  Blank = '                                   ';

var
  X, Y, I: integer;

procedure Downer;
begin
  X:= 40 - Length(Qestn[1]) div 2;
  For Y:= 1 to 12 do
  begin
    if Y <> 1 then
    begin
      GoToXY(X, Y - 1); Write(Blank);
      GoToXY(X, 25 - Y); Write(Blank);
    end;
    GoToXY(X, Y); Write(Qestn[1]);
    GoToXY(X, 24 - Y); Write(Qestn[1]);
    Delay(50);
  end;
  X:= 40 - Length(Qestn[2]) div 2;
  GoToXY(X, Y + 2); Write(Qestn[2]);
end;

begin
  TextColor(LightGray);
  TextBackGround(Black);
  ClrScr;
  Downer;
end.

program WindowsAlike;
Uses Crt, ScrnWrit;
Var X, Y: integer;

begin
  HighVideo;
  TextColor(LightGreen);
  Window(1, 1, 80, 26);
  For X:= 1 to 80*24 - 10 do
    Write(#219);
  TextBackGround(Blue);
  GoToXY(1, 1);
  For X:= 1 to 80 do
    Write(' ');
  TextBackGround(White);
  TextColor(Black);
  GoToXY(1, 1); Write(' - ');
  GoToXY(74, 1); Write(' '#31' '#179' '#30' ');
  TextColor(White);
  TextBackGround(Blue);
  GoToXY(30, 1); Write('Tryhard Windows');
  TextBackGround(LightGreen);
  Window(10, 10, 70, 20);
  TextBackGround(Blue);
  GoToXY(1, 1);
  For X:= 1 to 60 do
    Write(' ');
  TextBackGround(White);
  TextColor(Black);
  GoToXY(1, 1); Write(' - ');
  TextColor(LightBlue);
  TextBackGround(Black);
  GoToXY(1, 2);
  For X:= 1 to 60 do
    For Y:= 1 to 9 do
    Write(#219);
  TextColor(Black);
  TextBackGround(LightGray);
  GoToXY(5, 3); Write(' Button   ');
  GoToXY(6, 4);
  For X:= 1 to 10 do
  Write(#220);
  TextColor(Black);
  TextBackGround(LightGreen);
  GoToXY(1, 10); Write(#22);
  ReadKey;
end.
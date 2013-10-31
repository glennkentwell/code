{$M 8192,0,0}           { Leave memory for child process }
Program I;
Uses Crt, Scrn_Sav, Dos;

begin
  TextMode(co80);
  TextColor(Blue);
  TextBackGround (Blue);
  ClrScr;
  a := 1;
  Repeat
    Menu;
    GettingTime(65,1);
  Until a = 2;
  GoToXY (1,WherY + 2);
  TextColor(LightGray);
end.



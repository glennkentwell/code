Program I;
Uses Crt, Scrn_Sav, Dos;

begin
  TextColor (LightGray);
  TextBackGround (Blue);
  ClrScr;
  a := 1;
  Repeat
    Menu;
    GettingTime(65,1);
  Until a = 2;
  GoToXY (1,WherY + 2);
end.



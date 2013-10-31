program Colors;
Uses Crt;
Const Colr : array [0..15] of String = ('Black', 'Blue','Green',
                                        'Cyan','Red','Magenta','Brown',
                                        'LtGray','DkGray','LtBlue',
                                        'LtGreen','LtCyan','LtRed',
                                        'LtMagenta','Yellow','White');
Var
  Fore, Back : integer;
begin
  ClrScr;
  Repeat
    TextBackGround (Fore);
    TextColor (Back);
    Write (Colr[Back]);
    Inc (Fore);
    Dec (Back);
    if Fore > 16 then Fore := 0;
    if Back < 0 then Back := 15;
  Until WhereY = 25;
  ReadKey;
  Fore := 0;
  Back := 16;
  ClrScr;
  Repeat
    TextColor (Back);
    Repeat
      TextBackGround (Fore);
      Write (Colr[Back]:8,' on ',Colr[Fore]:8);
      Inc(Fore);
    Until Fore = 16;
    Fore := 0;
    Dec (Back);
  Until Back < 0;
  ReadKey;
end.
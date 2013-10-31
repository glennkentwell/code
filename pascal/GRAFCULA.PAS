program Colours;
Uses Crt, Graph, GrafBits;
Const   Colr : array [0..15] of String = ('Black', 'Blue','Green',
                                          'Cyan','Red','Magenta','Brown',
                                          'LightGray','DarkGray','LightBlue',
                                          'LightGreen','LightCyan','LightRed',
                                          'LightMagenta','Yellow','White');

Var I : integer;
  Col : Word;

begin
  GraphicsScreen('C:\TP\BGI');
  I := 0;
  SetTextStyle (3,0,6);
  SetColor (15);
  Repeat
    Col := GetColor;
    SetFillStyle (1,I);
    FloodFill (1,1,I);
    OutTextXY (20,200,Colr[I]);
    ReadKey;
    SetColor (0);
    Inc(I);
    ClearDevice;
  Until I = 16;
end.


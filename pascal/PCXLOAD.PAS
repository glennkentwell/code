program Yes;
uses Crt, Tugu;

begin
  VGAMode;
  PCXLoad('C:\TP\TUGU\MANDEL.PCX', Pal, 0, 0);
  ReadKey;
  SetMode(3);
end.
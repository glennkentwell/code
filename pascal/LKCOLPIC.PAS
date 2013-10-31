program Crap;
Uses Graph, Crt, GrafBits;

begin
  GraphicsScreen('\tp\bgi');
  SetColor(yellow);
  SetTextStyle(1, 0, 3);
  SetFillStyle(1, yellow);
  FloodFill(1, 1, White);
  setfillstyle(1,red);
  fillellipse(DivX, DivY,65, 90);
  bar(490, 354, 639, 255);
  ReadLn;
end.
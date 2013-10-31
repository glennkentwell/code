program Shitl;
uses Crt, Graph, GrafBits;
var
  Y, PaddleWidth, Bottom: integer;

begin
  GraphicsScreen;
  PaddleWidth:= MaxX div 10;
  Bottom:= DivY;
  Y:= PaddleWidth * 2;

  SetColor(Magenta);
  Line((Y - PaddleWidth div 2) + 2, Bottom, (Y + PaddleWidth div 2) - 2, Bottom);
  SetColor(LightRed);
  Line((Y - PaddleWidth div 2) + 1, Bottom + 1, (Y + PaddleWidth div 2) - 1, Bottom + 1);
  Line(Y - PaddleWidth div 2, Bottom + 2, Y + PaddleWidth div 2, Bottom + 2);
  Line(Y - PaddleWidth div 2 - 1, Bottom + 3, Y + PaddleWidth div 2 + 1, Bottom + 3);
  SetColor(Red);
  Line(Y - PaddleWidth div 2 - 1, Bottom + 4, Y + PaddleWidth div 2 + 1, Bottom + 4);
  Line(Y - PaddleWidth div 2 - 1, Bottom + 5, Y + PaddleWidth div 2 + 1, Bottom + 5);
  SetColor(Yellow);
  PutPixel(Y - PaddleWidth div 3, Bottom + 4, Yellow);
  Circle(Y - PaddleWidth div 3, Bottom + 4, 2);
  PutPixel(Y + PaddleWidth div 3, Bottom + 4, Yellow);
  Circle(Y + PaddleWidth div 3, Bottom + 4, 2);
end.
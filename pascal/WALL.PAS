program Wall;
Uses Graph, Crt, GrafBits;
procedure DrawFace;
begin
  SetColor(Black);
  SetFillStyle(1, Yellow);
  FillEllipse(DivX - 20, DivY, 80, 80);
  Arc(DivX - 20, DivY, 180, 0, 60);
  Circle(DivX - 35, DivY - 30, 10);
  Circle(DivX + 5, DivY - 30, 10);
end;

begin
  GraphicsScreen('C:\TP\BGI');
  InitBlocks;
  SetFillStyle(1, Blue);
  FloodFill(10, 10, 15);
  SetLineStyle(0, 0, 3);
  DrawFace;
  SetLineStyle(0, 0, 1);
  Tube(200, 0, 400, 'Ver');
  Tube(260, 0, 400, 'Ver');
  Tube(320, 0, 400, 'Ver');
  Tube(380, 0, 400, 'Ver');
  BlockArea(0, 0, 160, MaxY - 100);
  BlockArea(440, 80, 640, MaxY - 100);
  BlockArea(0, MaxY - 120, 640, MaxY);
  BlockArea(0, 0, 640, 100);
  ReadKey;
  CloseGraph;
end.

  Repeat
    if Lin = True then
    begin
      PutImage(X, Y, Half^, NormalPut);
      X := -L div 2;
    end;
    Repeat
      PutImage(X, Y, Block^, NormalPut);
      Inc(X, L);
    Until X > MaxX;
    if Lin = True then
    begin
      Dec(X, L + 1);
      PutImage(X, Y, Half^, NormalPut);
    end;
    Inc(Y, W);
    X := 0;
    if Lin = True then Lin := False
      else Lin := True;
  Until Y >= MaxY;

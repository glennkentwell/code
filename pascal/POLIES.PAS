program Polies;
uses graph,crt, grafbits;
var
  GD, GM, Errorcode : integer;
  Col, I, Ex : integer;
  Poly : array [1..10] of PointType;
  MaxX, MaxY : integer;

begin
  Gd:= InstallUserDriver('VGA256', nil);
  Gm:= 0;
  InitGraph(Gd, Gm, 'C:\Shoot');
  errorcode := graphresult;
  if errorcode <> grok then
    begin
      writeln ('Graphics error : ', grapherrormsg (errorcode));
      writeln (' Program aborted...');
      halt(1);
    end;
  MaxX := GetMaxX;
  MaxY := GetMaxY;
  Repeat
    Col:= Random(256);
    SetFillStyle (1, Col);
    SetColor(Col);
    I := Random(10);
    For Ex := 1 to I do
      With Poly[Ex] do
      begin
        X := Random(MaxX);
        Y := Random(MaxY);
      end;
    FillPoly (I,Poly);
  Until KeyPressed;
  CloseGraph;
end.
program Dogger;
uses
  Graph, Crt,
  GrafBits, Animals;

var
  X, Y,
  Gd, Gm: integer;

begin
  GraphicsScreen;
  DrawMovingDog;
  ClearDevice;
  DrawStillDog;
  ClearDevice;
  While not KeyPressed do
  begin
    PutImage(0, 0, Dog^, ANDPut);
    Delay(100);
    PutImage(0, 0, MoveDog^, ANDPut);
    Delay(100);
  end;
end.
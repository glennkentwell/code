program UsePutImage;
Uses Crt, Graph, GrafBits;
Var
  X, Y, J, A, B, Size : integer;
  P, Pb : Pointer;

begin
  GraphicsScreen('C:\TP\BGI');
    for j := 1 to 10 do
      circle (80 ,80 ,8 * j);
    Size := ImageSize(0,0,160,160);
    GetMem (P,Size);
    GetImage(0,0,160,160,P^);
{    SetColor (0);
    for j := 1 to 10 do
      circle (280 ,280 ,8 * j);}
    Size := ImageSize(200,200,360,360);
    GetMem (Pb,Size);
    GetImage(200,200,360,360,Pb^);
    ClearDevice;
    Randomize;
    SetColor (15);
    Repeat
      PutImage(A, B, Pb^,NormalPut);
      PutImage(X, Y, Pb^,NormalPut);
      X := (Random(GetMaxX));
      Y := (Random(GetMaxY));
      A := (Random(GetMaxX));
      B := (Random(GetMaxY));
      PutImage(X, Y, P^,NormalPut);
      PutImage(A, B, P^,NormalPut);
      Delay(0);
    Until KeyPressed;
{    for J := 1 to 10 do
    begin
      Circle (X, Y,16 * j);
    end;}
    ReadKey;
    CloseGraph;
end.

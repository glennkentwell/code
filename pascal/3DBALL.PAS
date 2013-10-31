program Whatever;
uses
  Graph, Crt,
  GrafBits;

type
  TBall = Object
    X, Y,
    XSize, YSize,
    XMov, YMov: integer;
    procedure DirBall;
    procedure MoveBall;
    procedure StartBall(XP, YP, XM, YM: integer);
  end;

var
  I,
  XPos, YPos,
  Dela, NumBalls,
  XSize, YSize: integer;
  Size: integer;
  MM, M, P: pointer;
  Balls: array[1..100] of TBall;

procedure DrawBall;
begin
  XPos:= 18;
  YPos:= 18;
  XSize:= 36;
  YSize:= XSize;
  For I:= 0 to 15 do
  begin
    SetPalette(I, I);
    SetRGBPalette(I, I * 3, I * 3, I * 3);
    SetColor(I);
    SetFillStyle(1, I);
    FillEllipse(XPos, YPos, 15 - I, 15 - I);
  end;
  Size:= ImageSize(0, 0, XSize, YSize);
  GetMem(P, Size);
  GetImage(0, 0, XSize, YSize, P^);
  SetFillStyle(1, White);
  Bar(100, 100, 100 + XSize, 100 + YSize);
  PutImage(100, 100, P^, xorput);
  GetMem(M, Size);
  GetImage(100, 100, 100 + XSize, 100 + YSize, M^);
end;

procedure TBall.DirBall;
begin
  Inc(X, XMov);
  Inc(Y, YMov);
  if X >= MaxX - 36 then XMov:= -2;
  if Y >= MaxY - 36 then YMov:= -3;
  if X <= 0 then XMov:= 3;
  if Y <= 0 then YMov:= 2;
end;

procedure TBall.StartBall;
begin
  X:= XP;
  Y:= YP;
  XMov:= XM;
  YMov:= YM;
end;

procedure TBall.MoveBall;
begin
  PutImage(X, Y, P^, NormalPut);
  if X = MaxX - 34 then PutImage(X, Y, P^, NormalPut);
end;

function RandX: integer;
begin
  RandX:= Random(MaxX - 34);
end;

function RandY: integer;
begin
  RandY:= Random(MaxY - 34);
end;

function RndXM: integer;
begin
  RndXM:= Random(2) + 1;
end;

function RndYM: integer;
begin
  RndYM:= Random(4) + 1;
end;

procedure RunEm;
begin
  ClearDevice;
  For I:= 1 to NumBalls do
  begin
    Balls[I].StartBall(RandX, RandY, RndXM, RndYM);
  end;
  While not KEyPressed do
  begin
    For I:= 1 to NumBalls do
    begin
      Balls[I].DirBall;
      Balls[I].MoveBall;
      Delay(Dela);
    end;
  end;
end;

procedure Starter;
var
  Code: integer;
begin
  if ParamCount = 0 then
  begin
    NumBalls:= 2;
    Dela:= 3;
  end;
  if ParamCount > 0 then
  begin
    Val(ParamStr(1), NumBalls, Code);
    Dela:= 1;
  end;
  if ParamCount > 1 then
    Val(ParamStr(2), Dela, Code);
  if NumBalls > 100 then NumBalls:= 100;
  if Dela > 1000 then Dela:= 1000;
  if Dela < 0 then Dela:= 0;
  if NumBalls < 1 then NumBalls:= 1;
end;

begin
  GraphicsScreen;
  Starter;
  DrawBall;
  RunEm;
  ReadKey;
  CloseGraph;
end.


{procedure TestBall;
begin
  PutImage(100, 0, P^, normalput);
  PutImage(100, 22, M^, normalput);
  PutImage(100, 44, M^, ORPut);
  PutImage(100, 0, P^, orput);
  PutImage(100, 44, M^, normalput);
  GetMem(MM, Size);
  GetImage(100, 44, 122, 66, MM^);
  readkey;
  For X:= 100 to 122 do
    For Y:= 44 to 66 do
      if GetPixel(X, Y) = White then PutPixel(X, Y, Black);
  GetImage(100, 44, 122, 66, M^);
  PutImage(100, 100, M^, orPut);
  ClearDevice;
  PutImage(0, 0, P^, NormalPut);
  PutImage(0, 22, M^, NormalPut);
  PutImage(0, 44, MM^, NormalPut);

  PutImage(22, 0, P^, XORPut);
  PutImage(22, 22, M^, XORPut);
  PutImage(22, 44, MM^, XORPut);

  PutImage(44, 0, P^, ORPut);
  PutImage(44, 22, M^, ORPut);
  PutImage(44, 44, MM^, ORPut);

  PutImage(66, 0, P^, ANDPut);
  PutImage(66, 22, M^, ANDPut);
  PutImage(66, 44, MM^, ANDPut);

  For X:= 1 to 10000 do PutPixel(Random(MaxX), Random(MaxY), Random(15));
  While not Keypressed do
  begin
    XPos:= Random(MaxX);
  PutImage(XPos, 0, P^, XORPut);
  PutImage(XPos, 0, M^, XORPut);
    Delay(Dela);
  end;
  ReadKey;
  While not Keypressed do
  begin
    XPos:= Random(MaxX);
  PutImage(XPos, 22, P^, ORPut);
  PutImage(XPos, 22, M^, ORPut);
    Delay(Dela);
  end;
  ReadKey;
  While not Keypressed do
  begin
    XPos:= Random(MaxX);
  PutImage(XPos, 44, P^, andPut);
  PutImage(XPos, 44, M^, andPut);
    Delay(Dela);
  end;
  ReadKey;
  While not Keypressed do
  begin
    XPos:= Random(MaxX);
  PutImage(XPos, 66, P^, XORPut);
  PutImage(XPos, 66, M^, ORPut);
    Delay(Dela);
  end;
  ReadKey;
  While not Keypressed do
  begin
    XPos:= Random(MaxX);
  PutImage(XPos, 88, P^, XORPut);
  PutImage(XPos, 88, M^, andPut);
    Delay(Dela);
  end;
  ReadKey;
  While not Keypressed do
  begin
    XPos:= Random(MaxX);
    PutImage(XPos, 112, MM^, normalPut);
    PutImage(XPos, 112, P^, orPut);
    Delay(Dela);
  end;
  ReadKey;
  While not Keypressed do
  begin
    XPos:= Random(MaxX);
    PutImage(XPos, 134, P^, orPut);
    PutImage(XPos, 134, MM^, xorPut);
    Delay(Dela);
  end;
  ReadKey;
  While not Keypressed do
  begin
    XPos:= Random(MaxX);
  PutImage(XPos, 155, P^, normalPut);
  PutImage(XPos, 155, MM^, orPut);
    Delay(Dela);
  end;
end;
}
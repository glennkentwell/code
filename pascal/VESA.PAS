program SeeWhatItDoes;
Uses Graph, Crt, GrafBits;
Const
  Col: array[0..8] of integer = (14, 14, 15, 6, 6, 6, 6, 6, 6);
  NumDirts = 2;
Var
  DirtPos: array[1..60] of integer;
  Gd, Gm, I: integer;
  MDog, SDog,
  Dirt: Pointer;
  F: File;
  Size: Word;

procedure GetPics;
begin
  Size:= ImageSize(0, 0, 75, 50);
  GetMem(SDog, Size);
  Assign(F, 'C:\glenns\stilldog.pic');
  Reset(F, Size);
  BlockRead(F, SDog^, 1, I);
  Close(F);
  Size:= ImageSize(0, 0, 75, 50);
  GetMem(MDog, Size);
  Assign(F, 'C:\glenns\movedog.pic');
  Reset(F, Size);
  BlockRead(F, MDog^, 1, I);
  Close(F);
end;

procedure Ground;
begin
  Randomize;
  For I:= 1 to 32760 do
    PutPixel(Random(99), Random(50), Col[Random(9)]);
  For I:= 1 to 17 do
  begin
    SetColor(Brown);
    SetFillStyle(1, Brown);
    FillEllipse(Random(99), Random(50), Random(8), Random(8));
  end;
  Size:= ImageSize(0, 0, 99, 50);
  GetMem(Dirt, Size);
  GetImage(0, 0, 99, 50, Dirt^);
  PutImage(100, 100, Dirt^, NormalPut);
end;

procedure NewVals;
begin
  For I:= 1 to NumDirts do
  begin
    Dec(DirtPos[I], 8);
    if DirtPos[I] < -10 then DirtPos[I]:= MaxX - 90;
  end;
end;

procedure DirtPosInit;
begin
  For I:= 1 to NumDirts do
    DirtPos[I]:= MaxX - (100 * (I - 1));
end;

begin
  Gd:= InstallUserDriver('VESA16', nil);
  Gm:= 1;
  InitGraph(Gd, Gm, 'C:\tp\bgi');
  ScreenVars;
  Ground;
  ReadKey;
  GetPics;
  ClearDevice;
  DirtPosInit;
  While not KeyPressed do
  begin
    PutImage(500, 500, SDog^, NormalPut);
    NewVals;
    For I:= 1 to NumDirts do
      PutImage(DirtPos[I], 550, Dirt^, NormalPut);
    PutImage(500, 500, MDog^, NormalPut);
    NewVals;
    For I:= 1 to NumDirts do
      PutImage(DirtPos[I], 550, Dirt^, NormalPut);
  end;
  ReadKey;
  CloseGraph;
end.

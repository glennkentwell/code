program TryFiles;
Uses Graph, GrafBits, Animals;
Var
  F: File;
  S: Word;
  Gd, Gm, I: integer;

procedure CatFile;
begin
  DrawCat;
  S:= ImageSize(0, 0, 40, 40);
  Assign(F, '\glenns\cat.pic');
  ReWrite(F, S);
  BlockWrite(F, Cat^, 1);
  Close(F);
end;

procedure DogFile;
begin
  DrawStillDog;
  S:= ImageSize(100, 0, 175, 50);
  Assign(F, '\glenns\stilldog.pic');
  ReWrite(F, S);
  BlockWrite(F, Dog^, 1);
  Close(F);
end;

procedure MoveDogFile;
begin
  DrawMovingDog;
  S:= ImageSize(200, 0, 275, 50);
  Assign(F, '\glenns\movedog.pic');
  ReWrite(F, S);
  BlockWrite(F, MoveDog^, 1);
  Close(F);
end;

begin
  Gd:= EGA            {InstallUserDriver('VGA256', nil)};
  Gm:= 1;
  InitGraph(Gd, Gm, 'C:\tp\bgi');
  CatFile;
  DogFile;
  MoveDogFile;
  CloseGraph;
end.
program TryFiles;
Uses Graph, Crt, GrafBits, Animals;
Var
  P, Dogg, MDogg : Pointer;
  F : File;
  X, Y, Size : Integer;
  Result : Word;
  FString : String;

procedure InitializeAnimals;
begin
  GraphicsScreen;
end;

begin
  InitializeAnimals;
  Size := ImageSize(0, 0, 75, 50);
{  Assign(f, 'C:\GLENNS\TEMP\DOG.PIC');
  ReWrite (f);
  BlockWrite(f, Dog^, Size, Result);
  Close(F);
  Assign(f, 'C:\GLENNS\TEMP\MOVEDOG.PIC');
  Rewrite (f);
  BlockWrite(f, MoveDog^, Size, Result);
  Close(F);
  OutTextXY (10, 10, 'Press a key NOW, asshole.');
  ReadKey;
  Dispose(Dog);}
  Dispose(Cat);
  X := 160;
  Y := 0;
  Repeat
    Size := ImageSize(0, X - 160, MaxX, X); {320, 480}
    if GraphResult <> 0 then
     begin
       CloseGraph;
       Write('I stuffed up.');
       ReadKey;
     end;
    GetMem(P, Size);
    Str(Y, FString);
    Insert('C:\GLENNS\TEMP\TUBE', FString, 0);
    Insert('.GKI', FString, Length(FString) + 1);
    Assign(F, FString);
    ReSet(F, Size);
    BlockRead(F, P^, 1, Result);
    Close(F);
    PutImage(0, X - 160, P^, NormalPut);
    Inc(Y);
    Inc(X, 160);
    FreeMem(P, SizeOf(P));
  Until X > 480;
  Size := ImageSize(0, 0, 75, 50);
  Assign(f, 'C:\GLENNS\TEMP\DOG.PIC');
  ReSet (f, Size);
  GetMem(Dogg, Size);
    BlockRead(f, Dogg^, 1, Result);
  Close(F);
  PutImage(300, 50, Dogg^, NormalPut);
  Size := ImageSize(0, 0, 75, 50);
  Assign(f, 'C:\GLENNS\TEMP\DOG.PIC');
  ReSet (f, Size);
  GetMem(Dogg, Size);
    BlockRead(f, Dogg^, 1, Result);
  Close(F);
  PutImage(300, 50, Dogg^, NormalPut);
  Size := ImageSize(0, 0, 40, 40);
  Assign(f, 'C:\GLENNS\TEMP\CAT.PIC');
  ReSet (f, Size);
  GetMem(Cat, Size);
    BlockRead(f, Cat^, 1, Result);
  Close(F);
  PutImage(200, 170, Cat^, NormalPut);
  Assign(f, 'C:\GLENNS\TEMP\MOVEDOG.PIC');
  ReSet (f);
  Size := SizeOf(F);
  GetMem(MDogg, Size);
    BlockRead(f, MDogg^, Size, Result);
  Close(F);
  PutImage(100, 50, MDogg^, NormalPut);
  SetColor(Black);
  OutTextXY (10, 300, 'These images were saved on disk, and then retrieved to be displayed here.');
  ReadKey;
  CloseGraph;
end.



program ReadTubes;
Uses Crt, Graph, GrafBits;
Var X, Y : integer;

procedure ReadImage;
Var
  Result : Word;
  P : pointer;
  F : file;
  FString : String;
begin
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
    PutImage(0, X - 160, MaxX, X, P^);
    Inc(Y);
    Inc(X, 160);
    FreeMem(P, SizeOf(P));
  Until X > 480;
end;

begin
  GraphicsScreen('C:\TP\BGI');
  ReadImage;
  ReadKey;
  CloseGraph;
end.

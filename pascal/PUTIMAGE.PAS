Uses Crt, Graph, GrafBits;
Var Pic: Pointer;
    XSize, YSize : integer;

procedure ReadFrom(FString: string; XS, YS: integer);
Var
  F: file;
  Size, Result: Word;
begin
  XSize := XS;
  YSize := YS;
  Size:= ImageSize(0, 0, XS, YS);
  GetMem(Pic, Size);
  Assign(F, FString);
  Reset(F, Size);
  BlockRead(F, Pic^, 1, Result);
  Close(F);
end;

begin
  GraphicsScreen('C:\TP\BGI');
  ReadFrom('C:\GLENNS\TEMP\DOG.PIC', 75, 50);
  PutImage(0, 0, Pic^, NormalPut);
  ReadKey;
  CloseGraph;
end.

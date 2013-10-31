program ReadPixels;
Uses Graph, Crt, GrafBits;
Var
  Size: Word;
  Top, Bottom, Middle: Pointer;
  F: File;
  X, Y: integer;

procedure ReadFile;
Var F: file;
begin
  Size:= ImageSize(0, 0, MaxX, MaxY div 3);
  GetMem(Top, Size);
  GetMem(Middle, Size);
  GetMem(Bottom, Size);
  Assign(F, 'A:\PIXELS.PIC');
  Reset(F, Size);
  BlockRead(F, Top^, 1);
  BlockRead(F, Middle^, 1);
  BlockRead(F, Bottom^, 1);
  Close(F);
end;

procedure PutPicture;
begin
  PutImage(0, 0, Top^, XORPut);
{  PutImage(0, 0, Middle^, XORPut);
  PutImage(0, 0, Bottom^, XORPut);
  PutImage(0, MaxY div 3, Bottom^, XORPut);
  PutImage(0, MaxY div 3, Middle^, XORPut);}
  PutImage(0, MaxY div 3, Middle^, NormalPut);
  PutImage(0, MaxY - MaxY div 3 - 1, Bottom^, NormalPut);
{  PutImage(0, MaxY - MaxY div 3, Top^, XORPut);
  PutImage(0, MaxY - MaxY div 3, Bottom^, XORPut);}
  ReadKey;
end;

procedure Grafficks;
begin
  {Gd:= VGA;
  Gm:= 2;
  InitGraph(Gd, Gm, 'c:\tp\bgi');}
  GraphicsScreen('c:\tp\bgi');
  MaxX:= GetMaxX;  MaxY:= GetMaxY;
  DivX:= GetMaxX div 2;
  DivY:= GetMaxY div 2;
end;

begin
  Grafficks;
  ReadFile;
  PutPicture;
  CloseGraph;
end.


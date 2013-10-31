program PCXMaybe;
uses
  Crt, Dos, Graph, GrafBits;

var
  F: file;
  Size: Word;
  Pic: Pointer;
  X, Y, I: integer;

procedure ReadFromFile;
var
  DirInfo: SearchRec;

begin
  ChDir('c:\tp\bgi');
  GraphicsScreen;
  ChDir('C:\GLENNS');
  FindFirst('DOG.PIC', AnyFile, DirInfo);
  Assign(F, 'DOG.PIC');
  Reset(F, DirInfo.Size);
  GetMem(Pic, DirInfo.Size);
  BlockRead(F, Pic^, 1);
  Close(F);
  PutImage(0, 0, Pic^, NormalPut);
  OutTextXY(100, 100, 'DOG.BMP');
  ReadKey;
  CloseGraph;
end;

begin
  ReadFromFile;
end.
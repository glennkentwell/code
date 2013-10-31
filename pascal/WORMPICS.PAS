unit WormPics;
interface
  procedure GetFinal;
var
  Mask, Seg: Pointer;
  X, Y: integer;
  Size: Word;

implementation
Uses Graph;
procedure DrawMask;
begin
  For Y:= 1 to 5 do
    For X:= 1 to 5 do
      PutPixel(X, Y, Black);
  Size:= ImageSize(1, 1, 10, 10);
  GetMem(Mask, Size);
  GetImage(1, 1, 10, 10, Mask^);
end;

procedure DrawSeg;
begin
  For Y:= 1 to 5 do
    For X:= 1 to 5 do
      PutPixel(X, Y, LightBlue);
  PutPixel(1, 1, Black);
  PutPixel(5, 1, Black);
  PutPixel(1, 5, Black);
  PutPixel(5, 5, Black);
  Size:= ImageSize(1, 1, 5, 5);
  GetMem(Seg, Size);
  GetImage(1, 1, 5, 5, Seg^);
end;

procedure GetFinal;
begin
  DrawSeg;
  DrawMask;
  ClearDevice;
  PutImage(100, 0, Mask^, NormalPut);
  PutImage(100, 0, Seg^, ORPut);
  Size:= ImageSize(100, 0, 104 ,4);
  GetMem(Seg, Size);
  GetImage(100, 0, 104, 4, Seg^);
end;
end.
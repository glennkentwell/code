{  All this program does is writes image files (of a man who walks)
   on to disk, in files called :-

      STILLMAN.PIC - Still picture - front on
      LEFT1   .PIC - Walking to the left with his legs together
      RIGHT1  .PIC - Walking to right with legs together
      LEFT2   .PIC - Walking to left with legs apart
      RIGHT2  .PIC - Walking to right with legs apart
}


program Dave;
uses Crt, Graph, GrafBits;
var
  Gd, Gm,
  X, Y: integer;
  Still, Rt1, Rt2, Lt1, Lt2: Pointer;
  Size: word;
  Pict: Byte;
  Img: array[0..2] of Byte;

procedure Initialize;
begin
  Gd:= InstallUserDriver('VGA256', nil);
  Gm:= 1;
  InitGraph(Gd, Gm, '\tp\bgi');
  ScreenVars;
end;

procedure DrawStillMan;
begin
  { Face }
  SetColor(66);       {apricot - yellow}
  SetFillStyle(1, 66);
  FillEllipse(9, 3, 3, 2);
  PutPixel(9, 6, 66);
  PutPixel(8, 2, Black);
  PutPixel(10, 2, Black);
  SetColor(Black);
  Line(8, 4, 10, 4);
  { Hair }
  SetColor(Yellow);
  Line(8, 0, 10, 0);
  Line(7, 1, 11, 1);
  Line(6, 2, 7, 2);
  Line(11, 2, 12, 2);
  { T shirt }
  SetColor(Blue);
  PutPixel(8, 7, Blue);
  PutPixel(9, 7, Blue);
  PutPixel(10, 7, blue);
  Line(6, 8, 6, 9);
  Line(12, 8, 12, 9);
  PutPixel(5, 9, Blue);
  PutPixel(13, 9, Blue);
  SetFillStyle(1, Blue);
  Bar(7, 8, 11, 13);
  { Right Arm }
  SetColor(66);       {apricot - yellow}
  SetFillStyle(1, 66);
  Line(13, 10, 13, 12);
  Line(12, 10, 14, 12);
  PutPixel(14, 11, 66);
  { Left Arm }
  SetColor(66);       {apricot - yellow}
  SetFillStyle(1, 66);
  Line(6, 10, 5, 12);
  Line(5, 10, 4, 12);
  PutPixel(14, 11, 66);
  { Shorts }
  SetColor(Red);
  Line(7, 14, 11, 14);
  Line(7, 15, 11, 15);
  Line(7, 16, 8, 16);
  Line(10, 16, 11, 16);
  { Legs }
  SetColor(66);       {apricot - yellow}
  SetFillStyle(1, 66);
  Line(7, 17, 7, 20);
  Line(11, 17, 11, 20);
  Line(8, 17, 7, 20);
  Line(10, 17, 11, 20);
  { Shoes }
  SetColor(White);
  Line(6, 20, 8, 20);
  Line(10, 20, 12, 20);
  { The man fits in the rectangle  (3, 0, 15, 21) }
end;

procedure DrawWalkRt1Man;
begin
  ClearDevice;
  { Head }
  SetColor(Yellow);       {apricot - yellow}
  SetFillStyle(1, Yellow);
  FillEllipse(9, 3, 3, 2);
  SetColor(66);
  Line(10, 2, 10, 5);
  Line(11, 2, 11, 4);
  Line(12, 3, 12, 3);
  PutPixel(9, 6, 66);
  { Eye }
  PutPixel(11, 2, Black);
  PutPixel(6, 3, Black);
  { Hair }
  PutPixel(11, 1, Yellow);
  { T shirt }
  SetColor(Blue);
  PutPixel(8, 7, Blue);
  PutPixel(9, 7, Blue);
  PutPixel(10, 7, Blue);
  SetFillStyle(1, Blue);
  Bar(7, 8, 11, 13);
  { Arm }
  SetColor(33);
  Line(8, 8, 8, 9);
  Line(9, 8, 9, 9);
  SetColor(66);       {apricot - yellow}
  SetFillStyle(1, 66);
  Line(8, 10, 8, 12);
  Line(9, 10, 9, 12);
  Line(7, 12, 10, 12);
  Line(8, 13, 9, 13);
  { Shorts }
  SetColor(Red);
  Line(7, 14, 10, 14);
  Line(7, 15, 10, 15);
  Line(8, 16, 10, 16);
  Line(8, 17, 10, 17);
  { Legs }
  SetColor(66);       {apricot - yellow}
  SetFillStyle(1, 66);
  Line(8, 18, 8, 20);
  Line(9, 18, 9, 20);
  { Shoes }
  SetColor(White);
  Line(8, 20, 10, 20);
  { The man fits in the rectangle  (3, 0, 15, 21) }
end;

procedure DrawWalkRt2Man;
begin
  ClearDevice;
  { Head }
  SetColor(Yellow);       {apricot - yellow}
  SetFillStyle(1, Yellow);
  FillEllipse(9, 3, 3, 2);
  SetColor(66);
  Line(10, 2, 10, 5);
  Line(11, 2, 11, 4);
  Line(12, 3, 12, 3);
  PutPixel(9, 6, 66);
  { Eye }
  PutPixel(11, 2, Black);
  PutPixel(6, 3, Black);
  { Hair }
  PutPixel(11, 1, Yellow);
  { T shirt }
  SetColor(Blue);
  PutPixel(8, 7, Blue);
  PutPixel(9, 7, Blue);
  PutPixel(10, 7, Blue);
  SetFillStyle(1, Blue);
  Bar(7, 8, 11, 13);
  { Arm }
  SetColor(33);
  Line(8, 8, 8, 9);
  Line(9, 8, 9, 9);
  SetColor(66);       {apricot - yellow}
  SetFillStyle(1, 66);
  Line(8, 10, 10, 11);
  Line(9, 10, 10, 11);
  Line(10, 12, 11, 11);
  Line(10, 12, 11, 12);
  { Shorts }
  SetColor(Red);
  Line(7, 14, 10, 14);
  Line(7, 15, 11, 15);
  Line(7, 16, 12, 16);
  Line(6, 17, 8, 17);
  Line(10, 17, 12, 17);
  { Back Leg }
  SetColor(66);       {apricot - yellow}
  SetFillStyle(1, 66);
  Line(7, 18, 6, 20);
  Line(6, 18, 5, 20);
  { Front Leg }
  SetColor(66);       {apricot - yellow}
  SetFillStyle(1, 66);
  Line(11, 18, 12, 20);
  Line(12, 18, 13, 20);
  { Shoes }
  SetColor(White);
  Line(5, 20, 7, 20);
  Line(12, 20, 14, 20);
  { The man fits in the rectangle  (3, 0, 15, 21) }
end;

procedure GetTheManPicture;
begin
  Size:= ImageSize(3, 0, 15, 21);
  GetMem(Still, Size);
  GetImage(3, 0, 15, 21, Still^);
  ClearDevice;
  PutImage(8, 5, Still^, XORPut);
  Size:= ImageSize(0, 0, 25, 25);
  GetMem(Still, Size);
  GetImage(0, 0, 25, 25, Still^);
end;

procedure ChoosePicture(Xx, Yy: integer; Stil: Boolean; Index: byte);
begin
  if Stil = False then
  begin
    if Img[Index] > 1 then Img[Index]:= 1 else
    Inc(Img[Index]);
  end
  else Img[Index]:= 0;
  if Img[Index] = 0 then PutImage(Xx, Yy, Still^, NormalPut);
  if Img[Index] = 1 then PutImage(Xx, Yy, Rt1^, NormalPut);
  if Img[Index] > 1 then PutImage(Xx, Yy, Rt2^, NormalPut);
end;

procedure GetStill;
begin
  Size:= ImageSize(0, 0, 17, 21);
  GetMem(Still, Size);
  GetImage(0, 0, 21, 25, Still^);
  ClearDevice;
  PutImage(0, 0, Still^, NormalPut);
  Size:= ImageSize(0, 0, 26, 26);
  GetMem(Still, Size);
  GetImage(1, 0, 26, 26, Still^);
end;

procedure GetRt1;
begin
  Size:= ImageSize(3, 0, 15, 21);
  GetMem(Rt1, Size);
  GetImage(3, 0, 15, 21, Rt1^);
  ClearDevice;
  PutImage(8, 5, Rt1^, NormalPut);
  Size:= ImageSize(2, 0, 27, 26);
  GetMem(Rt1, Size);
  GetImage(2, 0, 27, 26, Rt1^);
end;

procedure GetRt2;
begin
  Size:= ImageSize(3, 0, 15, 21);
  GetMem(Rt2, Size);
  GetImage(3, 0, 15, 21, Rt2^);
  ClearDevice;
  PutImage(8, 5, Rt2^, NormalPut);
  Size:= ImageSize(2, 0, 27, 26);
  GetMem(Rt2, Size);
  GetImage(2, 0, 27, 26, Rt2^);
end;

procedure GetLt1;
var
  Strip: Pointer;
  SSize: word;
begin
  ClearDevice;
  PutImage(0, 0, Rt1^, NormalPut);
  SSize:= ImageSize(2, 0, 27, 0);
  GetMem(Strip, SSize);
  For X:= 0 to 25 do
  begin
    GetImage(X, 0, X, 25, Strip^);
    PutImage(125 - X, 0, Strip^, NormalPut);
  end;
  Size:= ImageSize(2, 0, 27, 26);
  GetMem(Lt1, Size);
  GetImage(100, 0, 125, 26, Lt1^);
end;

procedure GetLt2;
var
  Strip: Pointer;
  SSize: word;
begin
  ClearDevice;
  PutImage(0, 0, Rt2^, NormalPut);
  SSize:= ImageSize(0, 0, 25, 0);
  GetMem(Strip, SSize);
  For X:= 0 to 25 do
  begin
    GetImage(X, 0, X, 25, Strip^);
    PutImage(125 - X, 0, Strip^, NormalPut);
  end;
  Size:= ImageSize(2, 0, 27, 26);
  GetMem(Lt2, Size);
  GetImage(100, 0, 125, 26, Lt2^);
end;

procedure WriteToFiles;
var
  F: file;
  Result: integer;
begin
  Size:= ImageSize(0, 0, 25, 30);
  Assign(F, '\GLENNS\STILLMAN.PIC');
  ReWrite(F, Size);
  BlockWrite(F, Still^, 1);
  Close(F);

  Assign(F, '\GLENNS\RIGHT1.PIC');
  ReWrite(F, Size);
  BlockWrite(F, Rt1^, 1);
  Close(F);

  Assign(F, '\GLENNS\RIGHT2.PIC');
  ReWrite(F, Size);
  BlockWrite(F, Rt2^, 1);
  Close(F);

  Assign(F, '\GLENNS\LEFT1.PIC');
  ReWrite(F, Size);
  BlockWrite(F, Lt1^, 1);
  Close(F);

  Assign(F, '\GLENNS\LEFT2.PIC');
  ReWrite(F, Size);
  BlockWrite(F, Lt2^, 1);
  Close(F);
end;

procedure PutThemOnScreen;
begin
  SetFillStyle(1, 135);
  Bar(0, 0, MaxX, Maxy);
  PutImage(0, 100, Still^, NormalPut);
  PutImage(60, 100, Lt1^, NormalPut);
  PutImage(100, 100, Lt2^, NormalPut);
  PutImage(140, 100, Rt1^, NormalPut);
  PutImage(180, 100, Rt2^, NormalPut);
  PutImage(200, 60, Still^, NormalPut);
  PutImage(200, 85, Lt1^, NormalPut);
  PutImage(200, 110, Lt2^, NormalPut);
  PutImage(200, 135, Rt1^, NormalPut);
  PutImage(200, 160, Rt2^, NormalPut);
  ReadKey;
end;

begin
  Initialize;
  DrawStillMan;
  GetTheManPicture;
  GetStill;
  DrawWalkRt1Man;
  GetRt1;
  DrawWalkRt2Man;
  GetRt2;
  GetLt1;
  GetLt2;
  WriteToFiles;
  CloseGraph;
end.


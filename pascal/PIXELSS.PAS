program Shaded;
Uses Graph, Crt, GrafBits;
Var
  Gd, Gm,
  X, Y: integer;
  SizeT, SizeM, SizeB: Word;
  Top, Middle, Bottom: Pointer;
  Ch: Char;

procedure Shades;
begin
  For X:= MaxY downto 1 do
    For Y:= 0 to DivY do
    begin
      PutPixel(Random(MaxX), DivY - Random(Y), Blue);
      PutPixel(Random(MaxX), DivY + Random(Y), Green);
      if KeyPressed then Break;
    end;
  For Y:= 0 to DivY div 2 do
    For X:= 0 to MaxX do
    begin
      PutPixel(Random(MaxX), Random(Y), Red);
      PutPixel(Random(MaxX), MaxY - Random(Y), LightRed);
      if KeyPressed then Break;
    end;
  For Y:= 0 to DivY do
    For X:= 0 to DivX do
    begin
      PutPixel((DivX + DivX div 2) - Random(X), (DivY + DivY div 2) - Random(Y), Magenta);
      PutPixel(DivX div 2 + Random(X), DivY div 2 + Random(Y), Yellow);
      PutPixel((DivX + DivX div 2) - Random(X), DivY div 2 + Random(Y), LightBlue);
      PutPixel(DivX div 2 + Random(X), (DivY + DivY div 2) - Random(Y), Cyan);
      if KeyPressed then Break;
    end;
  For Y:= 0 to DivY div 4 do
    For X:= 0 to DivX div 4 do
    begin
      PutPixel(DivX - Random(X), DivY - Random(Y), LightMagenta);
      PutPixel(DivX + Random(X), DivY + Random(Y), LightMagenta);
      PutPixel(DivX - Random(X), DivY + Random(Y), LightMagenta);
      PutPixel(DivX + Random(X), DivY - Random(Y), LightMagenta);
      if KeyPressed then Break;
    end;
end;

procedure GetTheScreen;
begin
  SizeT:= ImageSize(0, 0, MaxX, MaxY div 3);
  if GraphResult <> GrOk then Halt(1);
  if SizeT < 65000 then
  begin
    GetMem(Top, SizeT);
    GetImage(0, 0, MaxX, MaxY div 3, Top^);
  end;

  SizeM:= ImageSize(0, MaxY div 3, MaxX, MaxY - MaxY - 1 div 3);
  if GraphResult <> GrOk then Halt(1);
  if SizeM < 65000 then
  begin
    GetMem(Middle, SizeM);
    GetImage(0, MaxY div 3, MaxX, MaxY - MaxY div 3 - 1, Middle^);
  end;

  SizeB:= ImageSize(0, MaxY - MaxY div 3, MaxX, MaxY);
  if GraphResult <> GrOk then Halt(1);
  if SizeB < 65000 then
  begin
    GetMem(Bottom, SizeB);
    GetImage(0, MaxY - MaxY div 3, MaxX, MaxY, Bottom^);
  end;
end;

procedure WriteFile;
Var F: file;
begin
  Assign(F, 'A:\PIXELS.PIC');
  ReWrite(F, SizeT);
  BlockWrite(F, Top^, 1);
  BlockWrite(F, Middle^, 1);
  BlockWrite(F, Bottom^, 1);
  Close(F);
end;

procedure Grafficks;
begin
  Gd:= VGA;
  Gm:= 2;
  InitGraph(Gd, Gm, 'c:\tp\bgi');
  MaxX:= GetMaxX;  MaxY:= GetMaxY;
  DivX:= GetMaxX div 2;
  DivY:= GetMaxY div 2;
end;

begin
  Grafficks;
  Randomize;
  Shades;
  GetTheScreen;
  CloseGraph;
  Writeln(SizeT);
  Writeln(SizeM);
  Writeln(SizeB);
  Ch:= ReadKey;
  if Ch <> #27 then WriteFile;
end.

(* this bit makes the screen black and white, but it sucks *)
  For Y:= 0 to MaxY do
    For X:= 0 to DivX do
    begin
      PutPixel(Random(DivX), Random(MaxY + 1), Black);
      PutPixel(Random(DivX) + DivX, Random(MaxY + 1), White);
      if KeyPressed then Break;
    end;
  For Y:= 0 to MaxY do
    For X:= 0 to DivX do
    begin
      PutPixel(X, Y, Black);
      PutPixel(MaxX - X, MaxY - Y, White);
      if KeyPressed then Break;
    end;

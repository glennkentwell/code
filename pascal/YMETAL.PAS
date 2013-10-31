program Metal;
uses
  Crt, Graph,
  GrafBits;

var
  XPos, YPos,
  XSize, YSize,
  I, J,
  X, Y,
  Counter : integer;
  Col: Word;
  Pixel: array[1..400] of Word;
  Plaque: Pointer;
  Size: Word;
  F: File;

procedure GetAndPutPixels;
var
  X1, Y1: integer;
begin
  Counter:= 0;
  For X:= X1 to XSize - 1 do
    For Y:= Y1 to YSize - 1 do
      begin
        Inc(Counter);
        Pixel[Counter]:= GetPixel(I + X, J + Y);
      end;
  For X:= 1 to 400 do
    PutPixel(Random(XSize - 1) + I, Random(YSize - 1) + J, Pixel[Random(Counter) + 1]);
end;

procedure Blur(X1, Y1, X2, Y2: integer);
var
  I, J,
  X, Y,
  Counter,
  XSize, YSize: integer;
  Pixel: array[1..400] of Word;
begin
  XSize:= (X2 - X1) div 15;
  YSize:= (Y2 - Y1) div 15;
  I:= Y1;
  J:= X1;
  While J < X2 - (XSize div 2) do
    begin
      Counter:= 0;
      For X:= 0 to XSize - 1 do
        For Y:= 0 to YSize - 1 do
          begin
            Inc(Counter);
            Pixel[Counter]:= GetPixel(J + X, I + Y);
          end;
      For X:= 1 to 400 do
          PutPixel(Random(XSize - 1) + J, Random(YSize - 1) + I, Pixel[Random(Counter) + 1]);
      Inc(I, YSize div 2);
      if I > Y2 - (YSize div 2) then
        begin
          I:= 0;
          Inc(J, XSize div 2);
        end;
    end;
end;

procedure DrawMetal;
begin
  SetLineStyle(0, 0, 3);
  X:= -100;
  While X < 350 do
  begin
  For I:= 44 downto 41 do
  begin
    SetColor(I);
    Inc(X, I div 10);
    Line(X, 0, X + 75, 50);
  end;
  For I:= 41 to 44 do
  begin
    SetColor(I);
    Inc(X, I div 10);
    Line(X, 0, X + 75, 50);
  end;
  end;
end;

begin
  VGA256;
{  DrawMetal;
  Blur(0, 0, DivX div 2, 50);
  Blur(DivX div 2, 0, DivX, 50);
  Size:= ImageSize(10, 5, 110, 35);
  GetMem(Plaque, Size);
  GetImage(10, 5, 110, 35, Plaque^);
  Assign(F, 'plaque.img');
  Rewrite(F, Size);
  Blockwrite(F, Plaque^, 1);
  Close(F);
}  Assign(F, 'plaque.img');
  Size:= ImageSize(10, 5, 110, 35);
  GetMem(Plaque, Size);
  Reset(F, Size);
  BlockRead(F, Plaque^, 1);
  Close(F);
  PutImage(100, 100, Plaque^, NormalPut);
{  SetLineStyle(0, 0, 0);
  SetColor(40);
  Line(100, 130, 200, 130);
  Line(200, 130, 200, 100);
  SetColor(Yellow);
  Line(100, 100, 200, 100);
  Line(100, 100, 100, 130);
  FreeMem(Plaque, Size);
  GetMem(Plaque, Size);
  GetImage(100, 100, 200, 130, Plaque^);
  Rewrite(F, Size);
  Blockwrite(F, Plaque^, 1);
  Close(F);}
  ReadKey;
  CloseGraph;
end.


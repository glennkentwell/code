program Blurry;
uses
  Crt, Graph,
  GrafBits;

var
  XPos, YPos,
  XSize, YSize,
  I, J,
  X, Y,
  Counter : integer;

procedure ScreenIt;
begin
  For Y:= 32 to 44 do
  begin
    SetFillStyle(1, Y);
    Bar(0, (Y - 32) * 12, MaxX, (Y + 32) * 12);
  end;
end;

procedure GetAndPutPixels;
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
  I:= X1;
  J:= Y1;
  While J < Y2 - (YSize div 2) do
    begin
      Inc(I, XSize div 2);
      if I > X2 - (XSize ) then
        begin
          I:= 0;
          Inc(J, 10);
        end;
    end;
  I:= 0;
  J:= 0;
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

begin
  VGA256;
  ScreenIt;
  For XPos:= 1 to 2 do Blur(0, 0, MaxX, MaxY);
  ReadKey;
  CloseGraph;
end.
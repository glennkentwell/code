program Hello;
uses Graph, Crt, Tugu;
var
  X, Y: integer;
  Line: array[100..XMax - 100, 0..YMax] of Byte;

begin
  VGAMode;
  X:= 100;
  ClrBuf(15);
  While X < XMax - 100 do
  begin
    PutPix(X, 199);
    Inc(X, 2);
  end;
  For Y:= YMax - 1 downto 0 do
    For X:= 100 to XMax - 100 do
      begin
        ClrBuf(GetPix(X, Y + 1));
        PutPix(X, Y);
      end;
  SetMode(3);
end.

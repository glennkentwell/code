program PutPistonImage;
Uses Graph, Crt, GrafBits;
Var
  Size, Result: Word;
  F : File;
  PistonPic : Pointer;
  Leng: Integer;

procedure DrawPistonLine(Ex, Why, Leng, Col : integer; XorY : String);
begin
  SetColor(Col);
  if XorY = 'Hor' then
  begin
    MoveTo(Ex, GetY + 1);
    LineTo(Ex + Leng, GetY);
  end;
  if XorY = 'Ver' then
  begin
    MoveTo(GetX + 1, Why);
    LineTo(GetX, Why + Leng);
  end;
end;  { DrawTubeLine }

procedure Pisten(StartX, StartY, Length : integer; XoY : String);
{              'XoY' = Ver to draw horizontal tube
               'XoY' = Hor to draw vertical tube          }
begin
  MoveTo(StartX, StartY);
  DrawPistonLine(StartX, StartY, Length, 0, XoY);
  DrawPistonLine(StartX, StartY, Length, 8, XoY);
  DrawPistonLine(StartX, StartY, Length, 8, XoY);
  DrawPistonLine(StartX, StartY, Length, 8, XoY);
  DrawPistonLine(StartX, StartY, Length, 8, XoY);
  DrawPistonLine(StartX, StartY, Length, 7, XoY);
  DrawPistonLine(StartX, StartY, Length, 8, XoY);
  DrawPistonLine(StartX, StartY, Length, 7, XoY);
  DrawPistonLine(StartX, StartY, Length, 7, XoY);
  DrawPistonLine(StartX, StartY, Length, 8, XoY);
  DrawPistonLine(StartX, StartY, Length, 7, XoY);
  DrawPistonLine(StartX, StartY, Length, 7, XoY);
  DrawPistonLine(StartX, StartY, Length, 7, XoY);
  DrawPistonLine(StartX, StartY, Length, 7, XoY);
  DrawPistonLine(StartX, StartY, Length, 15, XoY);
  DrawPistonLine(StartX, StartY, Length, 7, XoY);
  DrawPistonLine(StartX, StartY, Length, 7, XoY);
  DrawPistonLine(StartX, StartY, Length, 15, XoY);
  DrawPistonLine(StartX, StartY, Length, 7, XoY);
  DrawPistonLine(StartX, StartY, Length, 15, XoY);
  DrawPistonLine(StartX, StartY, Length, 15, XoY);
  DrawPistonLine(StartX, StartY, Length, 15, XoY);
  DrawPistonLine(StartX, StartY, Length, 15, XoY);
  DrawPistonLine(StartX, StartY, Length, 15, XoY);
  DrawPistonLine(StartX, StartY, Length, 15, XoY);
  DrawPistonLine(StartX, StartY, Length, 15, XoY);
  DrawPistonLine(StartX, StartY, Length, 15, XoY);
  DrawPistonLine(StartX, StartY, Length, 15, XoY);
  DrawPistonLine(StartX, StartY, Length, 15, XoY);
  DrawPistonLine(StartX, StartY, Length, 15, XoY);
  DrawPistonLine(StartX, StartY, Length, 15, XoY);
  DrawPistonLine(StartX, StartY, Length, 15, XoY);
  DrawPistonLine(StartX, StartY, Length, 7, XoY);
  DrawPistonLine(StartX, StartY, Length, 15, XoY);
  DrawPistonLine(StartX, StartY, Length, 7, XoY);
  DrawPistonLine(StartX, StartY, Length, 7, XoY);
  DrawPistonLine(StartX, StartY, Length, 15, XoY);
  DrawPistonLine(StartX, StartY, Length, 7, XoY);
  DrawPistonLine(StartX, StartY, Length, 7, XoY);
  DrawPistonLine(StartX, StartY, Length, 7, XoY);
  DrawPistonLine(StartX, StartY, Length, 7, XoY);
  DrawPistonLine(StartX, StartY, Length, 8, XoY);
  DrawPistonLine(StartX, StartY, Length, 7, XoY);
  DrawPistonLine(StartX, StartY, Length, 7, XoY);
  DrawPistonLine(StartX, StartY, Length, 8, XoY);
  DrawPistonLine(StartX, StartY, Length, 7, XoY);
  DrawPistonLine(StartX, StartY, Length, 8, XoY);
  DrawPistonLine(StartX, StartY, Length, 8, XoY);
  DrawPistonLine(StartX, StartY, Length, 8, XoY);
  DrawPistonLine(StartX, StartY, Length, 8, XoY);
  DrawPistonLine(StartX, StartY, Length, 0, XoY);
  SetColor(Black);
  Line(StartX, StartY + 3, StartX + 50, StartY + 3);
  Line(StartX, StartY + 6, StartX + 50, StartY + 6);
  Line(StartX, StartY + 9, StartX + 50, StartY + 9);
  SetFillStyle(1, Black);
  FillEllipse(DivX + 25, DivY + Length div 2, 15, Length div 2);
  FillEllipse(DivX - 25, DivY + Length div 2, 15, Length div 2);
  Leng := Length;
end;  { Tube }

procedure GetPistonImage;
begin
  Size := ImageSize(DivX - 25, DivY - 25, DivX + 25, DivY + 20);
  GetMem(PistonPic, Size);
  GetImage(DivX - 25, DivY - 25, DivX + 25, DivY + 20, PistonPic^);
  PutImage(0, 0, PistonPic^, XORPut);
end;

var Ch : Char;
begin
  GraphicsScreen;
  Pisten(DivX - 25, DivY - 20, 35, 'Ver');
  GetPistonImage;
  Ch := ReadKey;
  if Ch = #27 then Exit;
  Assign(F, 'PISTON.PIC');
  ReWrite(F, Size);
  BlockWrite(F, PistonPic^, 1, Result);
  Close(F);
  CloseGraph;
end.
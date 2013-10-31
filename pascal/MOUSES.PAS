program Cool;
uses Crt, Dos, Graph, GrafBits;
const MOUSEINTR = $33;
type
  ToolType = (Pen, Fill);
var
  X, Y,
  X1, Y1,
  Xx, Yy: Word;
  Button1, Button2: Boolean;
  Blank, Scrn, Crs: Pointer;
  Colour: Word;
  Size: Word;
  Tool: ToolType;

procedure GetMousePos(var x, y : word; var button1, button2 : boolean);
var regs : registers;
begin
  regs.ax := 3;
  Intr(MOUSEINTR, regs);
  x := regs.cx;
  y := regs.dx;
  button1 := (regs.bx and 1) <> 0;
  button2 := (regs.bx and 2) <> 0;
end;

procedure DoTheMouse;
begin
  X1:= X;  Y1:= Y;
  GetMousePos(Xx, Yy, Button1, Button2);
    if (Xx > 5) and (Xx < MaxX - 5) then
       X:= Xx;
    if (Yy > 5) and (Yy < MaxY - 5) then
       Y:= Yy;
    if (X1 <> X) or (Y1 <> Y) or Button1 or Button2 then
    begin
      PutImage(X1 - 5, Y1 - 5, Blank^, NormalPut);
      GetImage(X - 5, Y - 5, X + 5, Y + 5, Blank^);
      PutImage(X - 5, Y - 5, Scrn^, ANDPut);
      PutImage(X - 5, Y - 5, Crs^, XORPut);
    end;
end;

procedure PenDraw;
begin
  Line(X, Y, X1, Y1);
end;

procedure FillDraw;
var
  Pix: Word;
  Ex, Why, ExInc, WhyInc: integer;
  Finished: Boolean;
begin
  Ex:= X;
  Why:= Y;
  ExInc:= 1;
  WhyInc:= 1;
  Pix:= GetPixel(X, Y);
  Finished:= False;
    While (GetPixel(Ex, Why) = Pix) and (not KeyPressed) do
    begin
      While (GetPixel(Ex, Why) = Pix) and (not KeyPressed) do
      begin
        PutPixel(Ex, Why, Colour);
        if X < MaxX then Inc(Ex);
      end;
      Ex:= X - 1;
      While (GetPixel(Ex, Why) = Pix) and (not KeyPressed) do
      begin
        PutPixel(Ex, Why, Colour);
        if Ex > 55 then Dec(Ex);
      end;
      Ex:= X;
      if Why < MaxY then Inc(Why);
    end;
    Why:= Y - 1;
    While (GetPixel(Ex, Why) = Pix) and (not KeyPressed) do
    begin
      While (GetPixel(Ex, Why) = Pix) and (not KeyPressed) do
      begin
        PutPixel(Ex, Why, Colour);
        if X < MaxX then Inc(Ex);
      end;
      Ex:= X - 1;
      While (GetPixel(Ex, Why) = Pix) and (not KeyPressed) do
      begin
        PutPixel(Ex, Why, Colour);
        if Ex > 55 then Dec(Ex);
      end;
      Ex:= X;
      if Why > 0 then Dec(Why);
    end;
  While KeyPressed do ReadKey;
end;

procedure Draw;
begin
  SetColor(Colour);
  if Button1 then
    if X > 55 then
    begin
      if Tool = Pen then
        PenDraw;
      if Tool = Fill then
        FillDraw;
    end;
end;

procedure Colours;
var
  X: integer;
begin
  For X:= 0 to 15 do
  begin
    SetFillStyle(1, X);
    Bar(0, (X * 20) + 160, 50, (X * 20) + 180);
  end;
end;

procedure ToolBarPencil;
begin
  SetViewPort(0, 0, 50, 50, ClipOn);
  SetFillStyle(1, LightGray);
  Bar(0, 0, 50, 50);
  SetColor(Red);
  Line(10, 0, 0, 10);
  Line(10, 0, 47, 37);
  Line(0, 10, 37, 47);
  Ellipse(47, 47, 90, 180, 11, 11);
  SetFillStyle(1, Red);
  FloodFill(25, 25, Red);
  SetColor(Brown);
  Line(47, 37, 47, 47);
  Line(37, 47, 47, 47);
  Ellipse(47, 47, 90, 180, 11, 11);
  SetFillStyle(1, Brown);
  FloodFill(40, 40, Brown);
  SetColor(DarkGray);
  Line(47, 44, 47, 47);
  Line(44, 47, 47, 47);
  Ellipse(47, 47, 90, 180, 4, 4);
  SetColor(Black);
  Line(5, 5, 39, 39);
  Line(10, 0, 0, 10);
  Line(10, 0, 46, 36);
  Line(0, 10, 36, 46);
  SetViewPort(0, 0, MaxX, MaxY, ClipOn);
end;

procedure ToolBarFill;
begin
  SetViewPort(0, 52, 50, 102, ClipOn);
  SetFillStyle(1, LightGray);
  Bar(0, 0, 50, 50);
  SetFillStyle(1, White);
  Bar(5, 10, 45, 20);
  SetColor(Black);
  Line(5, 10, 5, 20);
  Line(45, 10, 45, 20);
  Line(10, 15, 25, 27);
  Line(40, 15, 25, 27);
  SetFillStyle(1, Blue);
  Bar(23, 27, 27, 45);
  SetViewPort(0, 0, MaxX, MaxY, ClipOn);
end;

procedure ToolBarSaveLoad;
var
  I: integer;
begin
  SetTextStyle(1, 0, 4);
  SetTextJustify(1, 1);
  SetColor(Blue);
  For I:= 3 to 7 do
    OutTextXY(23 + I, 112, 'S');
  For I:= 3 to 7 do
    OutTextXY(23 + I, 138, 'L');
  SetColor(White);
  For I:= 1 to 2 do
    OutTextXY(23 + I, 112, 'S');
  For I:= 1 to 2 do
    OutTextXY(23 + I, 138, 'L');
  SetColor(LightGray);
  Line(0, 129, 50, 129);
  Line(0, 158, 50, 158);
end;

procedure Init;
begin
  GraphicsScreen;
  SetColor(Black);
  SetFillStyle(1, White);
  Bar(0, 0, 10, 10);
  X:= 5; Y:= 5;
  Line(X - 5, Y, X + 5, Y);
  Line(X, Y - 5, X, Y + 5);
  Size:= ImageSize(0, 0, 10, 10);
  GetMem(Crs, Size);
  GetMem(Scrn, Size);
  GetMem(Blank, Size);
  GetImage(0, 0, 10, 10, Scrn^);
  PutImage(0, 0, Scrn^, XORPut);
  SetColor(White);
  Line(X - 5, Y, X + 5, Y);
  Line(X, Y - 5, X, Y + 5);
  GetImage(0, 0, 10, 10, Crs^);
  ClearDevice;
  Colours;
  ToolBarPencil;
  ToolBarFill;
  ToolBarSaveLoad;
end;

procedure Save;
var
  F: file;
begin
  SetWriteMode(XORPut);
  While not Button1 do DoTheMouse;
end;

procedure Load;
begin
end;

procedure TestForColourChange;
begin
  if Button1 then
    if Y > 160 then Colour:= GetPixel(0, Y)
  else
  begin
    if Y < 50 then Tool:= Pen;
    if (Y > 50) and (Y < 100) then Tool:= Fill;
    if (Y > 100) and (Y < 129) then Save;
    if (Y > 129) and (Y < 158) then Load;
  end;
end;


begin
  Init;
  GetMousePos(X, Y, Button1, Button2);
  While not KeyPressed do
  begin
    DoTheMouse;
    if Button1 then
      if X > 50 then Draw
        else TestForColourChange;
  end;
  CloseGraph;
end.
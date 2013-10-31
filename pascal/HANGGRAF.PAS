unit HangGraf;
interface
const
  Browns: array[0..6] of integer = (183, 184, 185, 186, 112, 113, 114);
  Greens: array[0..17] of integer=(119, 115,
                                   188, 189, 190, 191, 192, 193,
                                   212, 213, 214, 215, 216, 217, 218, 194,  210, 187);
  var Smile: Pointer;
  procedure Head;
  procedure Arms;
  procedure Shirt;
  procedure Legs;
  procedure BottomHalf1;
  procedure BottomHalf2;
  procedure Side1;
  procedure Side2;
  procedure Side3;
  procedure Diagonal;
  procedure Top;
  procedure Noose;
  procedure DrawSmiley(XPos, YPos: integer);
  procedure WoodBar(X1, Y1, X2, Y2: integer);

implementation
uses Crt, Graph;
Var
  I,
  X, Y: integer;

procedure Head;
begin
  X:= 96;
  SetColor(X);
  SetFillStyle(1, X);
  FillEllipse(45, 25, 15, 15);
  X:= 97;
  SetColor(X);
  SetFillStyle(1, X);
  FillEllipse(45, 25, 14, 14);
  X:= 66;
  SetColor(X);
  SetFillStyle(1, X);
  SetLineSTyle(DottedLn, 1, 1);
  FillEllipse(45, 25, 11, 12);
  SetLineStyle(0, 1, 1);
  { Eyes }
  X:= 29;
  SetColor(X);
  SetFillStyle(1, X);
  FillEllipse(40, 22, 3, 4);
  FillEllipse(50, 22, 3, 4);
  X:= 31;
  SetColor(X);
  SetFillStyle(1, X);
  FillEllipse(40, 22, 2, 3);
  FillEllipse(50, 22, 2, 3);
  SetColor(LightBlue);
  Line(39, 23, 41, 23);
  Line(49, 23, 51, 23);
  SetColor(Black);
  Line(40, 22, 40, 24);
  Line(50, 22, 50, 24);
  { Nose }
  X:= 97;
  SetColor(X);
  Line(45, 25, 42, 30);
  Line(42, 30, 48, 30);
  PutPixel(44, 29, Black);
  PutPixel(46, 29, Black);
  { Mouth }
  X:= 41;
  SetColor(X);
  Line(40, 33, 43, 33);
  Line(42, 34, 44, 34);
  X:= 40;
  SetColor(X);
  Line(44, 33, 50, 33);
  Line(45, 34, 48, 34);
  { Hair }
  X:= 28;
  SetColor(X);
  Line(38, 10, 52, 10);
  Dec(X); SetColor(X);
  Line(36, 11, 54, 11);
  Line(34, 12, 56, 12);
  Dec(X); SetColor(X);
  Line(32, 13, 58, 13);

  Dec(X); SetColor(X);
  Line(31, 14, 43, 14); { left }
  Line(30, 15, 39, 15);
  Line(58, 14, 47, 14); { right }
  Line(59, 15, 51, 15);
  Dec(X); SetColor(X);
  Line(30, 16, 37, 16); { left }
  Line(30, 17, 36, 17);
  Line(29, 18, 36, 18);
  Line(29, 19, 35, 19);

  Line(59, 16, 52, 16); { right }
  Line(59, 17, 54, 17);
  Line(60, 18, 54, 18);
  Line(60, 19, 55, 19);
  Dec(X); SetColor(X);
  Line(29, 20, 34, 20); { left }
  Line(29, 21, 33, 21);
  Line(29, 22, 33, 22);

  Line(60, 20, 56, 20);
  Line(60, 21, 57, 21);
  Line(60, 22, 57, 22);
  Dec(X); SetColor(X);
  Line(29, 23, 33, 23);
  Line(60, 23, 57, 23);

  X:= 42;
  SetColor(X);
  Line(49, 41, 40, 41);
  X:= 43;
  SetColor(X);
  Line(38, 40, 51, 40);
  X:= 44;
  SetColor(X);
  Line(37, 39, 52, 39);
  SetColor(42);
  Line(43, 0, 47, 0);
  SetColor(18);
  SetFillStyle(1, 18);
  FillEllipse(57, 117, 15, 4);
end;

procedure Shirt;
begin
  X:= 55;
  SetColor(32);
  SetFillStyle(1, X);
  FillEllipse(55, 45, 5, 3);
  FillEllipse(35, 45, 5, 3);
  SetColor(X);
  Line(31, 46, 59, 46);
  Line(31, 47, 59, 47);
  Line(31, 48, 59, 48);
  Line(31, 49, 59, 49);
  Line(35, 42, 55, 42);
  SetColor(32);
  Bar(55, 43, 35, 65);
  Line(35, 50, 35, 65);
  Line(35, 65, 55, 65);
  Line(55, 65, 55, 50);
  Line(60, 45, 60, 50);
  Line(30, 45, 30, 50);
  Line(60, 50, 55, 50);
  Line(30, 50, 35, 50);
  Line(35, 50, 37, 47);
  Line(55, 50, 52, 47);
  SetColor(18);
  SetFillStyle(1, 18);
  FillEllipse(51, 112, 18, 4);
end;

procedure Arms;
begin
  X:= 96;
  SetColor(X);
  Line(34, 51, 32, 60);  { Left }
  Line(30, 51, 31, 60);
  Line(31, 60, 29, 62);
  Line(32, 60, 32, 64);
  Line(56, 51, 58, 60);  { Right }
  Line(60, 51, 59, 60);
  Line(59, 59, 57, 63);
  SetColor(97);
  Line(31, 51, 31, 59); { Left }
  Line(33, 51, 32, 58);
  Line(31, 60, 31, 64);
  Line(31, 60, 30, 64);
  Line(58, 51, 59, 58); { Right }
  Line(59, 51, 58, 58);
  Line(59, 60, 58, 64);
  Line(60, 62, 60, 64);
  SetColor(66);
  Line(32, 51, 32, 57);  { Left }
  Line(32, 60, 33, 63);
  Line(57, 51, 58, 58);  { Right }
  Line(59, 60, 59, 64);
  Line(60, 61, 61, 62);
end;

procedure Legs;
begin
  X:= 24;
  SetFillStyle(1, X);
  SetColor(X);
  FillEllipse(51, 88, 2, 3);
  FillEllipse(39, 88, 2, 3);
  Inc(X, 2);
  SetFillStyle(1, X);
  SetColor(X);
  FillEllipse(51, 88, 1, 2);
  FillEllipse(39, 88, 1, 2);
  X:= 45;
  SetFillStyle(1, X);
  SetColor(X);
  Bar(37, 66, 40, 85);   { Left leg }
  Line(41, 85, 45, 70);
  Line(41, 85, 41, 66);
  Line(41, 85, 42, 66);
  Line(41, 85, 43, 66);
  Line(41, 85, 44, 66);
  Line(41, 85, 45, 66);
  Bar(49, 66, 53, 85);   { right leg }
  Line(46, 66, 50, 85);
  Line(47, 66, 50, 85);
  Line(47, 66, 50, 85);
  Line(48, 66, 50, 85);
  Line(43, 69, 50, 69);
  SetColor(Green);
  Line(36, 66, 37, 85);
  Line(41, 85, 45, 70);
  Line(49, 85, 46, 70);
  Line(53, 85, 54, 66);
end;

procedure BottomHalf1;
begin
  X:= 25;
  For Y:= 100 to 102 do
  begin
    SetColor(X);
    Line(25, Y, 100, Y);
    Inc(X);
  end;
  For Y:= 103 to 105 do
  begin
    SetColor(X);
    Line(25, Y, 100, Y);
    Dec(X);
  end;
  X:= 1;
  SetColor(18);
  For Y:= 106 to 110 do
  begin
    Line(25 + X, Y, 100 + X, Y);
    Inc(X);
  end;
  X:= 30;
end;

procedure BottomHalf2;
begin
  X:= 25;
  For Y:= 100 to 102 do
  begin
    SetColor(X);
    Line(50, Y, 0, Y);
    Inc(X);
  end;
  For Y:= 103 to 105 do
  begin
    SetColor(X);
    Line(50, Y, 0, Y);
    Dec(X);
  end;
  X:= 0;
  SetColor(18);
  For Y:= 106 to 110 do
  begin
    Inc(X);
    Line(X, Y, 50 + X, Y);
  end;
end;

procedure Side1;
begin
  X:= 25;
  For Y:= 0 to 2 do
  begin
    SetColor(X);
    Line(Y, 65, Y, 100);
    Inc(X);
  end;
  For Y:= 3 to 5 do
  begin
    SetColor(X);
    Line(Y, 65, Y, 100);
    Dec(X);
  end;
  SetColor(18);
  For Y:= 0 to 5 do
    Line(Y, 106, Y + 13, 116);
end;

procedure Side2;
begin
  X:= 25;
  For Y:= 0 to 2 do
  begin
    SetColor(X);
    Line(Y, 65, Y, 35);
    Inc(X);
  end;
  For Y:= 3 to 5 do
  begin
    SetColor(X);
    Line(Y, 65, Y, 35);
    Dec(X);
  end;
  SetColor(18);
  For Y:= 0 to 5 do
    Line(Y, 106, Y + 17, 117);
end;

procedure Side3;
begin
  X:= 25;
  For Y:= 0 to 2 do
  begin
    SetColor(X);
    Line(Y, 5, Y, 35);
    Inc(X);
  end;
  For Y:= 3 to 5 do
  begin
    SetColor(X);
    Line(Y, 5, Y, 35);
    Dec(X);
  end;
  SetColor(18);
  For Y:= 0 to 5 do
    Line(Y, 106, Y + 20, 119);
end;

procedure Diagonal;
begin
  X:= 25;
  For Y:= 10 to 12 do
  begin
    SetColor(X);
    Line(5, Y, Y + 2, 5);
    Inc(X);
  end;
  For Y:= 13 to 15 do
  begin
    SetColor(X);
    Line(5, Y, Y + 2, 5);
    Dec(X);
  end;
end;

procedure Top;
begin
  X:= 25;
  For Y:= 1 to 3 do
  begin
    SetColor(X);
    Line(50, Y, 0, Y);
    Inc(X);
  end;
  For Y:= 4 to 5 do
  begin
    SetColor(X);
    Line(50, Y, 0, Y);
    Dec(X);
  end;
  SetColor(18);
  For Y:= 2 to 5 do
    Line(15 + Y, 114 + Y, 45 + Y, 114 + Y);
  X:= 30;
end;

procedure Noose;
begin
  X:= 42;
  SetColor(X);
  Line(43, 0, 43, 10);
  Line(47, 0, 47, 10);
  X:= 43;
  SetColor(X);
  Line(44, 0, 44, 10);
  Line(46, 0, 46, 10);
  X:= 44;
  SetColor(X);
  Line(45, 0, 45, 10);
  SetColor(42);
  Line(43, 0, 47, 0);
  PutPixel(43, 0, Black);
  PutPixel(47, 0, Black);
end;

procedure Area(X1, Y1, X2, Y2: integer; Cha: char);
var
  X, Y: integer;
begin
  For Y:= Y1 to Y2 do
    For X:= X1 to X2 do
      begin
        GoToXY(X, Y);
        Write(Cha);
      end;
end;

procedure At(X, Y: integer; Ln: char);
begin
  GoToXY(X, Y);
  Write(Ln);
end;

procedure WriteHangman(StartX: integer; Colour: word);
begin
  TextColor(Colour);
  At(1 + StartX, 1, #179); { H }
  At(1 + StartX, 2, #179);
  At(1 + StartX, 4, #179);
  At(1 + StartX, 5, #179);
  At(5 + StartX, 1, #179);
  At(5 + StartX, 2, #179);
  At(5 + StartX, 4, #179);
  At(5 + StartX, 5, #179);
  At(1 + StartX, 3, #195);
  At(5 + StartX, 3, #180);
  At(2 + StartX, 3, #196);
  At(3 + StartX, 3, #196);
  At(4 + StartX, 3, #196);

  At(7 + StartX, 2, #179); { A }
  At(7 + StartX, 4, #179);
  At(7 + StartX, 5, #179);
  At(11 + StartX, 2, #179);
  At(11 + StartX, 4, #179);
  At(11 + StartX, 5, #179);
  At(7 + StartX, 3, #195);
  At(11 + StartX, 3, #180);
  At(8 + StartX, 1, #196);
  At(9 + StartX, 1, #196);
  At(10 + StartX, 1, #196);
  At(8 + StartX, 3, #196);
  At(9 + StartX, 3, #196);
  At(10 + StartX, 3, #196);
  At(7 + StartX, 1, #218);
  At(11 + StartX, 1, #191);

  At(13 + StartX, 2, #179); { N }
  At(13 + StartX, 3, #179);
  At(13 + StartX, 4, #179);
  At(13 + StartX, 5, #179);
  At(14 + StartX, 2, #179);
  At(14 + StartX, 3, #179);
  At(16 + StartX, 1, #179);
  At(16 + StartX, 2, #179);
  At(16 + StartX, 3, #179);
  At(16 + StartX, 4, #179);
  At(14 + StartX, 4, #179);
  At(15 + StartX, 5, #196);
  At(13 + StartX, 1, #218);
  At(14 + StartX, 1, #191);
  At(14 + StartX, 5, #192);
  At(16 + StartX, 5, #217);

  At(19 + StartX, 1, #196); { G }
  At(20 + StartX, 1, #196);
  At(21 + StartX, 1, #196);
  At(19 + StartX, 5, #196);
  At(20 + StartX, 5, #196);
  At(21 + StartX, 5, #196);
  At(21 + StartX, 3, #196);
  At(18 + StartX, 1, #218);
  At(22 + StartX, 1, #191);
  At(22 + StartX, 3, #191);
  At(18 + StartX, 5, #192);
  At(22 + StartX, 5, #217);

  At(18 + StartX, 2, #179); { M }
  At(18 + StartX, 3, #179);
  At(18 + StartX, 4, #179);
  At(22 + StartX, 4, #179);
  At(24 + StartX, 2, #179);
  At(24 + StartX, 3, #179);
  At(24 + StartX, 4, #179);
  At(24 + StartX, 5, #179);
  At(26 + StartX, 2, #179);
  At(26 + StartX, 3, #179);
  At(28 + StartX, 2, #179);
  At(28 + StartX, 3, #179);
  At(28 + StartX, 4, #179);
  At(28 + StartX, 5, #179);
  At(25 + StartX, 1, #196);
  At(27 + StartX, 1, #196);
  At(24 + StartX, 1, #218);
  At(28 + StartX, 1, #191);
  At(26 + StartX, 1, #194);

  At(7 + StartX + 23, 2, #179); { A }
  At(7 + StartX + 23, 4, #179);
  At(7 + StartX + 23, 5, #179);
  At(11 + StartX + 23, 2, #179);
  At(11 + StartX + 23, 4, #179);
  At(11 + StartX + 23, 5, #179);
  At(7 + StartX + 23, 3, #195);
  At(11 + StartX + 23, 3, #180);
  At(8 + StartX + 23, 1, #196);
  At(9 + StartX + 23, 1, #196);
  At(10 + StartX + 23, 1, #196);
  At(8 + StartX + 23, 3, #196);
  At(9 + StartX + 23, 3, #196);
  At(10 + StartX + 23, 3, #196);
  At(7 + StartX + 23, 1, #218);
  At(11 + StartX + 23, 1, #191);

  At(13 + StartX + 23 , 2, #179); { N }
  At(13 + StartX + 23, 3, #179);
  At(13 + StartX + 23, 4, #179);
  At(13 + StartX + 23, 5, #179);
  At(14 + StartX + 23, 2, #179);
  At(14 + StartX + 23, 3, #179);
  At(16 + StartX + 23, 1, #179);
  At(16 + StartX + 23, 2, #179);
  At(16 + StartX + 23, 3, #179);
  At(16 + StartX + 23, 4, #179);
  At(14 + StartX + 23, 4, #179);
  At(15 + StartX + 23, 5, #196);
  At(13 + StartX + 23, 1, #218);
  At(14 + StartX + 23, 1, #191);
  At(14 + StartX + 23, 5, #192);
  At(16 + StartX + 23, 5, #217);
end;

(*procedure TitleScreen;
begin
  Window(1, 1, 80, 25);
  TextColor(Black);
  TextBackGround(Black);
  ClrScr;
  TextBackGround(LightGray);
  Area(10, 7, 15, 25, ' ');      { start of gallows }
  Area(10, 7, 55, 8, ' ');
  Area(50, 9, 55, 9, ' ');       { end of gallows }
  TextColor(Green);
  TextBackGround(Black);
  GoToXY(17, 25); Write('by Glenn Kentwell');
  TextColor(White);
  TextBackGround(LightGray);
  GoToXY(10, 7); Write(#218);
  For I:= 11 to 54 do
  begin
    GoToXY(I, 7);
    if I <> 53 then
      Write(#196);
  end;
  For I:= 8 to 25 do
  begin
    GoToXY(10, I);
    Write(#179);
  end;
  TextColor(Yellow);
  TextBackGround(Brown);
  Area(45, 10, 60, 10, #219);     { start of hair }
  Area(42, 11, 63, 11, #219);
  Area(40, 12, 65, 12, #219);
  Area(39, 13, 41, 15, #219);
  Area(64, 13, 66, 15, #219);     { end of hair }
  Area(42, 13, 63, 15, ' ');      { start of face }
  Area(42, 13, 42, 13, #219);     { these two lines are more hair... }
  Area(63, 13, 63, 13, #219);     {...so that the forehead isn't rectangular}
  Area(40, 16, 65, 17, ' ');
  Area(42, 18, 63, 18, ' ');
  Area(45, 19, 60, 19, ' ');
  Area(47, 20, 58, 20, ' ');      { end of face }
  TextColor(Black);
  Area(48, 15, 49, 15, #219);
  Area(56, 15, 57, 15, #219);
  Area(49, 18, 56, 18, #196);
  TextColor(LightCyan);               { start of coat }
  Area(47, 21, 58, 22, #219);
  Area(44, 22, 61, 22, #219);
  Area(40, 23, 65, 24, #219);
  Area(37, 24, 68, 24, #219);
  Area(35, 25, 70, 25, #219);     { end of Coat }
  TextColor(DarkGray);
  TextBackGround(Black);
  GoToXY(5, 5); Write('Welcome to...');
  WriteHangman(20, Red);
  WriteHangman(19, LightRed);
  TextBackGround(Black);
  TextColor(LightBlue);
  GoToXY(63, 8); Write('Press any key');
  GoToXY(71, 9); Write('to play...');
  X:= 0;
  While (not KeyPressed) and (X < 300) do
  begin
    Inc(X);
    Delay(10);
  end;
  TextColor(Black);
  TextBackGround(Black);
  if KeyPressed then ReadKey
  else
    For Y:= 1 to 12 do
      For X:= 1 to 80 do
        begin
          GoToXY(X, Y); Write(' ');
          GoToXY(81 - X, 26 - Y); Write(' ');
          Delay(1);
        end;
end;
  *)
procedure DrawSmiley;
var
  X, Y, I: integer;
  Size: Word;
begin
  SetFillStyle(1, 127);
  Bar(XPos - 22, YPos - 17, XPos + 22, YPos + 17);
  Y:= 16;
  For I:= 40 to 44 do
  begin
    SetFillStyle(1, I);
    SetColor(I);
    FillEllipse(XPos, YPos, Y + 5, Y);
    Dec(Y);
  end;
  SetColor(Black);
  Y:= 10;
  Ellipse(XPos, YPos + 15, 45, 135, Y + 5, Y);
  SetFillStyle(1, Black);
  FillEllipse(XPos - 7, YPos - 5, 3, 3);
  FillEllipse(XPos + 7, YPos - 5, 3, 3);
  Size:= ImageSize(XPos - 22, YPos - 17, XPos + 22, YPos + 17);
  GetMem(Smile, Size);
  GetImage(XPos - 22, YPos - 17, XPos + 22, YPos + 17, Smile^);
end;

procedure WoodBar;
begin
  SetFillStyle(1, Browns[5]);
  Bar(X1, Y1, X2, Y2);
  SetColor(Browns[6]);
  Line(X1, Y1, X2, Y1);
  Line(X1, Y1 + 1, X2, Y1 + 1);
  Line(X1, Y1, X1, Y2 - 1);
  Line(X1 + 1, Y1, X1 + 1, Y2);
  SetColor(Browns[0]);
  Line(X2, Y1, X2, Y2);
  Line(X2 - 1, Y1 + 1, X2 - 1, Y2);
  Line(X1 + 1, Y2 - 1, X2, Y2 - 1);
  Line(X1, Y2, X2, Y2);
  SetViewPort(X1, Y1, X2, Y2, ClipOn);
end;
end.

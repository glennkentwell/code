program CrapWindows;
Uses Graph, Crt, GrafBits, Mary;
Var
  X, Y: integer;
  Ch: Char;

procedure WinButton(x1,y1,x2,y2: integer; BkCol :word; Msg: String);
Const
  Os = 2;
Var
  Lngth, ExPos, YPos: integer;
begin
  SetColor(Black);
  Rectangle(X1, Y1, X2, Y2);
  Line(X1 + Os, Y2 - Os, X2 - Os, Y2 - Os);
  Line(X1 + 1, Y2 - 1, X2 - 1, Y2 - 1);
  Line(X2 - Os, Y2 - Os, X2, Y1 + Os);
  Line(X2 - 1, Y2 - 1, X2 - 1, Y1 + 1);
  SetColor(LightGray); SetFillStyle(1, LightGray);
  Bar(X1 + Os, Y1 + Os, X2 - Os, Y2 - Os);
  SetColor(White);
  Line(X1 + 1, Y1 + 1, X2 - 1, Y1 + 1);
  Line(X1 + 1, Y1 + 1, X1 + 1, Y2 - 1);
  Line(X1 + 1, Y2 - 1, X1 + 1, Y2 - 1);
  Line(X2 - 1, Y1 + 1, X2 - 1, Y1 + 1);
  SetColor(Black);
  Rectangle(X1, Y1, X2 + 1, Y2 + 1);
  PutPixel(X1, Y1, BkCol);
  PutPixel(X2 + 1, Y1, BkCol);
  PutPixel(X1 - 1, Y2 + 1, BkCol);
  PutPixel(X2 + 1, Y2 + 1, BkCol);
  SetTextJustify(1, 1);
  SetTextStyle(2, 0, 1);
  SetUserCharSize(3, 2, 3, 2);
  Lngth:= Length(Msg);
  ExPos:= (X2 - X1) div 2;
  ExPos:= ExPos + X1;
  YPos:= (Y2 - Y1) div 2;
  YPos:= Y1 + YPos;
  OutTextXY(ExPos, YPos, Msg);
  OutTextXY(ExPos + 1, YPos, Msg);
end;

procedure Box(X1, Y1, X2, Y2: integer; FoCol, BkCol, BarFoCol, BarBCol: word; Name: String);
Var
  Lngth, ExPos, YPos: integer;
begin
  SetFillStyle(1, LightBlue);
  FloodFill(1, 1, White);
  SetColor(FoCol);
  SetFillStyle(1, BarBCol);
  Bar(X1 + 3, Y1 + 3, X2 - 3, Y1 + 23);
  Line(X1 + 3, Y1 + 23, X2 - 3, Y1 + 23);
  Rectangle(X1, Y1, X2, Y2);
  Rectangle(X1 + 2, Y1 + 2, X2 - 2, Y2 - 2);
  SetColor(BarFoCol);
  SetTextJustify(1, 1);
  Val(ParamStr(1), X, Y);
  SetTextStyle(6, 0, 1);
  SetUserCharSize(4, 5, 1, 2);
  Lngth:= Length(Name);
  ExPos:= (X2 - X1) div 2;
  ExPos:= ExPos + X1;
  YPos:= Y1 + 10;
  OutTextXY(ExPos, YPos, Name);
  OutTextXY(ExPos + 1, YPos, Name);
  SetFillStyle(1, BkCol);
  FloodFill(X1 + 4, Y1 + 25, FoCol);
  WinButton(X1 + 3, Y1 + 3, X1 + 24, Y1 + 22, Blue,'-');
  WinButton(X2 - 23, Y1 + 3, X2 - 4, Y1 + 22, Blue, '^');
  WinButton(X2 - 46, Y1 + 3, X2 - 24, Y1 + 22, Blue, #30);
end;

procedure UserScreen;
begin
  GraphicsScreen;
  Box(0, 0, MaxX, MaxY, Black, LightBlue, White, Blue, 'Mouse Program');
  SetFillStyle(1, LightGray);
  Bar(3, 24, MaxX - 3, 39);
  SetTextStyle(2, 0, 1);
  SetUserCharSize(5, 3, 5, 3);
  SetColor(Black);
  OutTextXY(150, 30, 'This is a Menu Bar');
  OutTextXY(151, 30, 'This is a Menu Bar');
  WinButton(50, 50, 200, 75, LightBlue, 'Play a Tune');
  WinButton(50, 100, 200, 125, LightBlue, 'Exit');
end;

begin
  UserScreen;
  Repeat
  Ch:= ReadKey;
  if Ch = #0 then
    begin
      Ch:= ReadKey;
      Case Ch of
        #59:
        begin
          CloseGraph;
          Music;
          UserScreen;
        end;
      end;
    end;
  Until Ch = #27;
end.

{  Box(100, 100, 600, 200, White, LightRed, Blue, 'I am a box');
  Box(100, 250, 600, 350, Yellow, Brown, Blue,'I am a box');
  Box(100, 370, 600, 470, White, LightMagenta, Red,'I am a box');}

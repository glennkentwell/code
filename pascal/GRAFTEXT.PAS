program Graficks;
Uses Graph, Crt, GrafBits;
Var
  C, F, S, X, Xx, Y, Yy, Z, GD, GM : integer;
  Ch : char;
  eS : array[1..100] of string[80];
  eF : text;

procedure WriteCurrentSettings;
Var St : string;
begin
  SetTextJustify(1, 1);
  SetTextStyle (0, 0, 1);
  SetColor(Green);
  SetViewPort(0, GetMaxY - 10, GetMaxX, GetMaxY, ClipOn);
  ClearViewPort;
  Str(X, St);
  Insert ('X ratio : ', St, 0);
  OutTextXY (50, 5,St);
  Str(Y, St);
  Insert ('Y ratio : ', St, 0);
  OutTextXY (200, 5, St);
  Str(F, St);
  Insert('Font : ', St, 0);
  OutTextXY (350, 5, St);
  Str(S, St);
  Insert ('Font size : ', St, 0);
  OutTextXY (500, 5, St);
  SetViewPort (0, 0, GetMaxX, MaxY - 12, CLipOn);
  SetColor(White);
  SetTextJustify(0, 2);
end;

procedure CheckKeys;
begin
  Ch := ReadKey;
  Case Ch of
  'c': Inc(C);
  'C': Inc(C);
  ' ': Inc(S);
  #13: Dec(S);
  'f': Inc(F);
  'F': Inc(F);
  #0:
  begin
    Ch := ReadKey;
    Case Ch of
      #80: Inc(X);
      #72: Dec(X);
      #77: Dec(Y);
      #75: Inc(Y);
    end;
  end;
  end;
  if S < 1 then S := 1;
  if X < 1 then X := 1;
  if Y < 1 then Y := 1;
  if F > 10 then F := 0;
end;

begin
  GD := VGA;
  GM := 0;
  InitGraph(GD, GM, 'C:\TP\BGI');
  Assign(eF, 'C:\TP\BIN\NONAME00.PAS');
  Reset(eF);
  For X := 1 to 100 do
    Readln(eF, eS[X]);
  Close(eF);
  Y := 0;
  X := 0;
  S := 0;
  F := 5;
  C := 1;
  MaxX := GetMaxX;
  MaxY := GetMaxY;
  Repeat
    SetFillStyle(1, Blue);
    Bar(0, 0, MaxX, MaxY);
    SetColor(C);
    SetTextStyle(F, 0, S);
    SetUserCharSize(S, X, S, Y);
    Xx := 0;
    Yy := 0;
    For Z := 1 to 100 do
    begin
      OutTextXY(Xx, Yy, eS[Z]);
      Inc(Yy, TextHeight('a'));
      Xx := 0;
      if Yy > MaxY then Break;
    end;
    WriteCurrentSettings;
    CheckKeys;
    ClearViewPort;
  Until Ch = #27;
  CloseGraph;
end.

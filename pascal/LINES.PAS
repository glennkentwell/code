program Liney;
Uses Crt, Graph, GrafBits;
const
  Max = 500;
type
  TLine = object
    X, Y : array[1..3] of integer;
    DirX, DirY : array[1..3] of Boolean;
    Col : integer;
    procedure StartMeUpFirst;
    procedure StartMeUp;
    procedure ChangeMe;
    procedure DrawMe;
  end;

Var
  X, Y, Xx, Yy, Xxx, Yyy, Xyx, Yxy,
  Gd, Gm,
  Count, Counter, Num : integer;
  Lin : array[1..Max] of TLine;

procedure TLine.StartMeUpFirst;
begin
  For Counter:= 1 to 2 do
  begin
    X[Counter]:= Random(MaxX);
    Y[Counter]:= Random(MaxY);
  end;
  Col:= Random(15) + 1;
  Xx:= X[1]; Yy:= Y[1];
  Xxx:= X[2]; Yyy:= Y[2];
end;

procedure TLine.StartMeUp;
Const Plusser = 10;
begin
  X[1]:= Xx + Count * Plusser;
  Y[1]:= Yy + Count * Plusser;
  X[2]:= Xxx + Count * Plusser;
  Y[2]:= Yyy + Count * Plusser;
  Col:= Random(15) + 1;
end;

procedure TLine.ChangeMe;
begin
  for Counter:= 1 to 2 do
  begin
    if X[Counter] < 0 then DirX[Counter] := True
      else if X[Counter] > MaxX then DirX[Counter] := False;
    if Y[Counter] < 0 then DirY[Counter] := True
      else if Y[Counter] > MaxY then DirY[Counter] := False;
    Case DirX[Counter] of
      True: Inc(X[Counter]);
      False: Dec(X[Counter]);
    end;
    Case DirY[Counter] of
      True: Inc(Y[Counter]);
      False: Dec(Y[Counter]);
    end;
  end;
end;

procedure TLine.DrawMe;
begin
  SetColor(Col);
  Line(X[1], Y[1], X[2], Y[2]);
end;

procedure Lines;
begin
  Lin[1].StartMeUpFirst;
  For Count := 1 to Num do
    Lin[Count].StartMeUp;
  Repeat
    SetVisualPage(0);
    SetActivePage(1);
    ClearDevice;
    For Count := 1 to Num do
    begin
      Lin[Count].ChangeMe;
      Lin[Count].DrawMe;
    end;
    SetVisualPage(1);
    SetActivePage(0);
    ClearDevice;
    For Count := 1 to Num do
    begin
      Lin[Count].ChangeMe;
      Lin[Count].DrawMe;
    end;
  Until KeyPressed;
end;

begin
  Randomize;
  Gd:= EGA;
  Gm:= 1;
  InitGraph(Gd, Gm, '');
  ScreenVars;
  Val(ParamStr(1), Num, X);
  if Num = 0 then Num := 10;
  if Num > Max then Num := Max;
  SetFillStyle(1, Black);
  Lines;
  ReadKey;
  CloseGraph;
end.


procedure Lines;
var X2, Y2, X3, Y3, X4, Y4 : integer;
begin
  Randomize;
  X := Random(MaxX);
  Y := Random(MaxY);
  X2 := Random(MaxX);
  Y2 := Random(MaxY);
  X3 := Random(MaxX);
  Y3 := Random(MaxY);
  For Counter := 1 to 1500 do
  begin
    Operate;
    SetColor(Col);
    Line(X2, Y2, X, Y);
    Line(X3, Y3, X4, Y4);
    if KeyPressed then Break;
  end;
end;

begin
  GraphicsScreen('C:\tp\bgi');

  ReadKey;
end.
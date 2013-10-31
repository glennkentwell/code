program ReadTubes;
Uses Crt, Graph, GrafBits;
Var Gd, Gm, X, Y, SX, SY : integer;
    MaxX, MaxY : integer;
    S : String;

procedure ReadImage;
Var
  Size, Result : Word;
  P : pointer;
  F : file;
  FString : String;
begin
  X := 160;
  Y := 0;
  Repeat
    Size := ImageSize(0, X - 160, MaxX, X); {320, 480}
    if GraphResult <> 0 then
     begin
       CloseGraph;
       Write('Sorry, but I stuffed up.');
       ReadKey;
     end;
    GetMem(P, Size);
    Str(Y, FString);
    Insert('C:\GLENNS\TUBE', FString, 0);
    Insert('.GKI', FString, Length(FString) + 1);
    Assign(F, FString);
    ReSet(F, Size);
    BlockRead(F, P^, 1, Result);
    Close(F);
    PutImage(0, X - 160, P^, NormalPut);
    Inc(Y);
    Inc(X, 160);
    FreeMem(P, SizeOf(P));
  Until X > 480;
end;

procedure OutTextT;
Var Z : longint;
    Code : integer;
begin
  S := ParamStr(1);
  SetTextJustify (1, 1);
  Val(ParamStr(2), Z, Code);
  SetTextStyle (Z, 0, 4);
  SX := DivX - (TextWidth(S) div 2);
  SY := DivY - (TextHeight(S) div 2);
  Val(ParamStr(3), Z, Code);
  SetColor(Z);
  OutTextXY (SX, SY, S);
end;

begin
  GraphicsScreen;
  MaxX := GetMaxX;  MaxY := GetMaxY;
  ReadImage;
  OutTextT;
  ReadKey;
  CloseGraph;
end.

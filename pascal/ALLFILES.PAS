uses Crt,Dos, Cursor;
const
  Max = 4500;
type
  Str = string[80];

var
  Num,
  X, Y: integer;
  S: array[1..Max] of ^Str;
  F: file;
  Buffer: Str;
  Filename: string;
  Ch: char;


begin
  TextColor(Yellow);
  TextBackGround(Black);
  ClrScr;
  if ParamCount = 0 then
  begin
    Write('What file? ');
    Readln(Filename);
  end
  else Filename:= ParamStr(1);
  GoToXY(40 - Length(Filename) div 2, 1); Write(Filename);
  ClrScr;
  TextBackGround(Blue);
  NoCursor;
  Assign(F, Filename);
  Reset(F, 1);
  X:= 0;  Y:= 0;
  Window(20, 12, 60, 12);
  While (not Eof(F)) and (X < Max) do
  begin
    BlockRead(F, Ch, 1);
    if Ord(Ch) > 9 then Buffer:= Buffer + Ch;
    Inc(Y);
    Write('.');
    if Y > 80 then
    begin
      Inc(X);
      New(S[X]);
      S[X]^:= Buffer;
      Buffer:= '';
      Y:= 1;
    end;
  end;
  Num:= X;
  Y:= 0;
  Window(1, 2, 80, 25);
  For X:= 1 to Num do
  begin
    Write(S[X]^);
    if WhereY > 23 then
    begin
      ReadKey;
      ClrScr;
    end;
  end;
  Close(F);
end.
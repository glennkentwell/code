program Crapness;
uses Crt, Dos;
var
  Numbers: array[1..8] of byte;
  Result: array[1..45] of longint;
  Dupe: Boolean;
  Buff,
  Draws,
  I, J,
  X, Y: longint;
  Code: integer;
  F: Text;

procedure GetNumOfTimes;
begin
  if ParamCount <> 0 then
    Val(ParamStr(1), Draws, Code)
    else
    Draws:= 10000;
end;

procedure Init;
var
 DirInfo: SearchRec;         { For Windows, use TSearchRec }
begin
  GetNumOfTimes;
  TextColor(Black);
  TextBackGround(Black);
  ClrScr;
  TextColor(Yellow);
  GoToXY(25, 12); Write('Initializing...');
  For J:= 1 to 8 do
      Numbers[J]:= 0;
  Randomize;
  Assign(F, 'lotto.txt');
  FindFirst('LOTTO.TXT', Archive, DirInfo);
  if DosError = 0 then
    Append(F)
  else
    ReWrite(F)
end;

procedure GetANumber;
begin
  Dupe:= False;
  Buff:= Random(45) + 1;
  For X:= 1 to J do
  begin
    if Buff = Numbers[X] then Dupe:= True;
    if Buff = 0 then Dupe:= True;
  end;
end;

procedure FindResults;
begin
  Inc(Result[Buff]);
end;

procedure DrawNumbers;
begin
  Y:= 0;
  For I:= 0 to Draws do
  begin
    For J:= 1 to 8 do
    begin
      Repeat
        GetANumber;
      Until Dupe = False;
      Numbers[J]:= Buff;
      FindResults;
    end;
    if I = Y + 1000 then
    begin
      GoToXY(25, 12);
      Write('Now up to ', I);
      Inc(Y, 1000);
    end;
  end;
end;

procedure WriteToFile;
begin
  GoToXY(25, 12);
  Writeln(F, 'Of ', Draws,' draws, ');
  Writeln('Of ', Draws,' draws, ');
  For I:= 1 to 45 do
  begin
    Writeln(I, ' came out ', Result[I],' times.');
    Writeln(F, I, ' came out ', Result[I],' times.');
  end;
  Close(F);
end;

begin
  Init;
  DrawNumbers;
  WriteToFile;
end.


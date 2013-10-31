program Crapness;
uses Crt, Dos;
const
  Draws = 8000;
var
  Numbers: array[0..Draws, 1..8] of byte;
  Result: array[1..45] of longint;
  Dupe: Boolean;
  Buff,
  I, J,
  X, Y: integer;
  F: Text;

procedure Init;
begin
  For I:= 0 to Draws do
    For J:= 1 to 8 do
      Numbers[I, J]:= 0;
  Randomize;
  Assign(F, 'lotto.txt');
  Append(F);
end;

procedure GetANumber;
begin
  Dupe:= False;
  Buff:= Random(45) + 1;
  For X:= 1 to J do
  begin
    if Buff = Numbers[I, X] then Dupe:= True;
    if Buff = 0 then Dupe:= True;
  end;
end;

procedure FindResults;
begin
  Inc(Result[Buff]);
end;

procedure DrawNumbers;
begin
  For I:= 0 to Draws do
    For J:= 1 to 8 do
    begin
      Repeat
        GetANumber;
      Until Dupe = False;
      Numbers[I, J]:= Buff;
      FindResults;
    end;
end;

procedure WriteToFile;
begin
  ClrScr;
  Write('Writing to file now.');
  For I:= 0 to Draws do
  begin
    For J:= 1 to 8 do
      Write(F, Numbers[I, J],' ');
    Writeln(F);
    Write('.');
  end;
  Writeln('Of ', Draws,' draws, ');
  For I:= 1 to 45 do
    Write(I, ' came out ', Result[I],' times.  ');
  Close(F);
end;

begin
  Init;
  DrawNumbers;
  WriteToFile;
end.


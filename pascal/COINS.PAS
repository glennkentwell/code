program TwoUp;
uses Crt;
var
  Coins: array[1..2] of Boolean;
  Rand, I: integer;
  X: longint;
  Ch: char;
  F: text;

begin
  Randomize;
  Assign(F, 'Coins.TXT');
  ReWrite(F);
  X:= 0;
  While not KeyPressed do
  begin
    Inc(X);
    For I:= 1 to 2 do
    begin
      Rand:= Random(2);
      if Rand = 1 then Coins[I]:= True
        else Coins[I]:= False;
    end;
    if Coins[1] then Write('Heads ')
      else Write('Tails ');
    if Coins[2] then Writeln('Heads ')
      else Writeln('Tails ');
    if Coins[1] then Write(F, 'Heads ')
      else Write(F, 'Tails ');
    if Coins[2] then Writeln(F, 'Heads ')
      else Writeln(F, 'Tails ');
     Write(X);

  end;
  Close(F);
end.
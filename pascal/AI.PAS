program QA;
uses Crt;
var
  St: array[1..1000] of char;
  Vocab, Simul: array[1..1000] of String[20];
  Wod: array[1..100] of string[100];
  Ch: char;
  NumWords,
  I, L: integer;

procedure ReadVocabFile;
var
  F: text;
  X: integer;
begin
  X:= 0;
  Assign(F, '\glenns\vocab.txt');
  Reset(F);
  Inc(X);
  While not Eof(F) do
  begin
    Read(F, Ch);
    if Ch in ['A'..'Z', 'a'..'z', '0'..'9'] then
      Insert(Ch, Vocab[X], Length(Vocab[X]) + 1)
    else Inc(X);
  end;
  Close(F);
  Assign(F, '\glenns\simul.txt');
  Reset(F);
  X:= 0;
  Inc(X);
  While not Eof(F) do
  begin
    Read(F, Ch);
    if Ch in ['A'..'Z', 'a'..'z', '0'..'9'] then
      Insert(Ch, Simul[X], Length(Simul[X]) + 1)
    else Inc(X);
  end;
  NumWords:= 0;
  NumWords:= X;
  Close(F);
end;

function TestVocab(S: string): string;
var
  X: integer;
begin
  For X:= 1 to NumWords do
    if S = Vocab[X] then TestVocab:= Simul[X]
  else TestVocab:= '';
  if S = '' then TestVocab:= '';
end;

procedure GetAnswer;
var
  W, X: integer;
begin
  For X:= 1 to I do Wod[X]:= '';
  W:= 1;
  For X:= 1 to I do
    if St[X] in ['A'..'Z', 'a'..'z', '0'..'9'] then
      Insert(St[X], Wod[W], Length(Wod[W]) + 1)
    else if St[X] in ['.', ',', '/', '?', ' ', '(', ')', '[', ']', '!', '@', '#', '$', '%', '^', '&', '*', '-', '_'] then
      Inc(W);
    Write(TestVocab(Wod[1]), ' ');
  Writeln;
end;

procedure GetQuestion;
begin
  L:= 0;
  TextColor(Yellow);
  Writeln('Ask me something.');
  TextColor(LightBlue);
  Repeat
    Ch:= ReadKey;
    case Ch of
      #0: ReadKey;
      #10: Ch:= ReadKey;
      #8:
      begin
        Dec(L);
        GoToXY(WhereX - 1, WhereY);
        Write(' ');
        GoToXY(WhereX - 1, WhereY);
      end;
      else
      begin
        Write(Ch);
        Inc(L);
        St[L]:= Ch;
      end;
    end;
  Until (Ch = #13) or (Ch = #27);
  GoToXY(1, WhereY + 1);
  I:= L;
  GetAnswer;
{  TextColor(Yellow);
  For L:= 1 to I do
    Write(St[L]);}
end;

begin
  ClrScr;
  ReadVocabFile;
  While Ch <> #27 do
    GetQuestion;
end.
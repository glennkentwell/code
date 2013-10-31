program CalcLotto;
uses Crt;
var
  A: array[1..6] of longint;
  Answer: longint;

begin
  ClrScr;
  A[1]:= 43;
  A[2]:= 42;
  A[3]:= 41;
  A[4]:= 40;
  A[5]:= 39;
  A[6]:= 38;
  Answer:= A[1] * A[2] * A[3] * A[4] * A[5] * A[6];
  Write('Answer is : ', Answer);
  ReadKey;
end.
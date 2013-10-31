program Fibonacci;
uses Crt;
var
  X, Y, Next: longint;

begin
  Writeln('Enter two seed integers : ');
  Readln(X, Y);
  Writeln(X:10);
  Repeat
    Writeln(Y:10);
    Next:= X + Y;
    X:= Y;
    Y:= Next;
    Delay(500);
  Until KeyPressed;
  ReadKey;
end.

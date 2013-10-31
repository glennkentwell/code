program Modemnusty;
uses Crt;
const
  InitString = 'ATM1L1E1Q0V1X1S7=55S11=60S0=0';
  HangUp = 'ATH';
var
  X: integer;
  S, St: string;
  ComPort: text;
begin
  Assign(ComPort, 'COM2');
  Rewrite(ComPort);
  Write('Initialising modem...');
  Write(ComPort, InitString);
  Reset(ComPort);
  Readln(ComPort, St);
  Writeln;
  Repeat
    Readln(S);
    if S <> 'exit' then
    begin
      Rewrite(ComPort);
      Write(ComPort, S);
      Reset(ComPort);
      Read(ComPort, St);
      Writeln(St);
    end;
  Until S = 'exit';
  Write('Hanging up...');
  Write(ComPort, HangUp);
end.
program PrintShit;
uses Crt, Printer;
const
  ESC = #27;
  RES = '@';
var
  PrintSt,
  PrintStr,
  S: string;
  Ch: Char;
  F: text;
  Code: integer;

begin
  ClrScr;
  Write('Enter a message to print out. ');
  ReadLn(PrintStr);
  While PrintStr <> '' do
  begin
  Writeln;
  Writeln('Type in a control code number: ');
  ReadLn(Code);
  PrintSt:= ESC + 'x' + #1;
  Writeln;
  Write('Printing...');
  { Set typestyle }
  Assign(F, 'LPT1');
  ReWrite(F);
  Write(F, PrintSt);
  Str(Code, PrintSt);
  Write(F, ESC + PrintSt + '@');
  Write(F, PrintStr);
  ClrScr;
  Write('Enter a message to print out. ');
  ReadLn(PrintStr);
  end;
end.



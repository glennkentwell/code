program Whatever;
uses Crt, Printer;
var
  S, OldS: string;

begin
  S:= '';
  While S <> 'quit' do
  begin
    Write('What do you want to print? ');
    OldS:= S;
    ReadLn(S);
    if S = '' then S:= OldS;
    Writeln(LST, S);
    Writeln(LST, '');
  end;
end.

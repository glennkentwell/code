program Nut;
uses Crt;
var
  G, I: integer;
  Dir: Boolean;
  S, Str:string;

begin
  if ParamCount = 0 then
  begin
    ClrScr;
    Write('What message do you want to display? ');
    ReadLn(S);
  end
  else
    For I:= 1 to ParamCount do
      S:= S + ' ' + ParamStr(I);
  Dir:= True;
  While not KeyPressed do
  begin
    if Dir then Inc(I)
      else Dec(I);
    if I > 78 - Length(S) then Dir:= False;
    if I < 1 then Dir:= True;
    Str:= '';
    For G:= 1 to I do
      Insert(' ', Str, Length(Str) + 1);
    Writeln(Str, S);
    Sound(I * 500);
    Delay(1);
    NoSound;
  end;
  ReadKey;
  While not KeyPressed do
  For G:= 0 to 15 do
    For I:= 1 to G do
    begin
      Sound(500 * I);
      Delay(10);
      NoSound;
    end;
  ReadKey;
  While not KeyPressed do
  begin
    if Dir then Inc(I)
      else Dec(I);
    if I > 14 - Length(S) then Dir:= False;
    if I < 10 then Dir:= True;
    Sound(I * 500);
    Delay(5);
    NoSound;
  end;
end.
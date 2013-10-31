program Connections;
uses Crt, Dos;
const
  Str1 = 'Connected';
  Str2 = 'Elapsed';
var
  X, Y, I: integer;
  New, Old: text;
  Line, S: string;
  Ch: char;
  Help, FileOff, DownloadsOff, ScreenOff: Boolean;

procedure OpenFiles;
begin
  Assign(Old, 'telix.tlx');
  Reset(Old);
  Assign(New, 'newtelix.tlx');
  ReWrite(New);
end;

procedure ReadFile;
var
  LenCon, LenEla: integer;
begin
  X:= 1;
  Y:= 22;
  LenCon:= Length('Connected') - 1;
  LenEla:= Length('Elapsed') - 1;
  While not Eof(Old) do
  begin
    Readln(Old, Line);
    S:= ' ';
    For I:= 21 to (21 + LenCon) do
      Insert(Line[I], S, Length(S));
    if S = 'Connected ' then
    Repeat
      if not FileOff then
        if not DownloadsOff then Writeln(New, Line)
          else if S = 'Connected ' then Writeln(New, Line);
      if not ScreenOff then
        if not DownloadsOff then Writeln(Line)
          else if S = 'Connected ' then Writeln(Line);
      Readln(Old, Line);
      S:= ' ';
      For I:= 21 to (21 + LenEla) do
        Insert(Line[I], S, Length(S));
      if not FileOff then
        if S = 'Elapsed ' then
          Writeln(New, Line);
    Until S = 'Elapsed ';
  end;
end;

procedure CloseFiles;
begin
  Close(Old);
  Close(New);
end;

procedure AskForOptions;
begin
  TextColor(Blue);
  TextBackGround(LightGray);
  ClrScr;
  GoToXY(20, 10);  Write('[1]  All call details   (Downloads, uploads etc.)');
  GoToXY(20, 12);  Write('[2]  "Connect with..." + "Elapsed time online" only');
  GoToXY(20, 14);  Write('[3]  "Connect with..." only');
  TextColor(Red);
  GoToXY(20, 20);  Write('Please make a selection (Default = 1) [   ]');
  GoToXY(WhereX - 3, WhereY);
  Ch:= ReadKey;
end;

procedure CommandLineOptions;
var
  St: string;
begin
  if ParamCount <> 0 then
  begin
    For X:= 1 to ParamCount do
    begin
      St:= ParamStr(X);
      if St[1] = '/' then
      begin
        if (St[2] = 'i') or (St[2] = 'I') then DownloadsOff:= True;
        if (St[2] = 's') or (St[2] = 'S') then ScreenOff:= True;
        if (St[2] = 'f') or (St[2] = 'F') then FileOff:= True;
        if (St[2] = '?') then Help:= True;
      end;
    end;
  end;
end;

procedure Helping;
begin
  Writeln;
  Writeln('Command Line Options ');
  Writeln;
  Writeln('/S   --    turns output to screen OFF');
  Writeln('/I   --    only outputs "connected with" information');
  Writeln('/F   --    turns output to file OFF');
  Writeln('/?   --    this help screen');
  Writeln;
  Writeln;
end;

begin
  CommandLineOptions;
  if not Help then
  begin
    OpenFiles;
    ReadFile;
    CloseFiles;
  end else Helping;
end.

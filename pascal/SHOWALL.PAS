program viewer;
uses crt, uborder;
const
  name = ' FILE VIEWER ';

type PPChar = array [1..5000] of ^Char;

var
  I, max, C, Counter : integer;
  maths, filename : string[30];
  Charc : PPChar;
  Mv : char;
  f : File;


procedure open_file_ask;
begin
  clrscr;
  lowvideo;
  gotoxy (2,5); write (' Filename? '); highlight_bar (47,0,7,7,0);
  repeat
    gotoxy (13,5); readln (filename);
  until filename <> '';
  window (1,1,80,25);
end;

procedure open_file;
begin
  open_file_ask;
  assign (f,filename);
  reset (f);
  counter := 0;
  For Counter := 1 to 5 do
  begin
    BlockRead (f,maths, SizeOf(maths));
    if Eof(F) = True then Break;
  end;
  close (f);
end;

procedure Message_Bar;
begin
  GotoXY (2,1);
  Highlight_Bar (78,0,7,0,7);
  GoToXY (2,1); Write ('File : ',filename);
  GotoXY (40,1); Write (#24,'/',#25,' or PgUp/PgDn');
  GotoXY (59,1); Write ('Press Escape to Exit.');
  TextColor (7);
  TextBackground (0);
end;

{procedure UpArrow;
begin
  ClrScr;
  counter := counter - 24;
  c := counter + 23;
  if counter <= 1 then
  begin
    Counter := 1;
    C := 23;
  end;
  repeat
    Write (Charc[Counter]^);
    Inc(counter);
  until WhereY = C;
end;

procedure DownArrow;
begin
  ClrScr;
  dec (Counter,22);
  c:= counter + 23;
    if c >= max then c := max;
end;

procedure PageDown;
begin
  ClrScr;
  Counter := counter - 1;
  C := Counter + 22;
  if c >= max then c := max;
  repeat
    Writeln (line[Counter]^);
    Inc(counter);
  until counter = c;
end;

procedure PageUp;
begin
  ClrScr;
  counter := counter - 44;
  c := counter + 23;
  if counter <= 1 then
  begin
    Counter := 1;
    C := 23;
  end;
  repeat
    Writeln (line[Counter]^);
    Inc(counter);
  until counter = c;
end; }

procedure Memry;
begin
  Frame (20,21,60,24);
  ClrScr;
  Writeln; Writeln;
  Writeln ('          ',MemAvail ,' bytes available.');
  Readkey;
  Window (1,2,80,25);
  ClrScr;
  {DownArrow;
  UpArrow;}
end;

procedure Look_Articles;
begin
  Open_file;
  Counter := 0;
  Message_Bar;
  window (1,2,80,25);
  clrscr;
  repeat
    Inc(Counter);
    Write (CharC[C]^);
  until WhereY = 23;
  repeat
    Mv := ReadKey;
    if Mv = #0 then
    begin
      Mv := Readkey;
      if Mv = #59 then Memry;
{        if Mv = #72 then UpArrow;
        if Mv = #80 then DownArrow;
        if Mv = #81 then PageDown;
        if Mv = #73 then PageUp;
  }  end;
  until Mv = #27;
  Window (1,1,80,25);
  ClrScr;
end;

procedure init;
begin
  textcolor (7);
  textbackground (0);
  clrscr;
end;

begin
  init;
  look_articles;
end.


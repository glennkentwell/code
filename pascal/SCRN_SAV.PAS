unit scrn_sav;
interface
   procedure Save;
   procedure gettingtime(Ex, Why : integer);
   procedure Menu;
   function leadingzero(w:word):string;
   var
     SaverSpeed, a, WherY  : integer;
     Delayer : shortint;
     Mins : shortint;
     SaverMsg, Directory : string[127];
     BoCol, TeCol, NaCol, InCol: string;
     BCol, TCol, NCol, ICol: shortint;

implementation
uses crt, dos, Graph, GrafBits;
var w, h2, m2, s2, hu2 : word;

function LeadingZero(w:word):string;
var
  s : String;
begin
  Str(w:0,s);
  if Length(s) = 1 then
    s := '0' + s;
  LeadingZero := s;
end;

function FindColour(Val: string):shortint;
begin
  if Val = 'Black' then FindColour:= 0
  else if Val = 'Blue' then FindColour:=  1
  else if Val = 'Green' then  FindColour:= 2
  else if Val = 'Cyan' then FindColour:=  3
  else if Val = 'Red' then FindColour:=  4
  else if Val = 'Magenta' then FindColour:=  5
  else if Val = 'Brown' then FindColour:=  6
  else if Val = 'LightGray' then FindColour:=  7
  else if Val = 'DarkGray' then FindColour:=  8
  else if Val = 'LightBlue' then FindColour:=  9
  else if Val = 'LightGreen' then FindColour:= 10
  else if Val = 'LightCyan' then FindColour:=  11
  else if Val = 'LightRed' then FindColour:=  12
  else if Val = 'LightMagenta' then FindColour:=  13
  else if Val = 'Yellow' then FindColour:=  14
  else if Val = 'White' then FindColour:= 15;
end;


procedure menu;
var
 i, k,x,y, Rows :integer;
 StringNo : array [1..60] of string[20];
 Name : string;
 f : text;
begin
  ClrScr;
  Write ('Please be waiting...');
  K := 0;
  x := 0;
  Rows := 0;
  WherY := 0;
  Assign (f,'C:\GLENNS\MENU.TXT');
  Reset (f);
  ReadLn (f,Delayer);
  ReadLn (f,Name);
  ReadLn (f, BoCol);
  ReadLn (f, TeCol);
  ReadLn (f, NaCol);
  ReadLn (f, InCol);
  ReadLn (f,SaverMsg);
  ReadLn (f,Directory);
  BCol:= FindColour(BoCol);
  TCol:= FindColour(TeCol);
  NCol:= FindColour(NaCol);
  ICol:= FindColour(InCol);
  Repeat
    Inc (X);
    Readln (f, StringNo[X]);
  Until StringNo[X] = '';
  Close (f);
  ChDir (Directory);
  if Delayer < 1 then Delayer := 1;
  if Delayer > 59 then Delayer := 59;
  X := X - 1;
  Rows := X div 3;
  ClrScr;
  TextColor(BCol);
  WherY := 2;
  For K := 1 to Rows do
  begin
    WherY := WherY + 1;
    GoToXY (5,WherY); write (K,'.','  ',StringNo[K]);
  end;
  WherY := 2;
  For K := Rows + 1 to Rows * 2 do
  begin
    WherY := WherY + 1;
    GoToXY (30,WherY); write (K,'.','  ',StringNo[K]);
  end;
  WherY := 2;
  For K := (Rows * 2) + 1 to Rows * 3 do
  begin
    WherY := WherY + 1;
    GoToXY (55,WherY); write (K,'.','  ',StringNo[K]);
  end;
  Inc(K);
  TextColor(TCol);
  gotoxy (1,1); write ('É');
  for i := 1 to 78 do
  write ('Í');
  write ('»');
  for y := 2 to WherY + 1 do
  begin
   gotoxy (80,y); writeln ('º');
  end;
  gotoxy (80,WherY + 1); write ('¼');
  for x := 79 downto 2 do
  begin
    gotoxy (x,WherY + 1); write ('Í');
  end;
  gotoxy (1,WherY + 1); write ('È');
  for y := WherY downto 2 do
  begin
    gotoxy (1,y); write ('º');
  end;
  TextColor(NCol);
  gotoxy (38-length(name) div 2, 1); write (#181,' ',name,' ',#198);
  TextColor(ICol);
  gotoxy (15,WherY + 2);  write ('TYPE THE NUMBER OF YOUR CHOICE THEN PRESS ENTER');
  gettime (h2,m2,s2,hu2);
  Mins := m2;
end;


procedure Save;
var
  Command: string[127];
begin
    if SaverMsg <> '' then
    begin
      SwapVectors;
      Exec('C:\COMMAND.COM', '/C ' + SaverMsg);
      SwapVectors;
      if DosError <> 0 then
        WriteLn('Could not execute COMMAND.COM');
      WriteLn;
    end;
  Menu;
end;

procedure gettingtime;
var
  AmOrPm : string[3];
  KeyRead : char;
begin
  TextColor(LightGray);
  begin
    repeat
      gettime (h2,m2,s2,hu2);
      if h2 > 11 then
      begin
        if h2 <> 12 then
          h2 := h2 - 12;
        AmOrPm := 'pm';
      end
        else AmOrPm := 'am';
      if hu2 <= 5 then
      begin
        gotoxy (Ex,Why);
        write (' ',(h2),':',leadingzero(m2),':',LeadingZero(s2),' ',AmOrPm,' ');
        GoToXY (80,WherY+2);
      end;
      if s2 = 1 then
        if m2 - Mins = Delayer then
        begin
          Save;
        end;
    until keypressed;
    a := a + 1;
  end;
end;
end.


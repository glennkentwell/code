{$I-}
program viewer;
uses Crt, Dos, ScrnWrit, Strings, Cursor;
const
  name = ' FILE VIEWER ';

type sstring = ^string;

var
  Line : array[0..5000] of sstring;
  max, Top, Bot, CC, Counter : integer;
  filenamer : array[0..79] of char;
  filename : string;
  SomeString : String;
  Buffer, Mv : char;
  f : text;
  Chars, FS : LongInt;
  Buff : SearchRec;
  Col, BCol, BarCol, BarBCol, XC : integer;
  LastL, ThisL : shortint;

procedure Message_Bar(BC, BBC : integer);
Var
  Star : String;
begin
  BarCol := BC;
  BarBCol := BBC;
  TextColor(BarCol);
  TextBackGround(BarBCol);
  Star := #24 + ' ' + #25 + ' PgUp PgDn ';
  Command_Bar('File : ','    ', ' Keys : ', '  F1',' ESC','',FileName,'',Star,' Info ',' Exit','');
  TextColor(Col);
  TextBackGround(BCol);
end;

procedure CheckForLongLines;
begin
  if Length(Line[Counter]^) > 80 then Dec(Bot);
end;

procedure ChangeForeColour;
begin
  Inc(Col);
  if Col > 15 then Col := 0;
  TextColor(Col);
  ClrScr;
  Counter := Top;
  Repeat
    if WhereY < 24 then Writeln (Line[Counter]^)
      else Write (Line[Counter]^);
    Inc(Counter);
    CheckForLongLines;
  Until Counter = Bot;
end;

procedure ChangeBackColour;
begin
  Inc(BCol);
  if BCol > 15 then BCol := 0;
  TextBackGround(BCol);
  ClrScr;
  Counter := Top;
  Repeat
    if WhereY < 24 then Writeln (Line[Counter]^)
      else Write (Line[Counter]^);
    Inc(Counter);
    CheckForLongLines;
  Until Counter = Bot;
end;

procedure ChangeBarColour;
begin
  Inc(BarCol);
  if BarCol > 15 then BarCol := 0;
  Message_Bar(BarCol, BarBCol);
  Window(1, 1, 80, 24);
end;

procedure ChangeBackBarColour;
begin
  Inc(BarBCol);
  if BarBCol > 15 then BarBCol := 0;
  Message_Bar(BarCol, BarBCol);
  Window(1, 1, 80, 24);
end;

procedure FindError(FE : integer);
begin
  if FE = 1 then
  begin
    GoToXY (1, WhereY + 1);
    Write ('Enter Filename : ');
    ReadLn (FileNamer);
    if FileNamer = '' then Halt(1);
  end;
  if FE = 2 then
  begin
    GoToXY (1, WhereY + 1);
    Writeln ('File ',ParamStr(1),' not found.');
    Halt(1);
  end;
end;

procedure open_file;
var XC : integer;
begin
  if ParamCount <> 0 then
    begin
      StrPCopy(FileNamer, ParamStr(1));
      {Convert file name to null term. string}
    end
  else FindError(1);
  StrUpper(FileNamer);                   {Convert file name to upper case}
  FileName := StrPas(FileNamer);
  FindFirst(FileName, AnyFile, Buff);
  FS := Buff.Size;
  Assign (F, FileName);
  Reset (f);
  if IOResult <> 0 then
  begin
    FindError(2);
    Exit;
  end;
  Counter := 0;
  repeat
    Inc(Counter);
    Readln(F, SomeString);
    GetMem(Line[Counter], Length(SomeString) + 1);
    Line[Counter]^ := SomeString;
    CC := Length(SomeString);
    Chars := Chars + CC;
  Until EOF(f);
  Max := Counter;
  repeat
    inc (counter);
    line[counter]^ := '';
  until counter = max + 2;
  close (f);
end;

procedure UpArrow;
begin
  if Top <> 1 then
  begin
    Dec(Top);
    if Top < 1 then Top := 1;
    Bot := Top + 24;
    Counter := Top;
    GoToXY (1, 1);
    InsLine;
      if WhereY < 24 then Writeln (Line[Counter]^)
        else Write (Line[Counter]^);
  end;
end;

procedure DownArrow;
begin
  if Bot < Max then
  begin
    Inc(Top);
    if Top > Max - 23 then Top := Max - 23;
    Bot := Top + 23;
    Counter := Bot;
    GoToXY (1, 1);
    DelLine;
    GoToXY (1, 24);
      if WhereY < 24 then Writeln (Line[Counter]^)
        else Write (Line[Counter]^);
  end;
end;

procedure PageDown;
begin
  ClrScr;
  Inc(Top, 23);
  if Top > Max - 24 then Top := Max - 24;
  Bot := Top + 24;
  Counter := Top;
  repeat
    if WhereY < 24 then Writeln (Line[Counter]^)
      else Write (Line[Counter]^);
    Inc(counter);
    CheckForLongLines;
  until counter = Bot;
end;

procedure PageUp;
begin
  ClrScr;
  Dec(Top, 23);
  if Top < 1 then Top := 1;
  Bot := Top + 24;
  Counter := Top;
  repeat
    if WhereY < 24 then Writeln (Line[Counter]^)
      else Write (Line[Counter]^);
    Inc(counter);
    CheckForLongLines;
  until Counter = Bot;
end;

procedure HomeKey;
begin
  ClrScr;
  Top := 1;
  Bot := 24;
  Counter := 0;
  repeat
    Inc(Counter);
    if WhereY < 24 then Writeln (Line[Counter]^)
      else Write (Line[Counter]^);
    CheckForLongLines;
  until Counter = 24;
end;

procedure EndKey;
begin
  ClrScr;
  Top := Max - 24;
  Bot := Max;
  Counter := Top;
  Repeat
    if WhereY < 24 then Writeln (Line[Counter]^)
      else Write (Line[Counter]^);
    Inc(Counter);
    CheckForLongLines;
  Until Counter = Bot;
end;

procedure Memry;
begin
  TextBackGround(LightGray);
  Frame (20, 15, 60, 24, 2, '');
  ClrScr;
  HighVideo;
  GoToXY (9, 2); Writeln ('GENERAL INFORMATION');
  LowVideo;
  GoToXY (5, 4);
  Writeln ('Memory : ',MemAvail ,' bytes free');
  GoToXY (7, 6);
  WriteLn ('File : ', FS:6 ,' bytes');
  GoToXY (7, 7);
  Writeln ('       ',Max:6 ,' lines');
  GoToXY (2, 8);
  Writeln ('Text Size : ',Chars:6,' characters');
  Readkey;
  HighVideo;
  Window (1,1,80,24);
  TextBackGround(Blue);
  ClrScr;
  Counter := Top;
  Repeat
    if WhereY < 24 then Writeln (Line[Counter]^)
      else Write (Line[Counter]^);
    Inc(Counter);
    CheckForLongLines;
  Until Counter = Bot + 1;
end;

procedure Look_Articles;
begin
  Open_file;
  Inc(Max);
  Counter := 0;
  Message_Bar(7, 14);
  window (1,1,80,24);
  Col := 14;
  BCol := 1;
  TextColor (Col);
  TextBackground (BCol);
  ClrScr;
  repeat
    Inc(Counter);
    if WhereY < 24 then Writeln (Line[Counter]^)
      else Write (Line[Counter]^);
  until Counter = 24;
  Top := 1;
  Bot := 24;
  repeat
    Mv := ReadKey;
    case UpCase(Mv) of
    'C': ChangeForeColour;
    'B': ChangeBackColour;
    #0:
    begin
      Mv := Readkey;
      case Mv of
        #59: Memry;
        #72: UpArrow;
        #80: DownArrow;
        #81: PageDown;
        #73: PageUp;
        #71: HomeKey;
        #79: EndKey;
        #46: ChangeBarColour;
        #48: ChangeBackBarColour;
      end;
    end;
    end;
  until Mv = #27;
  Window (1,1,80,25);
  ClrScr;
end;

procedure init;
begin
  Col := 7;
  BCol := 0;
  TextColor (Col);
  TextBackGround (BCol);
  NoCursor;
end;

begin
  init;
  look_articles;
  NormCursor;
end.


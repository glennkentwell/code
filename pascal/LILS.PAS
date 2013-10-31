program Lillys;
uses Crt;
const
  DocTitle = 'LILLYS SURGERY';
  ForeCol = White;
  BarCol = Green;
  BackCol = Blue;
  CmdFCol = Yellow;
  CmdBCol = Red;

type
  TPatient = object
    Name: string[30];
    Address: string[45];
    Phone: string[10];
    Ailment, Treatment: string[60];
    Charge: string[7];
    Number: integer;
    procedure GetInfo;
    procedure GetInfoFromFile;
    procedure WriteToFile;
    function GetInfoDone: Boolean;
    procedure WriteInfo(Num: byte);
    procedure PrintMe;
  end;

procedure WriteToFile; Forward;
var
  Patient: array[1..200] of TPatient;
  MaxCount, Counter,
  X, Y, I: integer;
  F,
  TempFile: text;
  NeedToQueryWriteToFile: Boolean;

procedure CommandBar(Key1, Key2, Key3, Cmd1, Cmd2, Cmd3: string; Col, BCol: word);
begin
  TextColor(Col);
  TextBackGround(BCol);
  Window(1, 25, 80, 25);
  ClrScr;
  GoToXY(1, 25);
  HighVideo;  Write(Key1, ' ');
  LowVideo;  Write(Cmd1, '  ');
  HighVideo;  Write(Key2, ' ');
  LowVideo;  Write(Cmd2, '  ');
  HighVideo;  Write(Key3, ' ');
  LowVideo;  Write(Cmd3, '  ');
  TextBackGround(BCol);
end;

procedure HighLightBar(L: integer; BarCol, Origcol: word);
begin
  TextBackGround(BarCol);
  For I:= 1 to L do
    Write(' ');
  TextBackGround(BackCol);
end;

procedure GeneralScreen(CmdMessage: string);
begin
  TextColor(CmdBCol);
  TextBackGround(CmdBCol);
  ClrScr;
  TextColor(CmdFCol);
  GoToXY(40 - Length(DocTitle) div 2, 1);
  Write(DocTitle);
  CommandBar('','',CmdMessage,'','','',CmdFCol,CmdBCol);
  TextBackGround(BackCol);
  TextColor(BackCol);
  Window(1, 2, 80, 24);  ClrScr;
  TextColor(ForeCol);
end;

procedure GetInfoScreen;
begin
  GeneralScreen('When finished, press ENTER without an entry for Patient Name');
  GoToXY(60, 23); Write('Patient Number : ', Counter);
  GoToXY(5, 5);  Write('Patient Name ');  HighLightBar(30, BarCol, ForeCol);
  GoToXY(5, 7);  Write('     Address ');  HighLightBar(45, BarCol, ForeCol);
  GoToXY(64, 7);  Write('Phone ');  HighLightBar(10, BarCol, ForeCol);
  GoToXY(5, 9);  Write('     Ailment ');  HighLightBar(60, BarCol, ForeCol);
  GoToXY(5, 11);  Write('   Treatment ');  HighLightBar(60, BarCol, ForeCol);
  GoToXY(5, 13);  Write('     Amount $');  HighLightBar(7, BarCol, ForeCol);
  TextBackGround(BarCol);
  TextColor(Black);
end;

function TPatient.GetInfoDone;
begin
  if Name = '' then GetInfoDone:= True
    else GetInfoDone:= False;
end;

procedure TPatient.GetInfo;
var S: string;
begin
  GetInfoScreen;
  GoToXY(18, 5); ReadLn(Name);
  if not GetInfoDone then
  begin
    Number:= Counter;
    GoToXY(18, 7); ReadLn(Address);
    GoToXY(70, 7); ReadLn(Phone);
    GoToXY(18, 9); ReadLn(Ailment);
    GoToXY(18, 11); ReadLn(Treatment);
    GoToXY(18, 13); ReadLn(Charge);
  end;
end;

procedure AskStuff;
begin
  NeedToQueryWriteToFile:= True;
  Counter:= MaxCount;
  Patient[Counter].GetInfo;
  While not Patient[Counter].GetInfoDone do
  begin
    Inc(Counter);
    Patient[Counter].GetInfo;
  end;
  MaxCount:= Counter;
end;


function QueryWriteToFile: Boolean;
var Ch: char;
begin
  NeedToQueryWriteToFile:= False;
  Window(17, 8, 67, 16);
  TextBackGround(DarkGray);
  ClrScr;
  Window(15, 7, 65, 15);
  TextColor(LightGray);
  TextBackGround(LightGray);
  ClrScr;
  TextColor(Blue);
  GoToXY(17, 2); Write('HEY WAIT A MINUTE!');
  TextColor(Black);
  GoToXY(8, 5); Write('Save the new patient records [Y/N]?');
  Ch:= ReadKey;
  if UpCase(Ch) = 'Y' then QueryWriteToFile:= True
    else QueryWriteToFile:= False;
  Window(1, 1, 80, 25);
end;

procedure TPatient.WriteToFile;
begin
    Writeln(F, Number);
    Writeln(F, Name);
    Writeln(F, Address);
    Writeln(F, Phone);
    Writeln(F, Ailment);
    Writeln(F, Treatment);
    Writeln(F, Charge);
end;

procedure WriteToFile;
begin
  if NeedToQueryWriteToFile then
  if QueryWriteToFile then
  begin
    Assign(F, 'C:\LILLYS\LIZDOCS.DAT');
    ReWrite(F);
    For Counter:= 1 to MaxCount do
      Patient[Counter].WriteToFile;
    Close(F);
  end;
end;

procedure TPatient.GetInfoFromFile;
begin
  ReadLn(F, Number);
  ReadLn(F, Name);
  ReadLn(F, Address);
  ReadLn(F, Phone);
  ReadLn(F, Ailment);
  ReadLn(F, Treatment);
  ReadLn(F, Charge);
end;

procedure ReadFile;
begin
  Counter:= 0;
  Assign(F, 'C:\LILLYS\LIZDOCS.DAT');
  Reset(F);
  While not Eof(F) do
  begin
    Inc(Counter);
    Patient[Counter].GetInfoFromFile;
  end;
  Close(F);
  MaxCount:= Counter;
end;

procedure WriteInfoScreen;
begin
  GeneralScreen('ESCAPE - Menu   "P" - Print   F5 - Edit Top Record ');
  TextColor(Black);
  GoToXY(1, 8);
  For I:= 1 to 80 do
    Write(#196);
  GoToXY(1, 16);
  For I:= 1 to 80 do
    Write(#196);
  X:= 70;
  For Y:= 1 to 23 do
  begin
    GoToXY(X, Y);
    Write(#179);
  end;
  GoToXY(X, 8); Write(#197);
  GoToXY(X, 16); Write(#197);
  TextColor(White);
end;

procedure TPatient.WriteInfo;
var
  XDist: shortint;
begin
  GoToXY(1, (Num * 8) + 1);
  TextColor(Yellow);
  Write(Name);
  GoToXY(71, (Num * 8) + 1);
  if Number <> 0 then
    Writeln('No. : ', Number);
  TextColor(LightGray);
  Write(Address);
  XDist:= 60 - Length(Address);
  For I:= 1 to XDist do Write(' ');
  Writeln(Phone);
  TextColor(Cyan);
  Writeln; Writeln(Ailment);
  Writeln(Treatment);
  TextColor(LightRed);
  Writeln;
  if Charge <> '' then
    Write('$',Charge);
end;

procedure TPatient.PrintMe;
var
  F: text;
begin
  Assign(F, 'LPT1');
  Rewrite(F);
  Writeln(F);
  Writeln(F);
  Writeln(F, '                          LILLY''S DOCTOR SURGERY');
  Writeln(F, '                          -----------------------');
  Writeln(F);
  Writeln(F);
  Writeln(F, '          Patient Name:   ', Name);
  Write(F, '          Address:   ', Address);
  Writeln(F, '          Phone:   ' ,Phone);
  Writeln(F, '          Ailment:   ', Ailment);
  Writeln(F, '          Treatment:   ',Treatment);
  Writeln(F, '          Cost :   $',Charge);
  Writeln(F);
  Writeln(F, '          Have a nice day!');
  Close(F);
end;

procedure PrintStuff;
begin
  WriteToFile;
  Patient[Counter].PrintMe;
end;

procedure EditStuff;
begin
  Patient[Counter].GetInfo;
  NeedToQueryWriteToFile:= True;
  WriteToFile;
end;

procedure DeleteStuff;
begin
end;

procedure TestKey(Ch: char);
begin
  Case Ch of
    #0:
    begin
      Ch:= ReadKey;
      case Ch of
        #63: EditStuff;
        #83: DeleteStuff;
        #75: Dec(Counter);
        #8: Dec(Counter);
        #72: Dec(Counter);
        #71: Counter:= 1;
        #79: Counter:= MaxCount;
        else Inc(Counter);
      end;
    end;
    'P': PrintStuff;
    'p': PrintStuff;
    else Inc(Counter);
  end;
end;

procedure WriteStuff;
var
  Ch: char;
begin
  Counter:= 1;
  While Ch <> #27 do
  begin
    WriteInfoScreen;
    Patient[Counter].WriteInfo(0);
    Patient[Counter + 1].WriteInfo(1);
    Patient[Counter + 2].WriteInfo(2);
    Ch:= ReadKey;
    if Ch <> #27 then TestKey(Ch);
    if Counter > MaxCount - 1 then Counter:= MaxCount - 1;
    if Counter < 1 then Counter:= 1;
  end;
  Counter:= MaxCount;
end;

procedure MainMenuScreen;
const
  BarFCol = Yellow;
  BarBCol = Red;
  BakCol = Green;
  ForCol = Black;
  ShadoCol = Blue;
var
  CmdMessage: string;
begin
  CmdMessage:= 'Make a choice or press ESCAPE to Quit.';
  Window(1, 1, 80, 25);
  TextBackGround(BarBCol);  TextColor(BarFCol);
  ClrScr;
  GoToXY(40 - Length(DocTitle) div 2, 1);  Write(DocTitle);
  CommandBar('','',CmdMessage,'','','',BarFCol,BarBCol);
  TextBackGround(ShadoCol);
  Window(1, 2, 80, 24);  ClrScr;
  TextColor(ShadoCol);
  TextBackGround(Black);
  Window(12, 6, 72, 21);
  ClrScr;
  TextBackGround(Black);
  ClrScr;
  TextBackGround(BakCol);
  TextColor(BakCol);
  Window(10, 5, 70, 20); ClrScr;
  TextColor(ShadoCol);
  For X:= 10 to 70 do Write(#196);
  GoToXY(1, 3);  For X:= 10 to 70 do Write(#196);
  GoToXY(1, 15); For X:= 10 to 70 do Write(#196);
  TextColor(ForCol);
  GoToXY(26, 2); Write('MAIN MENU');
  GoToXY(19, 6); Write('1.  Enter new records.');
  GoToXY(19, 8); Write('2.  Look at records.');
  GoToXY(19, 10); Write('3.  Quit now.');
end;

procedure MainMenu;
var
  Ch: char;
begin
  MainMenuScreen;
  While (Ch <> '3') and (Ch <> #27) do
  begin
    Ch:= ReadKey;
    case Ch of
      '1': AskStuff;
      '2': WriteStuff;
    end;
    MainMenuScreen;
  end;
end;

procedure CloseUp;
begin
  TextColor(White);
  TextBackGround(Blue);
  Window(1, 1, 80, 25);
  ClrScr;
end;

begin
  ReadFile;
  MainMenu;
  WriteToFile;
  CloseUp;
end.







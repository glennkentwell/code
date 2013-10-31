{
                            GLENN'S MAILING LIST
                           By Glenn Kentwell  12-I
                                Yr 12 IPT
                                Mr Higgins
                             Semester II  1996
                                 12/9/1996
}

program MailingList;
uses Crt;
const
  NameLength = 40;
  StreetLength = 35;
  SuburbLength = 20;
  CityLength = 20;
  StateLength = 5;
  PCodeLength = 6;
  PhoneLength = 12;
  FileName = 'MAILLIST.DAT';

type
  Mail = record
    Name: string[NameLength];
    Street: string[StreetLength];
    Suburb: string[SuburbLength];
    City: string[CityLength];
    State: string[StateLength];
    PostCode: string[PCodeLength];
    Phone: string[PhoneLength];
  end;

var
  Buffer: Mail;
  Person: array[1..100] of ^Mail;
  Ch: char;
  Max,
  Counter: integer;
  NeedToQueryFile,
  ReDrawScreen: Boolean;
  F: file of Mail;

procedure HighLightBar(Length: integer;  Colour, OrigColour: Word);
var
  X: integer;
begin
  TextBackGround(Colour);
  For X:= 1 to Length do
    Write(' ');
  TextBackGround(OrigColour);
end;

procedure GeneralScreen(TopMsg, BotMsg: string;  BarsColour, BarsTextColour,
                                                 BackColour, Colour: Word);
{ This procedure draws the basic structure of all the screens - the top and
   bottom bars with headings and messages, and sets the colours.
}
var
  X: integer;
begin
  TextColor(BarsTextColour);
  TextBackGround(BarsColour);
  Window(1, 1, 80, 25);
  ClrScr;
  X:= 40 - Length(TopMsg) div 2;
  GoToXY(X, 1); Write(TopMsg);
  X:= 40 - Length(BotMsg) div 2;
  GoToXY(X, 25); Write(BotMsg);
  TextColor(Colour);
  TextBackGround(BackColour);
  Window(1, 2, 80, 24);
  ClrScr;
end;

procedure AboutProgram;
{  This is the procedure for Main Menu option 5, and displays information
  about the program
}
begin
  GeneralScreen('ABOUT GLENN''S MAILING LIST', 'Press any key', Red, White, Blue, Yellow);
  TextColor(Blue);
  ClrScr;
  TextColor(Yellow);
  GoToXY(30, 5);  Write('GLENN''S MAILING LIST');
  GoToXY(29, 11);  Write('By Glenn Kentwell  12-I');
  GoToXY(30, 13);  Write('Yr 12 IPT  Mr Higgins');
  GoToXY(32, 15);  Write('Semester II  1996');
  Ch:= ReadKey;
  if KeyPressed then ReadKey;
end;

procedure ReadFromFile;
{  This procedure reads from the data file, and initializes the variables
  (Counter and Max) which are used to control the information.
}
begin
  Counter:= 0;
  NeedToQueryFile:= False;
  Assign(F, FileName);
  Reset(F);
  While not Eof(F) do
  begin
    Read(F, Buffer);
    Inc(Counter);
    GetMem(Person[Counter], SizeOf(Buffer));
    Person[Counter]^:= Buffer;
  end;
  Close(F);
  Max:= Counter;
end;

function QueryWriteToFile: Boolean;
{  This function checks whether the user wants to save the data or not.
}
var Ch: char;
begin
  NeedToQueryFile:= False;
  GeneralScreen('MAIN MENU', 'Press "Y" for Yes, "N" for No', Red, White, Blue, Yellow);
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
  GoToXY(12, 5); Write('Save the mailing list [Y/N]?');
  Ch:= ReadKey;
  if UpCase(Ch) = 'Y' then QueryWriteToFile:= True
    else QueryWriteToFile:= False;
  Window(1, 1, 80, 25);
end;

procedure WriteFile;
{ This procedure writes the data to a file called MAILLIST.DAT
}
begin
  Assign(F, FileName);
  Rewrite(F);
  For Counter:= 1 to Max do
    Write(F, Person[Counter]^);
  Close(F);
  NeedToQueryFile:= False;
end;

procedure WriteToFile;
{ This procedure checks if the data has been changed, and then calls the
  function to see if the user wants to save the changes.  If so, the
  procedure WriteFile is called to write the data to the file.
}
begin
  if NeedToQueryFile then
    if QueryWriteToFile then
      WriteFile;
end;

procedure AddToListScreen;
{  This procedure draws the screen for the data entry.
}
begin
  GeneralScreen('ENTER DATA', 'When finished, leave the "NAME" field blank and press ENTER', Red, White, Blue, Yellow);
  GoToXY(65, 2); Write('Listing : ', Counter);
  GoToXY(8, 5); Write('Name '); HighLightBar(NameLength, LightMagenta, Blue);
  GoToXY(5, 7); Write('Address '); HighLightBar(StreetLength, LightMagenta, Blue);
  GoToXY(50, 7); Write('Suburb '); HighLightBar(SuburbLength, LightMagenta, Blue);
  GoToXY(8, 8); Write('City '); HighLightBar(CityLength, LightMagenta, Blue);
  GoToXY(35, 8); Write('PostCode '); HighLightBar(PCodeLength, LightMagenta, Blue);
  GoToXY(52, 8); Write('State '); HighLightBar(StateLength, LightMagenta, Blue);
  GoToXY(3, 10); Write('Phone No. '); HighLightBar(PhoneLength, LightMagenta, LightMagenta);
  TextColor(LightGray);
end;

procedure AddToList;
{  This is the data entry procedure
}
begin
  Inc(Counter);
  AddToListScreen;
  GoToXY(13, 5); ReadLn(Buffer.Name);
  While Buffer.Name <> '' do
  begin
    GoToXY(13, 7); ReadLn(Buffer.Street);
    GoToXY(57, 7); ReadLn(Buffer.Suburb);
    GoToXY(13, 8); ReadLn(Buffer.City);
    GoToXY(44, 8); ReadLn(Buffer.PostCode);
    GoToXY(58, 8); ReadLn(Buffer.State);
    GoToXY(13, 10); ReadLn(Buffer.Phone);
    GetMem(Person[Counter], SizeOf(Buffer));
    Person[Counter]^:= Buffer;
    Inc(Counter);
    AddToListScreen;
    GoToXY(13, 5); ReadLn(Buffer.Name);
  end;
  Dec(Counter);
  Max:= Counter;
  NeedToQueryFile:= True;
end;

procedure EditList(Count: integer);
{  This is the procedure which controls data editing.  The variable Count is
  used to tell the procedure which data item to edit.
}
var
  StorCounter: integer;
  SecondBuf: Mail;
begin
  StorCounter:= Counter;
  Counter:= Count;
  AddToListScreen;
  SecondBuf:= Person[Count]^;
  GoToXY(13, 7); Write(Person[Count]^.Street);
  GoToXY(57, 7); Write(Person[Count]^.Suburb);
  GoToXY(13, 8); Write(Person[Count]^.City);
  GoToXY(44, 8); Write(Person[Count]^.PostCode);
  GoToXY(58, 8); Write(Person[Count]^.State);
  GoToXY(13, 10); Write(Person[Count]^.Phone);
  GoToXY(13, 5); Write(Person[Count]^.Name);
  GoToXY(13, 5); ReadLn(Buffer.Name);
  GoToXY(13, 7); ReadLn(Buffer.Street);
  GoToXY(57, 7); ReadLn(Buffer.Suburb);
  GoToXY(13, 8); ReadLn(Buffer.City);
  GoToXY(44, 8); ReadLn(Buffer.PostCode);
  GoToXY(58, 8); ReadLn(Buffer.State);
  GoToXY(13, 10); ReadLn(Buffer.Phone);
  if Buffer.Name <> '' then SecondBuf.Name:= Buffer.Name
    else SecondBuf.Name:= Person[Count]^.Name;
  if Buffer.Street <> '' then SecondBuf.Street:= Buffer.Street
    else SecondBuf.Street:= Person[Count]^.Street;
  if Buffer.Suburb <> '' then SecondBuf.Suburb:= Buffer.Suburb
    else SecondBuf.Suburb:= Person[Count]^.Suburb;
  if Buffer.City <> '' then SecondBuf.City:= Buffer.City
    else SecondBuf.City:= Person[Count]^.City;
  if Buffer.State <> '' then SecondBuf.State:= Buffer.State
    else SecondBuf.State:= Person[Count]^.State;
  if Buffer.PostCode <> '' then SecondBuf.PostCode:= Buffer.PostCode
    else SecondBuf.PostCode:= Person[Count]^.PostCode;
  if Buffer.Phone <> '' then SecondBuf.Phone:= Buffer.Phone
    else SecondBuf.Phone:= Person[Count]^.Phone;
  GetMem(Person[Count], SizeOf(SecondBuf));
  Person[Count]^:= SecondBuf;
  NeedToQueryFile:= True;
  Counter:= StorCounter;
end;

procedure Print(PrnFile: string; Numb, NumToPrint: integer);
{  This procedure sends the data to the printer.
  When this procedure is called from the Main Menu, NumToPrint = Max, which
  means that all the data records are printed.  If the procedure is called
  when the user is viewing data, the top-most record is printed only.
}
var
  PF: text;
  I,
  Number, Num: integer;
  WriteNothing: Boolean;
begin
  Assign(PF, PrnFile);
  Rewrite(PF);
    Writeln(PF, '                                  M A I L I N G  L I S T');
    Writeln(PF, '                                  ----------------------');
    For Number:= Numb to Numb + (NumToPrint - 1) do
    begin
      WriteNothing:= False;
      if Number > Max then WriteNothing:= True;
      if not WriteNothing then
      begin
        For Num:= 1 to 2 do Writeln(PF);
        Writeln(PF, Person[Number]^.Name);
        Writeln(PF, Person[Number]^.Street);
        Writeln(PF, Person[Number]^.Suburb, ', ',Person[Number]^.City);
        Writeln(PF, Person[Number]^.State,'  ', Person[Number]^.Postcode);
        Writeln(PF, Person[Number]^.Phone);
      end;
    end;
  Close(PF);
end;

procedure PrintOptions(Numb, NumToPrint: integer);
{  This procedure asks the user which LPT port to print to, and then calls
  Print.
}
var
  PrnStr: string[4];
begin
  GeneralScreen('PRINT MENU', 'Press ESCAPE to cancel printing', Red, White, Blue, Yellow);
  Window(17, 8, 67, 16);
  TextBackGround(DarkGray);
  ClrScr;
  Window(15, 7, 65, 15);
  TextColor(LightGray);
  TextBackGround(LightGray);
  ClrScr;
  TextColor(Blue);
  GoToXY(17, 2); Write('HEY WAIT A MINUTE!');
  TextColor(Red);
  GoToXY(10, 4); Write('Which printer port to print to?');
  TextColor(LightGreen);
  GoToXY(20, 6); Write('1.  LPT 1');
  GoToXY(20, 7); Write('2.  LPT 2');
  Repeat
    Ch:= ReadKey;
    Case Ch of
      '1': PrnStr:= 'LPT1';
      '2': PrnStr:= 'LPT2';
    end;
  Until (Ch = #27) or (Ch = '1') or (Ch = '2');
  if Ch <> #27 then
  begin
    TextColor(LightGray);
    ClrScr;
    TextColor(Yellow);
    GoToXY(10, 4); Writeln('Press any key to print');
    GoToXY(22, 6); Write(' or ESCAPE to cancel');
    Ch:= ReadKey;
    if Ch <> #27 then
      Print(PrnStr, Numb, NumToPrint);
  end;
end;

function ConfirmDelete(Number: integer): Boolean;
{  When the user decides to delete a record, this function asks if the user
  is sure, and waits for a Y or N key press.
}
begin
  Window(17, 8, 67, 16);
  TextBackGround(DarkGray);
  ClrScr;
  Window(15, 7, 65, 15);
  TextColor(LightGray);
  TextBackGround(LightGray);
  ClrScr;
  TextColor(Blue);
  GoToXY(17, 2); Write('HEY WAIT A MINUTE!');
  TextColor(Red);
  GoToXY(10, 4); Write('Are you sure you want to delete');
  TextColor(Yellow);
  GoToXY(23 - Length(Person[Number]^.Name) div 2, 5); Write(Person[Number]^.Name);
  TextColor(Red);
  Write(' [Y/N] ?');
  Repeat
    Ch:= ReadKey;
  Until (UpCase(Ch) = 'Y') or (UpCase(Ch) = 'N');
  Case UpCase(Ch) of
    'Y': ConfirmDelete:= True;
    'N': ConfirmDelete:= False;
  end;
end;

procedure Delete(Number: integer);
{  When the user presses delete, this procedure is called.  If ConfirmDelete
  is True, the record is deleted, otherwise nothing happens.
}
var
  Buf: integer;
begin
  if Max > 0 then
  begin
    if ConfirmDelete(Number) then
    begin
      For Buf:= Number to Max - 1 do
        Person[Buf]^:= Person[Buf + 1]^;
      Dec(Max);
      NeedToQueryFile:= True;
    end;
  end;
  Counter:= Max;
end;

procedure ViewListScreen;
{  This procedure draws the screen for Menu option 2, View Data
}
var
  I, X, Y: integer;
begin
  GeneralScreen('VIEW MAILING LIST', 'Top Item - F5 to Edit   "P" to Print   DEL to Delete    ESC - Main Menu',
                Red, White, Blue, Yellow);
  TextColor(Black);
  GoToXY(1, 8);
  For I:= 1 to 80 do
    Write(#196);
  GoToXY(1, 16);
  For I:= 1 to 80 do
    Write(#196);
  X:= 65;
  For Y:= 1 to 23 do
  begin
    GoToXY(X, Y);
    Write(#179);
  end;
  GoToXY(X, 8); Write(#197);
  GoToXY(X, 16); Write(#197);
  TextColor(White);
end;

procedure ViewList;
{  This procedure allows the user to view data they have entered, and choose
  to edit, delete or print the records individually.
}
var
  Num,
  Number: integer;
  WriteNothing: Boolean;
begin
  Ch:= #0;
  Number:= 1;
  WriteNothing:= False;
  While Ch <> #27 do
  begin
    ViewListScreen;
    if Number > Max then Number:= Max;
    if Number < 1 then Number:= 1;
    For Num:= 0 to 2 do
    begin
      if Number + Num > Max then WriteNothing:= True;
      if not WriteNothing then
      begin
        GoToXY(1, (Num * 8) + 1);
        TextColor(Yellow);
        Write(Person[Number + Num]^.Name);
        TextColor(Cyan);
        GoToXY(67, (Num * 8) + 1);
        Writeln(Number + Num,' of ', Max);
        TextColor(Green);
        GoToXY(1, (Num * 8) + 2);
        Writeln(Person[Number + Num]^.Street,'   ',Person[Number + Num]^.Suburb);
        Writeln(Person[Number + Num]^.City,' ', Person[Number + Num]^.State);
        Writeln(Person[Number + Num]^.Postcode);
        Writeln;
        TextColor(LightRed);
        Writeln(Person[Number + Num]^.Phone);
      end;
    end;
    WriteNothing:= False;
    Ch:= ReadKey;
    if Ch <> #27 then
    Case Ch of
      #0:
      begin
        Ch:= ReadKey;
        case Ch of
          #75: Dec(Number);
          #8: Dec(Number);
          #72: Dec(Number);
          #71: Number:= 1;
          #79: Number:= Max;
          #63: EditList(Number);
          #83:
          begin
            Delete(Number);
            ViewListScreen;
          end;
          else Inc(Number);
        end;
      end;
      'P': PrintOptions(Number, 1);
      'p': PrintOptions(Number, 1);
      else Inc(Number);
    end;
  end;
end;

procedure MainMenuScreen(BarCol, BarTextCol, BackCol, TextCol, MenuBkCol, MenuTextCol, MenuHighCol: Word);
{  MainMenuScreen draws the screen for the Main Menu.
}
var
  X: integer;
begin
  GeneralScreen('MAIN MENU', 'Make a choice, or press ESCAPE to Quit', BarCol, BarTextCol, BackCol, TextCol);
  TextBackGround(Black);
  Window(17, 8, 67, 21);
  ClrScr;
  TextColor(MenuHighCol);
  TextBackGround(MenuBkCol);
  Window(15, 7, 65, 20);
  ClrScr;
  For X:= 1 to 51 do
    Write(#223);
  TextColor(MenuTextCol);
  GoToXY(15, 3); Write('1.  Add To List');
  GoToXY(15, 5); Write('2.  View and Edit List');
  GoToXY(15, 7); Write('3.  Print List');
  GoToXY(15, 9); Write('4.  Save List');
  GoToXY(15, 11); Write('5.  About This Program');
end;

procedure SaveMessage;
{  When the user chooses Menu option 4. Save List, SaveMessage draws a small
  box on the screen with a message SAVING, then waits for about half a second
  before erasing it.  This is so that the user knows the data has been saved.
  Otherwise, there is no way of knowing that the program has responded.
}
begin
  Window(27, 12, 57, 17);
  TextBackGround(DarkGray);
  ClrScr;
  Window(25, 11, 55, 16);
  TextColor(LightGray);
  TextBackGround(LightGray);
  ClrScr;
  TextColor(Blue);
  GoToXY(13, 2); Write('SAVING');
  TextColor(Red);
  GoToXY(10, 4); Write('Just a sec...');
  Delay(500);
end;

procedure MainMenu;
{  The user selects an option by pressing the appropriate number, then
  MainMenu calls the corresponding procedure.  When that procedure has ended,
  the user makes another selection from the Main Menu.
}
begin
  MainMenuScreen(Red, White, Blue, Yellow, Green, Black, Green);
  Ch:= ReadKey;
  While Ch <> #27 do
  begin
    ReDrawScreen:= True;
    Case Ch of
      '1': AddToList;
      '2': ViewList;
      '3': PrintOptions(1, Max);
      '4':
      begin
        SaveMessage;
        WriteFile;
      end;
      '5': AboutProgram;
      else ReDrawScreen:= False;
    end;
    if ReDrawScreen then MainMenuScreen(Red, White, Blue, Yellow, Green, Black, Green);
    Ch:= ReadKey;
  end;
end;

procedure FadeMsgIn(X, Y: integer; Message: string; EndColour: word);
{  This writes Message on the screen at X, Y in dark grey, then the darker
  shade of EndColour, and then in EndColour.  The text effectively "fades in"
  on the screen.
}
const
  Dela = 300;
begin
  TextColor(DarkGray);
  GoToXY(X, Y);  Write(Message);
  Delay(Dela);
  TextColor(EndColour);
  LowVideo;
  GoToXY(X, Y);  Write(Message);
  Delay(Dela);
  HighVideo;
  GoToXY(X, Y);  Write(Message);
end;

procedure IntroScreen;
{  IntroScreen draws the introduction screen, and then waits for a keypress
  before MainMenu is called by the main program block.
}
var
  Colr: shortint;
begin
  TextColor(Black);
  TextBackGround(Black);
  Window(1, 1, 80, 25);
  ClrScr;
  FadeMsgIn(30, 5, 'GLENN''S MAILING LIST', Cyan);
  FadeMsgIn(29, 11, 'By Glenn Kentwell  12-I', Blue);
  FadeMsgIn(30, 13, 'Yr 12 IPT  Mr Higgins', Yellow);
  FadeMsgIn(32, 15, 'Semester II  1996', Red);
  FadeMsgIn(65, 24, 'Press a key...', Green);
  Ch:= ReadKey;
  if KeyPressed then ReadKey;
end;

procedure CleanUp;
{  CleanUp clears the screen so that when the user returns to DOS, the screen
  is empty.
}
begin
  Window(1, 1, 80, 25);
  TextColor(White);
  TextBackGround(Black);
  ClrScr;
end;

begin
  ReadFromFile;  { Get data from the file, MAILLIST.DAT }
  IntroScreen;   { Do the introduction screen. }
  MainMenu;      { Main Menu }
  WriteToFile;   { Write the data to MAILLIST.DAT if necessary }
  CleanUp;       { Clear the screen }
end.
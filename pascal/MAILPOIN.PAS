program MailingList;
uses Crt;
const
  NameLength = 40;
  StreetLength = 35;
  SuburbLength = 20;
  CityLength = 20;
  StateLength = 20;
  PCodeLength = 6;
  PhoneLength = 10;

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
  Person: array[1..100] of ^Mail;
  Buffer: Mail;
  ReDrawScreen: Boolean;
  Counter: integer;
  Ch: char;

procedure HighLightBar(Length: integer;  Colour, OrigColour: Word);
var
  X: integer;
begin
  TextBackGround(Colour);
  For X:= 1 to Length do
    Write(' ');
  TextBackGround(OrigColour);
end;

procedure GeneralScreen(TopMsg, BotMsg: string;  BarsColour, BarsTextColour, BackColour, Colour: Word);
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

procedure AddToListScreen;
begin
  GeneralScreen('ENTER DATA', 'When finished, leave the "NAME" field blank and press ENTER', Red, White, Blue, Yellow);
  GoToXY(60, 2); Write('Listing No. : ', Counter);
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
begin
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
    Inc(Counter);
    GetMem(Person[Counter], SizeOf(Buffer));
    Person[Counter]^:= Buffer;
    AddToListScreen;
    GoToXY(13, 5); ReadLn(Buffer.Name);
  end;
end;

procedure ViewList;
begin
  GeneralScreen('VIEW MAILING LIST', 'Press F5 to Edit top item or ESC for Main Menu', Red, White, Blue, Yellow);
  Ch:= ReadKey;
end;

procedure Print;
begin
end;

procedure MainMenuScreen(BarCol, BarTextCol, BackCol, TextCol, MenuBkCol, MenuTextCol, MenuHighCol: Word);
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
  GoToXY(16, 4); Write('1.  Add To List');
  GoToXY(16, 6); Write('2.  View and Edit List');
  GoToXY(16, 8); Write('3.  Print List');
  GoToXY(16, 10); Write('4.  Quit');
end;

procedure MainMenu;
begin
  MainMenuScreen(Red, White, Blue, Yellow, Green, Black, Green);
  Ch:= ReadKey;
  While (Ch <> #27) and (Ch <> '4') do
  begin
    ReDrawScreen:= True;
    Case Ch of
      '1': AddToList;
      '2': ViewList;
      '3': Print;
      else ReDrawScreen:= False;
    end;
    if ReDrawScreen then MainMenuScreen(Red, White, Blue, Yellow, Green, Black, Green);
    Ch:= ReadKey;
  end;
end;

procedure IntroScreen;
begin
  TextColor(Black);
  TextBackGround(Black);
  Window(1, 1, 80, 25);
  ClrScr;
  TextColor(LightGray);
  GoToXY(30, 12); Write('Glenn''s Mailing List');
  Ch:= ReadKey;
end;

procedure CleanUp;
begin
  Window(1, 1, 80, 25);
  TextColor(White);
  TextBackGround(Black);
  ClrScr;
end;

begin
  IntroScreen;
  MainMenu;
  CleanUp;
end.
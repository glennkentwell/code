program Entry;
uses
  Crt, Dos, Graph,
  BGIFont, BGIDriv,
  GrafBits;

const
  days : array [0..6] of String[9] =
    ('Sunday','Monday','Tuesday',
     'Wednesday','Thursday','Friday',
     'Saturday');

type
  WhichLetters = (All, One);

var
  LogFile: text;
  FirstName, LastName: string[30];
  FileInfo: SearchRec;
  Year, Month, Day, DOW,
  Hour, Min, Sec, Hund : Word;

procedure Abort(Msg : string);
begin
  Writeln(Msg, ': ', GraphErrorMsg(GraphResult));
  Halt(1);
end;

procedure Reg;
begin
  { Register all the drivers }
  if RegisterBGIdriver(@HercDriverProc) < 0 then
    Abort('Herc');
  if RegisterBGIdriver(@ATTDriverProc) < 0 then
    Abort('AT&T');
  if RegisterBGIdriver(@PC3270DriverProc) < 0 then
    Abort('PC 3270');
  if RegisterBGIdriver(@EGAVGADriverProc) < 0 then
    Abort('EGA/VGA');

  { Register all the fonts }
  if RegisterBGIfont(@GothicFontProc) < 0 then
    Abort('Gothic');
  if RegisterBGIfont(@SansSerifFontProc) < 0 then
    Abort('SansSerif');
  if RegisterBGIfont(@SmallFontProc) < 0 then
    Abort('Small');
  if RegisterBGIfont(@TriplexFontProc) < 0 then
    Abort('Triplex');
end;

function LeadingZero(W : Word) : String;
var
  s : String;
begin
  Str(W:0,S);
  if Length(S) = 1 then
    S := '0' + s;
  LeadingZero := s;
end;

function MakeCapitals(S: string; AllOrOne: WhichLetters): string;
var
  X: integer;
begin
  if AllOrOne = One then S[1]:= UpCase(S[1]);
  if AllOrOne = All then
    For X:= 1 to Length(S) do
      S[X]:= UpCase(S[X]);
  MakeCapitals:= S;
end;

procedure FindUserName;
const
  Greeting = 'LOG IN AND STUFF';
var
  Name: string;
begin
  TextBackGround(Red);
  ClrScr;
  TextBackGround(Black);
  Window(8, 8, 68, 16);
  ClrScr;
  TextColor(Yellow);
  TextBackGround(Blue);
  Window(10, 7, 70, 15);
  ClrScr;
  GoToXY(30 - (Length(Greeting) div 2), 1); Write(Greeting);
  GoToXY(5, 4); Write('What is your first name? ');
  GoToXY(6, 6); Write('What is your last name? ');
  TextColor(Cyan);
  GoToXY(31, 4); Readln(FirstName);
  GoToXY(31, 6); Readln(LastName);
  if FirstName = '' then FirstName:= 'Glenn'
  else FirstName:= MakeCapitals(FirstName, One);
  if LastName = '' then LastName:= 'Kentwell'
  else LastName:= MakeCapitals(LastName, All);
end;

procedure FindPointInTime;
begin
  GetDate(Year, Month, Day, DOW);
  GetTime(Hour, Min, Sec, HUND);
end;

procedure FileStuff;
begin
  Assign(LogFile, 'C:\LOG.TXT');
  ChDir('C:\');
  FindFirst('LOG.TXT', Archive, FileInfo);
  if DosError <> 0 then
    ReWrite(LogFile)
    else Append(LogFile);
  Write(LogFile, LastName, ', ', FirstName, '  ');
  Write(LogFile, LeadingZero(Day), '/', LeadingZero(Month), '/', LeadingZero(Year),'  ');
  Writeln(LogFile, LeadingZero(Hour),':', LeadingZero(Min),
                                     ':', LeadingZero(Sec),
                                     '.', LeadingZero(Hund));
  Close(LogFile);
end;

procedure FillScreenWithName;
begin
  GraphicsScreen;
  Randomize;
  While not KeyPressed do
  begin
    SetTextStyle(Random(5) + 1, 0, Random(5) + 1);
    SetColor(Random(15 + 1));
    SetUserCharSize(5, Random(10), 5, Random(10));
    MoveTo(Random(MaxX), Random(MaxY));
    OutText('G''day ' + FirstName);
  end;
  CloseGraph;
  While KeyPressed do ReadKey;
end;

procedure BounceNameOnScreen;
var
  XDir, YDir,
  X, Y: integer;
begin
  GraphicsScreen;
  X:= 1;
  Y:= 1;
  XDir:= 3;
  YDir:= 3;
  While not KeyPressed do
  begin
    SetColor(Random(15));
    SetTextStyle(Random(5) + 1, 0, Random(5) + 1);
    OutTextXY(X, Y, 'G''day ' + FirstName);
    Inc(X, XDir);
    Inc(Y, YDir);
    if X > MaxX - TextWidth('G''day ' + FirstName) then XDir:= -3;
    if Y > MaxY - TextHeight('G''day ' + FirstName) then YDir:= -3;
    if X < 1 then XDir:= 3;
    if Y < 1 then YDir:= 3;
  end;
  CloseGraph;
  While KeyPressed do ReadKey;
end;

procedure FadeIt;
var
  RGB, Hue: shortint;
begin
  Hue:= Random(3);
  Case Hue of
    0:  { Red }
    begin
      For RGB:= 0 to 63 do
        if not KeyPressed then
        SetRGBPalette(1, RGB, 0, 0);
      For RGB:= 63 downto 0 do
        if not KeyPressed then
        SetRGBPalette(1, RGB, 0, 0);
    end;
    1:  { Green }
    begin
      For RGB:= 0 to 63 do
        if not KeyPressed then
        SetRGBPalette(1, 0, RGB, 0);
      For RGB:= 63 downto 0 do
        if not KeyPressed then
        SetRGBPalette(1, 0, RGB, 0);
    end;
    2:  { Blue }
    begin
      For RGB:= 0 to 63 do
        if not KeyPressed then
        SetRGBPalette(1, 0, 0, RGB);
      For RGB:= 63 downto 0 do
        if not KeyPressed then
        SetRGBPalette(1, 0, 0, RGB);
    end;
  end;
end;

procedure FadeName;
begin
  GraphicsScreen;
  SetColor(1);
  SetRGBPalette(1, 0, 0, 0);
  While not KeyPressed do
  begin
    SetTextStyle(Random(5) + 1, 0, Random(5) + 1);
    OutTextXY(Random(MaxX), Random(MaxY), 'G''day ' + FirstName);
    FadeIt;
    ClearDevice;
  end;
  CloseGraph;
  While KeyPressed do ReadKey;
end;

procedure DoNameGraphics;
var
  X: integer;
begin
  Randomize;
  X:= Random(3) + 1;
  Case X of
    1: FillScreenWithName;
    2: BounceNameOnScreen;
    3: FadeName;
  end;
end;

begin
  Reg;
  FindPointInTime;
  FindUserName;
  FileStuff;
  DoNameGraphics;
end.

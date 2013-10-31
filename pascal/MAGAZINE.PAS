program MagazineList;
uses
  Crt, Strings,
  Buttons, Cursor, MagScrn, ScrnWrit;
const
  NumArticles = 1000;
  NumKeys = 10;

const
  T = 'Article Title: ';  Tl = 15;
  E = 'Edition: ';        El = 9;
  M = 'Magazine: ';       Ml = 10;
  P = 'Page No: ';        Pl = 9;
  K = 'Keyword';          Kl = 12;
  Xx = 18;
  Ty = 5;  My = Ty + 2;
  Ey = My + 2;   Py = Ey + 2;  Ky = Py + 2;

type
  NumWord = (Uno, Duo, Tre, Quad, Tetra);
  SearchStr = array[0..20] of char;
  WordArray = array[1..NumKeys] of string[20];
  ArticleNumber = array[1..NumArticles] of integer;
  TMagazine = object
    Title: string[60];
    Page: integer;
    Keywords: WordArray;
    MagEdition, MagName: string[30];
    procedure ReadFile;
    procedure WriteFile;
    procedure GetInfoScreen;
    function GetInfo: Boolean;
    procedure ShowInfoScreen;
    procedure ShowInfo(Number: NumWord);
    procedure EditInfo;
    function SearchMe(Search: SearchStr): Boolean;
  end;

var
  F: text;
  Ch: char;
  ShowedInfo, NeedToSave: Boolean;
  Max, Num, Counter: integer;
  TestArticle, BufArticle: TMagazine;
  Article: array[1..NumArticles] of ^TMagazine;
  PreTitle, PreMag, PreEdition, PrePage: string[60];

procedure TMagazine.GetInfoScreen;
var
  X: integer;
begin
  GeneralScreen(White, Red, Yellow, Blue, 'Article Database', 'Type in your stuff.');
  GoToXY(60, 2); Write('Article No : ');
  TextColor(LightGray);  Write(Counter);
  TextColor(Yellow);
  GoToXY(Xx - Tl, Ty);  Write(T);
  HighLightBar(60, Magenta, Blue);
  GoToXY(Xx - Ml, My);  Write(M);
  HighLightBar(30, Magenta, Blue);
  GoToXY(Xx - El, Ey);  Write(E);
  HighLightBar(30, Magenta, Blue);
  GoToXY(Xx - Pl, Py);  Write(P);
  HighLightBar(5, Magenta, Blue);
  X:= 0;
  GoToXY(Xx - Kl, Ky + X);  Write(K, X + 1:3, ': ');
  HighLightBar(20, Magenta, Blue);
  For X:= 1 to 9 do
    begin
      GoToXY(Xx - 5, Ky + X);  Write(X + 1:3, ': ');
      HighLightBar(20, Magenta, Blue);
    end;
end;

function TMagazine.GetInfo;
var
  X: integer;
  Pagestr: string;
begin
  NormCursor;
  GetInfoScreen;
  GetInfo:= True;
  NeedToSave:= True;
  For X:= 1 to NumKeys do KeyWords[X]:= '';
  X:= 1;
  TextColor(Cyan);
  TextBackGround(Magenta);
  GoToXY(Xx, Ty);
  Title:= Reatln(60);
  if ReatlnChar = Up then
  begin
    Title:= PreTitle;
    GoToXY(Xx, Ty);
    Write(Title);
  end;
  PreTitle:= Title;
  if ReatlnChar <> Esc then
  begin
    GoToXY(Xx, My);
    MagName:= Reatln(30);
    if ReatlnChar = Up then
    begin
      MagName:= PreMag;
      GoToXY(Xx, My);
      Write(MagName);
    end;
  end;
  PreMag:= MagName;
  if ReatlnChar <> Esc then
  begin
    GoToXY(Xx, Ey);
    MagEdition:= Reatln(30);
    if ReatlnChar = Up then
    begin
      MagEdition:= PreEdition;
      GoToXY(Xx, Ey);
      Write(MagEdition);
    end;
  end;
  PreEdition:= MagEdition;
  if ReatlnChar <> Esc then
  begin
    GoToXY(Xx, Py);
    PageStr:= Reatln(5);
    if ReatlnChar = Up then
    begin
      PageStr:= PrePage;
      GoToXY(Xx, Py);
      Write(PageStr);
    end;
  end;
  PrePage:= PageStr;
  GoToXY(Xx, Ky);
  if ReatlnChar <> Esc then
    KeyWords[X]:= Reatln(20);
  if ReatlnChar <> Esc then
  While (KeyWords[X] <> '') and (X < 10) do
    begin
      Inc(X);
      GoToXY(Xx, Ky + (X - 1));
      KeyWords[X]:= Reatln(20);
    end;
  Val(Pagestr, Page, X);
  if ReatlnChar = Esc then GetInfo:= False;
end;

procedure TMagazine.ShowInfoScreen;
begin
  GeneralScreen(White, Red, Yellow, Blue, 'Article Database', '');
  NoCursor;
  GoToXY(1, 8); Line(Black);
  GoToXY(1, 16); Line(Black);
  Window(1, 25, 80, 25);
  TextBackGround(Red);  ClrScr;
  TextColor(White);  Write('KEYS :');
  TextColor(LightGray);  Write(' Arrows to scroll articles     Press ');
  TextColor(White);  Write('F5 ');
  TextColor(LightGray);  Write('to edit top article');
  TextBackGround(Blue);
  ShowedInfo:= True;
end;

procedure TMagazine.ShowInfo;
var
  X: integer;
begin
  if not ShowedInfo then ShowInfoScreen;
  TextBackGround(Blue);
  if Number = Uno then Window1;
  if Number = Duo then Window2;
  if Number = Tre then Window3;
  if Number = Quad then Window2;
  if Number = Tetra then Window3;
  if (Number <> Quad) and (Number <> Tetra) then
  begin
    TextColor(LightGray);
    GoToXY(1, 1); Write('Article Title :                                    ');
    GoToXY(1, 3); Write('Magazine :                                         ');
    GoToXY(1, 4); Write('Edition :                                          ');
    GoToXY(41, 4); Write('Page :                                            ');
    TextColor(Yellow);
    GoToXY(18, 1);  Writeln(Title);
    GoToXY(18, 3);  Writeln(MagName);
    GoToXY(18, 4);  Writeln(MagEdition);
    GoToXY(48, 4);  Writeln(Page);
    GoToXY(1, 6);
    For X:= 1 to 159 do Write(' ');
      TextColor(LightRed);
    For X:= 1 to 5 do
    begin
      GoToXY((X * 13) - 12, 6);
      Write(KeyWords[X]);
    end;
    For X:= 1 to 5 do
    begin
      GoToXY((X * 13) - 12, 7);
      Write(KeyWords[X + 5]);
    end;
  end
  else ClrScr;
end;

function TMagazine.SearchMe;
var
  X, Y: integer;
  KWord: SearchStr;
  TestWord, SearchWord: string[20];
begin
  SearchMe:= False;
  For X:= 1 to 10 do
  begin
    StrPCopy(KWord, KeyWords[X]);
    TestWord:= StrPas(StrUpper(KWord));
    SearchWord:= StrPas(StrUpper(Search));
    if SearchWord = TestWord then
      SearchMe:= True;
  end;
end;

procedure TMagazine.EditInfo;
var
  X: integer;
  S: string;
begin
  NormCursor;
  GetInfoScreen;
  NeedToSave:= True;
  X:= 1;
  TextColor(Cyan);
  TextBackGround(Magenta);
  GoToXY(Xx, Ty);  Write(Title);
  GoToXY(Xx, My);  Write(MagName);
  GoToXY(Xx, Ey);  Write(MagEdition);
  GoToXY(Xx, Py);  Write(Page);
  X:= 0;
  While X < 10 do
    begin
      Inc(X);
      GoToXY(Xx, Ky + (X - 1));
      Write(KeyWords[X]);
    end;
  GoToXY(Xx, Ty);  S:= Reatln(60);
  if S <> '' then Title:= S;
  GoToXY(Xx, My);
  if ReatlnChar <> Esc then
    S:= Reatln(30);
  if S <> '' then MagName:= S;
  GoToXY(Xx, Ey);
  if ReatlnChar <> Esc then
    S:= Reatln(30);
  if S <> '' then MagEdition:= S;
  GoToXY(Xx, Py);
  if ReatlnChar <> Esc then
    S:= Reatln(5);
  if S <> '' then Val(S, Page, X);
  X:= 1;
  GoToXY(Xx, Ky);
  if ReatlnChar <> Esc then
    S:= Reatln(20);
  if S <> '' then KeyWords[X]:= S;
  if ReatlnChar <> Esc then
  While X < 10 do
  if ReatlnChar <> Esc then
    begin
      Inc(X);
      GoToXY(Xx, Ky + (X - 1));
      S:= Reatln(20);
      if S <> '' then KeyWords[X]:= S;
    end;
  Key.Key:= Null;
end;

procedure TMagazine.ReadFile;
var
  X: integer;
begin
  ReadLn(F, Title);
  Readln(F, MagName);
  Readln(F, MagEdition);
  Readln(F, Page);
  For X:= 1 to 10 do
    Readln(F, KeyWords[X]);
end;

procedure TMagazine.WriteFile;
var
  X: integer;
begin
  WriteLn(F, Title);
  Writeln(F, MagName);
  Writeln(F, MagEdition);
  Writeln(F, Page);
  For X:= 1 to 10 do
    Writeln(F, KeyWords[X]);
end;

procedure MenuScreen;
const
  Left = 19;
  Top = 3;
begin
  GeneralScreen(White, Red, Yellow, Blue, 'Article Database', 'Main Menu');
  NoCursor;
  TextColor(Green);
  GoToXY(25, 21); Write('Press the number of your selection');
  GoToXY(25, 22); Write('       or Escape to exit');
  Window(12, 8, 72, 19);
  TextBackGround(DarkGray);
  ClrSCr;
  Window(10, 7, 70, 18);
  TextColor(Red);
  TextBackGround(Cyan);
  ClrScr;
  GoToXY(Left, Top);
  Write('1.'); TextColor(Yellow); Write('  Enter new articles');
  TextColor(Red);
  GoToXY(Left, Top + 2);
  Write('2.'); TextColor(Yellow); Write('  Show all articles');
  TextColor(Red);
  GoToXY(Left, Top + 4);
  Write('3.'); TextColor(Yellow); Write('  Perform a search');
  TextColor(Red);
  GoToXY(Left, Top + 6);
  Write('4.'); TextColor(Yellow); Write('  Save all articles');
end;

procedure GetArticles;
begin
  Counter:= Max;
  Inc(Counter);
  Inc(Max);
  While BufArticle.GetInfo do
  begin
    GetMem(Article[Counter], SizeOf(BufArticle));
    Article[Counter]^:= BufArticle;
    Inc(Counter);
    Inc(Max);
  end;
  ReatlnChar[1]:= #0;
  ReatlnChar[2]:= #0;
  Dec(Max);
  Key.Key:= Null;
end;

procedure ShowArticles;
begin
  Counter:= 1;
  ShowedInfo:= False;
  Repeat
    Article[Counter]^.ShowInfo(Uno);
    if Counter + 1 <= Max then
      Article[Counter + 1]^.ShowInfo(Duo);
    if Counter + 2 <= Max then
      Article[Counter + 2]^.ShowInfo(Tre);
    if Counter + 1 = Max then
      Article[Counter + 2]^.ShowInfo(Tetra);
    if Counter + 1 = Max + 1 then
      Article[Counter + 2]^.ShowInfo(Quad);
    Key.GetKeys;
    if Key.Key = Down then
      if Counter < Max then Inc(Counter);
    if Key.Key = Up then
      if Counter > 1 then Dec(Counter);
    if Key.Key = Home then Counter:= 1;
    if Key.Key = _End then Counter:= Max - 2;
    if Key.Key = F5 then Article[Counter]^.EditInfo;
  Until Key.Key = Esc;
  NormCursor;
  Key.Key:= Null;
  ShowedInfo:= False;
end;

procedure SearchScreen;
var
  X: integer;
begin
  GeneralScreen(White, Red, Yellow, Blue, 'Article Search', '');
  Window(1, 1, 80, 25);
  TextColor(LightGray);
  TextBackGround(Red);
  GoToXY(1, 25);
  HighVideo;
  Write('   F6 ');
  LowVideo;
  Write('- begin another search');
  TextColor(Black);
  TextBackGround(Black);
  Frame(12, 11, 72, 17, 4, '');
  ClrScr;
  TextColor(LightGray);
  TextBackGround(Blue);
  Frame(10, 10, 70, 16, 1, '');
  ClrScr;
  TextColor(Yellow);
  GoToXY(13, 2);  Write('Type a keyword to search for:');
  GoToXY(18, 4);  HighLightBar(20, Magenta, Magenta);
  TextColor(LightGray);
  GoToXY(18, 4);
  NormCursor;
end;

procedure DisplaySearchResults(ArtNum: integer; ArticleNum: ArticleNumber);
var
  Count: integer;
begin
  ShowedInfo:= False;
  Repeat
    Article[ArticleNum[Count]]^.ShowInfo(Uno);
    if Count + 1 <= ArtNum then
      Article[ArticleNum[Count + 1]]^.ShowInfo(Duo);
    if Count + 2 <= ArtNum then
      Article[ArticleNum[Count + 2]]^.ShowInfo(Tre);
    if Count + 1 = ArtNum then
      Article[ArticleNum[Count + 2]]^.ShowInfo(Tetra);
    if Count + 1 = ArtNum + 1 then
      Article[ArticleNum[Count + 2]]^.ShowInfo(Quad);
    Key.GetKeys;
    if Key.Key = Down then
      if Count < ArtNum then Inc(Count);
    if Key.Key = Up then
      if Count > 1 then Dec(Count);
    if Key.Key = Home then Count:= 1;
    if Key.Key = _End then Count:= ArtNum - 2;
    if Key.Key = F5 then Article[Count]^.EditInfo;
  Until Key.Key = Esc;
end;

procedure Search;
var
  ArtNum, X: integer;
  S: string;
  SearchWord: SearchStr;
  ArticleNum: ArticleNumber;
begin
  SearchScreen;
  StrPCopy(SearchWord, Reatln(20));
  if ReatlnChar <> Esc then
  begin
    TextColor(Yellow);
    TextBackGround(Blue);
    Window(1, 2, 80, 24);
    ClrScr;
    NoCursor;
    ArtNum:= 0;
    For X:= 1 to Max do
      if Article[X]^.SearchMe(SearchWord) then
      begin
        Inc(ArtNum);
        ArticleNum[ArtNum]:= X;
      end;
    DisplaySearchResults(ArtNum, ArticleNum);
  end;
  Key.Key:= Null;
end;

function Save: Boolean;
var
  Ch: char;
begin
  NoCursor;
  Window(1, 2, 80, 24);
  TextBackGround(Blue);
  ClrScr;
  Window(17, 11, 67, 17);
  TextBackGround(DarkGray);
  ClrScr;
  Window(15, 10, 65, 16);
  TextColor(Blue);
  TextBackGround(Cyan);
  ClrScr;
  GoToXY(22, 2);
  Write(' WAIT!');
  TextColor(LightRed);
  GoToXY(7, 4);
  Write('Do you want to save your changes? [Y/N]');
  Ch:= ReadKey;
  if UpCase(Ch) <> 'Y' then Save:= False
    else Save:= True;
  NormCursor;
end;

procedure SaveThem;
begin
  if NeedToSave then
  if Save then
  begin
    Num:= Max;
    Counter:= 1;
    Assign(F, 'article.dat');
    Rewrite(F);
    While Counter <= Num do
    begin
      Article[Counter]^.WriteFile;
      Inc(Counter);
    end;
    Close(F);
    Dec(Counter);
  end;
  NeedToSave:= False;
  Key.Key:= Null;
end;

procedure ReadFile;
begin
  Counter:= 1;
  Assign(F, 'article.dat');
  Reset(F);
  While not Eof(F) do
  begin
    BufArticle.ReadFile;
    GetMem(Article[Counter], Sizeof(BufArticle));
    Article[Counter]^:= BufArticle;
    Inc(Counter);
  end;
  Close(F);
  Dec(Counter);
  Max:= Counter;
  NeedToSave:= False;
end;

procedure Menu;
begin
  Key.Key:= Null;
  While Key.Key <> Esc do
  begin
    MenuScreen;
    Key.GetKeys;
    if Key.Key = One then GetArticles;
    if Key.Key = Two then ShowArticles;
    if Key.Key = Three then Search;
    if Key.Key = Four then SaveThem;
  end;
end;

procedure EndIt;
begin
  Window(1, 1, 80, 25);
  TextColor(LightGray);
  TextBackGround(Black);
  ClrScr;
  NormCursor;
end;

begin
  ReadFile;
  Menu;
  SaveThem;
  EndIt;
end.


program DrawHangman;
uses Crt, Graph,
     BGIDriv, BGIFont,
     GrafBits,
     UnCrunch, Cursor,
     HangGraf, HangWord, HangHelp;
const
  Left = 1;
  Down = 1;
type
  HighScore = record
    Name: string[20];
    Score,
    WordsRight, TriedWords: integer;
  end;
  HS = array[1..4] of HighScore;

var
  Snd,
  Guess,
  Xx, Yy,
  I, X, Y, TxtWid,
  Rights, Wrongs, Score,
  WordsCorrect, WordsTried: integer;
  BehindTop,
  BehindBottom: Pointer;
  Plaque: Pointer;
  F: file;
  FScr: file of HighScore;
  SndStr: string[4];
  Tester, Blanker, Worder: string;
  FirstTime, PlayAgain: Boolean;
  UsedLetter: array[1..26] of char;
  HighScorer: HS;

procedure Abort(Msg : string);
begin
  Writeln(Msg, ': ', GraphErrorMsg(GraphResult));
  Halt(1);
end;

procedure Init;
begin
  if RegisterBGIfont(@SansSerifFontProc) < 0 then
    Abort('SansSerif');
  if RegisterBGIfont(@SmallFontProc) < 0 then
    Abort('Small');
  if RegisterBGIfont(@TriplexFontProc) < 0 then
    Abort('Triplex');
  VGA256;
end;

procedure LetterBase(XPos, YPos: integer);
begin
  YPos:= YPos + 31;
  For X:= 16 to 31 do
  begin
    SetColor(X);
    SetFillStyle(1, X);
    FillEllipse(XPos, YPos - X, X div 4, X div 4);
  end;
end;

procedure WriteWord(Word: string);
begin
  SetTextStyle(1, 0, 3);
  SetTextJustify(2, 1);
  if Word[1] <> '_' then
  begin
    For X:= 44 downto 40 do
    begin
      SetColor(X);
      OutTextXY(DivX + X + 10, 50 - X, Word);
    end;
  end
  else
  begin
    SetTextStyle(3, 0, 1);
    TxtWid:= TextWidth('X') + (TextWidth('X') div 4);
    Yy:= DivX - (TextWidth(Word) + (TextWidth(Word) div 4)) div 2;
    For Xx:= 1 to Length(Word) do
      LetterBase(Yy + (Xx * TxtWid), 170);
  end;
end;

procedure Screen;
var
  WordsTriedStr,
  WordsCorrectStr,
  ScoreStr: string;
begin
  ClearDevice;
  SetViewPort(0, 0, MaxX, MaxY, ClipOn);
  SetFillStyle(1, 127);
  Bar(0, 0, MaxX, DivX + 10);
  SetColor(Green);
  SetFillStyle(1, Green);
  FillEllipse(DivX, MaxY + DivY, MaxY * 2, MaxY - 10);
  For Y:= DivY to MaxY do
  For X:= 0 to MaxX do
  begin
    if GetPixel(X, Y) = Green then
      PutPixel(X, Y, Greens[Random((Y - DivY + 40) div 18)]);
  end;
  WoodBar(230, 0, MaxX, 55);
  SetColor(Yellow);
  SetTextStyle(2, 0, 4);
  SetTextJustify(1, 1);
  Str(Score, ScoreStr);
  Str(WordsTried, WordsTriedStr);
  Str(WordsCorrect, WordsCorrectStr);
  OutTextXY(45, 10, 'Score : ' + ScoreStr);
  SetColor(White);
  OutTextXY(45, 23, WordsCorrectStr + ' words');
  SetColor(LightBlue);
  OutTextXY(45, 33, 'correct from');
  SetColor(White);
  OutTextXY(45, 43, WordsTriedStr + ' attempts.');
  SetViewPort(0, 0, MaxX, MaxY, ClipOn);
  WoodBar(0, MaxY - 15, 95, MaxY);
  SetColor(LightMagenta);
  OutTextXY(47, 7, 'F2 - Sound' + SndStr);
  SetViewPort(0, 0, MaxX, MaxY, ClipOn);
  WoodBar(MaxX - 95, MaxY - 15, MaxX, MaxY);
  SetColor(LightRed);
  OutTextXY(47, 7, 'ESC - Quit');
  SetViewPort(0, 0, MaxX, MaxY, ClipOn);
  WriteWord('HANGMAN');
  WriteWord(Blanker);
end;

procedure NewWord;
begin
  Guess:= 0;
  Rights:= 0;
  Wrongs:= 0;
  Worder:= '';
  Blanker:= '';
end;

procedure FindAWord;
var
  I: integer;
begin
  NewWord;
  Worder:= FindWord;
  Tester:= Worder;
  For I:= 1 to 26 do
    UsedLetter[I]:= #0;
  For I:= 1 to Length(Worder) do
    Insert('_', Blanker, I);
  Screen;
  Inc(WordsTried);
end;

procedure BadSound;
begin
  For X:= 1 to 100 do
  begin
  Sound(200 * Snd);
  Delay(Snd);
  Sound(100 * Snd);
  Delay(Snd);
  Sound(200 * Snd);
  Delay(Snd);
  Sound(100 * Snd);
  end;
  NoSound;
end;

procedure GoodSound;
begin
  Sound(500 * Snd);
  Delay(150 * Snd);
  Sound(700 * Snd);
  Delay(150 * Snd);
  NoSound;
end;

procedure BadLuckYoureOut;
begin
  SetColor(Green);
  SetTextStyle(2, 0, 4);
  SetTextJustify(1, 1);
  SetViewPort(0, 0, MaxX, MaxY, ClipOn);
  DrawSmiley(44, 17);
  X:= DivY + 11 - 34;
  While X > (DivY + 11) - 114 do
  begin
    For Y:= 0 to X do
    begin
      PutImage(0, Y, Smile^, NormalPut);
      PutImage(44, Y, Smile^, NormalPut);
      PutImage(MaxX - 45, Y, Smile^, NormalPut);
      PutImage(MaxX - 89, Y, Smile^, NormalPut);
      Delay(1);
    end;
    Dec(X, 34);
  end;
  Sound(520 * Snd);
  Delay(300 * Snd);
  Sound(280 * Snd);
  Delay(300 * Snd);
  Sound(140 * Snd);
  Delay(300 * Snd);
  NoSound;
  SetViewPort(0, DivY + 45, MaxX, MaxY, ClipOn);
  ClearViewPort;
  SetFillStyle(1, Browns[5]);
  Bar(0, 0, MaxX, DivY - 45);
  SetColor(Browns[6]);
  Line(0, 0, MaxX, 0);
  Line(0, 1, MaxX, 1);
  Line(0, 0, 0, DivY - 45);
  Line(1, 0, 1, DivY - 45);
  SetColor(Browns[0]);
  Line(0, DivY - 45, MaxX, DivY - 45);
  Line(1, DivY - 44, MaxX, DivY - 44);
  Line(MaxX, DivY - 45, MaxX, 0);
  Line(MaxX - 1, DivY - 44, MaxX - 1, 0);
  SetColor(Green);
  OutTextXY(DivX, 10, 'You have been hung!');
  SetColor(Blue);
  OutTextXY(DivX, 25, 'The word was "' + Worder + '".');
  SetColor(White);
  OutTextXY(DivX, 40, 'Try another word? [Y/N]');
  Repeat
    Ch:= ReadKey;
  Until (UpCase(Ch) = 'Y') or (UpCase(Ch) = 'N');
  if UpCase(Ch) = 'N' then PlayAgain:= False
    else PlayAgain:= True;
  Ch:= #27;
end;

procedure BadLetter;
begin
  SetViewPort(DivX - 50, DivY - 65, DivX + 55, DivY + 85, ClipOn);
  BadSound;
  Inc(Wrongs);
  Case Wrongs of
    1: BottomHalf1;
    2: BottomHalf2;
    3: Side1;
    4: Side2;
    5: Side3;
    6: Diagonal;
    7: Top;
    8: Noose;
    9: Head;
    10: Shirt;
    11: Arms;
    12:
    begin
      Legs;
      BadLuckYoureOut;
    end;
  end;
  SetViewPort(0, 0, MaxX, MaxY, ClipOn);
end;

procedure DrawSmiley;
begin
  ClearDevice;
  For X:= 36 to 43 do
  begin
    SetColor(X);
    SetFillStyle(1, X);
    FillEllipse(DivX, DivY - 40, DivX - (X - 40) * 10, DivY - (X - 40) * 10);
  end;
  SetColor(44);
  SetFillStyle(1, 44);
  FillEllipse(DivX, DivY - 40, 60, 50);
  SetColor(Black);
  Arc(DivX, DivY - 40, 180, 0, 40);
  SetFillStyle(1, Black);
  FillEllipse(DivX - 20, DivY - 70, 10, 10);
  FillEllipse(DivX + 20, DivY - 70, 10, 10);
end;

procedure WinWord;
begin
  Inc(Score, 12 - Wrongs);
  Inc(WordsCorrect);
  Ch:= #27;
  DrawSmiley;
  SetTextStyle(2, 0, 4);
  SetViewPort(0, DivY + 45, MaxX, MaxY, ClipOn);
  ClearViewPort;
  SetFillStyle(1, Browns[5]);
  Bar(0, 0, MaxX, DivY - 45);
  SetColor(Browns[6]);
  Line(0, 0, MaxX, 0);
  Line(0, 1, MaxX, 1);
  Line(0, 0, 0, DivY - 45);
  Line(1, 0, 1, DivY - 45);
  SetColor(Browns[0]);
  Line(0, DivY - 45, MaxX, DivY - 45);
  Line(1, DivY - 44, MaxX, DivY - 44);
  Line(MaxX, DivY - 45, MaxX, 0);
  Line(MaxX - 1, DivY - 44, MaxX - 1, 0);
  SetColor(Green);
  OutTextXY(DivX, 10, 'Ya got it!');
  SetColor(Blue);
  OutTextXY(DivX, 25, 'The word was "' + Worder + '".');
  SetColor(White);
  OutTextXY(DivX, 40, 'Try another word? [Y/N]');
  Sound(100 * Snd);
  Delay(300 * Snd);
  Sound(280 * Snd);
  Delay(300 * Snd);
  Sound(400 * Snd);
  Delay(300 * Snd);
  NoSound;
  Repeat
    Ch:= ReadKey;
  Until (UpCase(Ch) = 'Y') or (UpCase(Ch) = 'N');
  if UpCase(Ch) = 'N' then PlayAgain:= False
    else PlayAgain:= True;
  Ch:= #27;
end;

procedure GoodLetter(L: integer; Letter: char);
begin
  SetTextJustify(1, 1);
  SetTextStyle(3, 0, 1);
  SetColor(Red);
  OutTextXY(Yy + TxtWid * L, 165, Letter);
  SetColor(LightRed);
  OutTextXY(Yy + 1 + TxtWid * L, 165, Letter);
  Tester[L]:= #0;
  Inc(Rights);
  if Rights = Length(Worder) then WinWord
  else GoodSound;
end;

procedure SoundToggle;
begin
  if Snd = 1 then
    begin
      Snd:= 0;
      SndStr:= ' On';
    end
  else
    begin
      Snd:= 1;
      SndStr:= ' Off';
    end;
  SetTextStyle(2, 0, 4);
  SetTextJustify(1, 1);
  WoodBar(0, MaxY - 15, 95, MaxY);
  SetColor(Yellow);
  OutTextXY(47, 7, 'F2 - Sound' + SndStr);
  Delay(500);
  SetColor(Magenta);
  OutTextXY(47, 7, 'F2 - Sound' + SndStr);
  SetViewPort(0, 0, MaxX, MaxY, ClipOn);
end;

procedure ViewUsedLetters;
const
  Left = 50;
  Down = 50;
  Middle = (320 - (Left * 2)) div 2;
var
  Behind: Pointer;
  Size: Word;
  Ltr, Writ: integer;
begin
  Size:= ImageSize(Left, Down, MaxX - Left, MaxY - Down);
  GetMem(Behind, Size);
  GetImage(Left, Down, MaxX - Left, MaxY - Down, Behind^);
  WoodBar(Left, Down, MaxX - Left, MaxY - Down);
  SetTextStyle(2, 0, 4);
  SetTextJustify(1, 1);
  SetColor(LightBlue);
  OutTextXY(Middle, 10, 'Used Letters');
  SetTextStyle(2, 0, 5);
  SetColor(LightGray);
  X:= 15;
  Y:= 30;
  For Ltr:= 1 to 26 do
    begin
      Inc(X, 15);
      if X > (Middle * 2) - 30 then
      begin
        X:= 30;
        Inc(Y, 15);
      end;
    For Writ:= 0 to 1 do
      OutTextXY(X + Writ, Y, UpCase(UsedLetter[Ltr]));
      end;
  SetTextStyle(2, 0, 4);
  SetColor(42);
  OutTextXY(Middle, 90, 'Press any key to return to game...');
  ReadKey;
  if KeyPressed then ReadKey;
  SetViewPort(0, 0, MaxX, MaxY, ClipOn);
  PutImage(Left, Down, Behind^, NormalPut);
  FreeMem(Behind, Size);
end;

procedure Plaque2;
var
  Score, Wds, WdsRt: string;
begin
  Str(HighScorer[2].Score, Score);
  Str(HighScorer[2].WordsRight, WdsRt);
  Str(HighScorer[2].TriedWords, Wds);
  WoodBar(35, 125, 145, 173);
  PutImage(5, 5, Plaque^, NormalPut);
  SetColor(Black);
  SetTextStyle(2, 0, 4);
  OutTextXY(55, 10, 'Score : ' + Score);
  OutTextXY(55, 18, WdsRt + ' correct');
  OutTextXY(55, 26, 'from ' + Wds + ' words.');
  SetColor(Blue);
  OutTextXY(56, 10, 'Score : ' + Score);
  OutTextXY(56, 18, WdsRt + ' correct');
  OutTextXY(56, 26, 'from ' + Wds + ' words.');
  SetUserCharSize(4, 5, 4, 4);
  SetColor(LightGray);
  OutTextXY(14, 40, '2nd :');
  SetColor(LightBlue);
  SetUserCharSize(8, 9, 4, 4);
  OutTextXY(56, 40, HighScorer[2].Name);
  SetViewPort(0, 0, MaxX, MaxY, ClipOn);
end;

procedure Plaque4;
var
  Score, Wds, WdsRt: string;
begin
  Str(HighScorer[4].Score, Score);
  Str(HighScorer[4].WordsRight, WdsRt);
  Str(HighScorer[4].TriedWords, Wds);
  WoodBar(185, 125, 295, 173);
  PutImage(5, 5, Plaque^, NormalPut);
  SetColor(Black);
  SetTextStyle(2, 0, 4);
  OutTextXY(55, 10, 'Score : ' + Score);
  OutTextXY(55, 18, WdsRt + ' correct');
  OutTextXY(55, 26, 'from ' + Wds + ' words.');
  SetColor(Blue);
  OutTextXY(56, 10, 'Score : ' + Score);
  OutTextXY(56, 18, WdsRt + ' correct');
  OutTextXY(56, 26, 'from ' + Wds + ' words.');
  SetUserCharSize(4, 5, 4, 4);
  SetColor(LightGray);
  OutTextXY(14, 40, '4th :');
  SetUserCharSize(8, 9, 4, 4);
  SetColor(LightBlue);
  OutTextXY(56, 40, HighScorer[4].Name);
  SetViewPort(0, 0, MaxX, MaxY, ClipOn);
end;

procedure Plaque1;
var
  Score, Wds, WdsRt: string;
begin
  Str(HighScorer[1].Score, Score);
  Str(HighScorer[1].WordsRight, WdsRt);
  Str(HighScorer[1].TriedWords, Wds);
  WoodBar(5, 80, 115, 128);
  PutImage(5, 5, Plaque^, NormalPut);
  SetColor(Black);
  SetTextStyle(2, 0, 4);
  OutTextXY(55, 10, 'Score : ' + Score);
  OutTextXY(55, 18, WdsRt + ' correct');
  OutTextXY(55, 26, 'from ' + Wds + ' words.');
  SetColor(Blue);
  OutTextXY(56, 10, 'Score : ' + Score);
  OutTextXY(56, 18, WdsRt + ' correct');
  OutTextXY(56, 26, 'from ' + Wds + ' words.');
  SetUserCharSize(4, 5, 4, 4);
  SetColor(LightGray);
  OutTextXY(14, 40, '1st : ');
  SetColor(LightBlue);
  SetUserCharSize(8, 9, 4, 4);
  OutTextXY(56, 40, HighScorer[1].Name);
  SetViewPort(0, 0, MaxX, MaxY, ClipOn);
end;

procedure Plaque3;
var
  Score, Wds, WdsRt: string;
begin
  Str(HighScorer[3].Score, Score);
  Str(HighScorer[3].WordsRight, WdsRt);
  Str(HighScorer[3].TriedWords, Wds);
  WoodBar(155, 80, 265, 128);
  PutImage(5, 5, Plaque^, NormalPut);
  SetColor(Black);
  SetTextStyle(2, 0, 4);
  OutTextXY(55, 10, 'Score : ' + Score);
  OutTextXY(55, 18, WdsRt + ' correct');
  OutTextXY(55, 26, 'from ' + Wds + ' words.');
  SetColor(Blue);
  OutTextXY(56, 10, 'Score : ' + Score);
  OutTextXY(56, 18, WdsRt + ' correct');
  OutTextXY(56, 26, 'from ' + Wds + ' words.');
  SetUserCharSize(4, 5, 4, 4);
  SetColor(LightGray);
  OutTextXY(14, 40, '3rd : ');
  SetColor(LightBlue);
  SetUserCharSize(8, 9, 4, 4);
  OutTextXY(56, 40, HighScorer[3].Name);
  SetViewPort(0, 0, MaxX, MaxY, ClipOn);
end;

procedure GetBackGround;
begin
  SetViewPort(0, 0, MaxX, MaxY, ClipOn);
  Size:= ImageSize(Left, Down, MaxX - Left, DivY);
  GetMem(BehindTop, Size);
  GetMem(BehindBottom, Size);
  GetImage(Left, Down, MaxX - Left, DivY, BehindTop^);
  GetImage(Left, DivY, MaxX - Left, MaxY - Down, BehindBottom^);
  ClearDevice;
  SetFillStyle(1, 127);
  Bar(0, 0, MaxX, DivX + 10);
  SetColor(Green);
  SetFillStyle(1, Green);
  FillEllipse(DivX, MaxY + DivY, MaxY * 2, MaxY - 10);
  For Y:= DivY to MaxY do
  For X:= 0 to MaxX do
  begin
    if GetPixel(X, Y) = Green then
      PutPixel(X, Y, Greens[Random((Y - DivY + 40) div 18)]);
  end;
  WoodBar(0, MaxY - 15, 95, MaxY);
  SetColor(LightRed);
  OutTextXY(47, 7, 'ESC - Game');
  SetViewPort(0, 0, MaxX, MaxY, ClipOn);
  WoodBar(MaxX - 95, MaxY - 15, MaxX, MaxY);
  SetColor(LightRed);
  OutTextXY(47, 7, 'ESC - Game');
  SetViewPort(0, 0, MaxX, MaxY, ClipOn);
  WriteWord('Highest Scores');
end;

procedure ReplaceBackGround;
begin
  PutImage(Left, Down, BehindTop^, NormalPut);
  PutImage(Left, DivY + 1, BehindBottom^, NormalPut);
  FreeMem(BehindTop, Size);
  FreeMem(BehindBottom, Size);
end;

procedure ViewHighScores(ReDoBackGround: Boolean);
var
  PlaqueSize, Size: Word;
  ScoreStr,
  WordsTriedStr,
  WordsCorrectStr: string;
begin
  if ReDoBackGround then GetBackGround;
  WoodBar(230, 0, MaxX, 55);
  SetColor(Yellow);
  SetTextStyle(2, 0, 4);
  SetTextJustify(1, 1);
  Str(Score, ScoreStr);
  Str(WordsTried, WordsTriedStr);
  Str(WordsCorrect, WordsCorrectStr);
  OutTextXY(45, 10, 'Your Score : ' + ScoreStr);
  SetColor(White);
  OutTextXY(45, 23, WordsCorrectStr + ' words');
  SetColor(LightBlue);
  OutTextXY(45, 33, 'correct from');
  SetColor(White);
  OutTextXY(45, 43, WordsTriedStr + ' attempts.');
  SetViewPort(0, 0, MaxX, MaxY, ClipOn);
  Assign(F, 'plaque.img');
  PlaqueSize:= ImageSize(10, 5, 110, 35);
  GetMem(Plaque, PlaqueSize);
  Reset(F, PlaqueSize);
  BlockRead(F, Plaque^, 1);
  Close(F);
  Plaque4;
  Plaque3;
  Plaque2;
  Plaque1;
  if ReDoBackGround then ReadKey;
  if ReDoBackGround then ReplaceBackGround;
  FreeMem(Plaque, PlaqueSize);
end;

procedure TestForFunctions;
begin
  Ch:= ReadKey;
  Case Ch of
    #60: SoundToggle;
    #68: ViewHighScores(True);
    else Help(FirstTime);
  end;
end;

procedure TestLetter;
var
  Xx: integer;
  NoGoods: Boolean;
begin
  if Ch in [' ',#13] then ViewUsedLetters
  else
  begin
    Inc(Guess);
    UsedLetter[Guess]:= Ch;
    NoGoods:= True;
    if Ch = #0 then TestForFunctions
    else
    begin
      For Xx:= 1 to Length(Worder) do
        if UpCase(Ch) = UpCase(Worder[Xx]) then
          if Tester[Xx] <> #0 then
          begin
            GoodLetter(Xx, Worder[Xx]);
            NoGoods:= False;
          end;
      if NoGoods then BadLetter;
    end;
  end;
end;

procedure NewGame;
begin
  Init;
  WordsTried:= 0;
  WordsCorrect:= 0;
  Score:= 0;
  Snd:= 1;
  SndStr:= ' Off';
  PlayAgain:= True;
  FirstTime:= True;
end;

procedure Intro;
const
  Left = 50;
  Down = 92;
var
  Behind: Pointer;
  Size: Word;
begin
  Size:= ImageSize(Left, Down, MaxX - Left, MaxY - Down);
  GetMem(Behind, Size);
  GetImage(Left, Down, MaxX - Left, MaxY - Down, Behind^);
  WoodBar(Left, Down, MaxX - Left, MaxY - Down);
  SetColor(42);
  SetTextStyle(2, 0, 4);
  SetTextJustify(1, 1);
  OutTextXY(110, 6, 'Press F1 for help, any key to play...');
  Ch:= ReadKey;
  if Ch = #0 then
    Ch:= ReadKey;
  SetViewPort(0, 0, MaxX, MaxY, ClipOn);
  PutImage(Left, Down, Behind^, NormalPut);
  if Ch = #59 then
    Help(FirstTime);
  FreeMem(Behind, Size);
end;

procedure ReadFile;
var
  I: integer;
begin
  Assign(FScr, 'HANGMAN.SCR');
  Reset(FScr);
  For I:= 1 to 4 do
    Read(FScr, HighScorer[I]);
  Close(FScr);
end;

procedure WriteFile;
var
  I: integer;
begin
  Assign(FScr, 'HANGMAN.SCR');
  Rewrite(FScr);
  For I:= 1 to 4 do
    Write(FScr, HighScorer[I]);
  Close(FScr);
end;

function AskName: string;
var
  NameCh: char;
  Name: string;
  Count, TWid: integer;
begin
  ViewHighScores(False);
  WoodBar(10, 30, 220, 75);
  SetTextStyle(3, 0, 1);
  SetColor(Cyan);
  OutTextXY(104, 10, 'You got a high score!');
  SetColor(LightCyan);
  OutTextXY(105, 10, 'You got a high score!');
  SetTextStyle(2, 0, 4);
  SetColor(Green);
  OutTextXY(105, 30, 'Name : ____________________');
  SetColor(LightGreen);
  Count:= 1;
  TWid:= TextWidth('W');
  NameCh:= ReadKey;
  While (NameCh <> #13) and (NameCh <> #10) and (NameCh <> #27) do
  begin
    MoveTo(105 - (7 * TWid) + (TWid * Count), 30);
    Name[Count]:= NameCh;
    OutText(Name[Count]);
    if NameCh = #8 then
    begin
      Dec(Count, 1);
      Name[Count]:= #0;
      Bar(102 - (7 * TWid) + (TWid * Count), 22, 105 - (6 * TWid) + (TWid * Count), 34);
      MoveTo(105 - (7 * TWid) + (TWid * Count), 30);
    end
    else Inc(Count);
    NameCh:= ReadKey;
  end;
  SetViewPort(0, 0, MaxX, MaxY, ClipOn);
  TWid:= Count;
  For Count:= TWid to 20 do Name[Count]:= #0;
  AskName:= Name;
end;

procedure ExitingStuff;
var
  HiScor: HS;
begin
  HiScor:= HighScorer;
  if Score > HiScor[4].Score then
    if Score > HiScor[3].Score then
      if Score > HiScor[2].Score then
        if Score > HiScor[1].Score then
        begin
          HiScor[4]:= HiScor[3];
          HiScor[3]:= HiScor[2];
          HiScor[2]:= HiScor[1];
          HiScor[1].Score:= Score;
          HiScor[1].WordsRight:= WordsCorrect;
          HiScor[1].TriedWords:= WordsTried;
          HiScor[1].Name:= AskName;
        end
      else
      begin
        HiScor[4]:= HiScor[3];
        HiScor[3]:= HiScor[2];
        HiScor[2].Score:= Score;
        HiScor[2].WordsRight:= WordsCorrect;
        HiScor[2].TriedWords:= WordsTried;
        HiScor[2].Name:= AskName;
      end
    else
    begin
      HiScor[4]:= HiScor[3];
      HiScor[3].Score:= Score;
      HiScor[3].WordsRight:= WordsCorrect;
      HiScor[3].TriedWords:= WordsTried;
      HiScor[3].Name:= AskName;
    end
  else
  begin
    HiScor[4].Score:= Score;
    HiScor[4].WordsRight:= WordsCorrect;
    HiScor[4].TriedWords:= WordsTried;
    HiScor[4].Name:= AskName;
  end;
  HighScorer:= HiScor;
  WriteFile;
end;

procedure TitleScreen;
begin
  NoCursor;
  DisplayANSI(HangManIntro, 1, 1, HangManIntro_Length);
  ReadKey;
end;

begin
  TitleScreen;
  NewGame;
  ReadFile;
  FindAWord;
  Intro;
  While PlayAgain do
  begin
    if not FirstTime then FindAWord;
    FirstTime:= False;
    Ch:= #0;
    While Ch <> #27 do
    begin
      if PlayAgain then Ch:= ReadKey;
      if Ch <> #27 then TestLetter
        else PlayAgain:= False;
    end;
  end;
  ExitingStuff;
  CloseGraph;
end.



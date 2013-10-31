program HangMan;
Uses Crt, ScrnWrit, HangWord, Strings, UnCrunch;
Const
  Chances = 50;
  FileName = 'HANGMAN.HIS';
  WrongBit: array[1..50] of char = (#193, #196, #196, #196, #196, #196,
                                    #196, #196, #196, #196, #196, #196,
                                    #179, #179, #179, #179, #179, #179,
                                    #179, #179, #179, #179, #179, #194,
                                    #196, #196, #196, #196, #191, #179,
                                    '-', '=', '\', '/', '/', '\', '(',
                                     ')', 'o', 'o',   #179, #179, #179,
                                     #179, '/', '\', '/', '\', '/', '\'
                                  );

  WrongBitPos: array[1..50,1..2] of shortint = ((15, 15), (16, 15), (17, 15),
                                                (18, 15), (19, 15), (20, 15),
                                                (21, 15), (22, 15), (23, 15),
                                                (24, 15), (25, 15), (26, 15),
                                                (15, 14), (15, 13), (15, 12),
                                                (15, 11), (15, 10), (15,  9),
                                                (15,  8), (15,  7), (15,  6),
                                                (15,  5), (15,  4), (15,  3),
                                                (16,  3), (17,  3), (18,  3),
                                                (18,  3), (19,  3), (19,  4),
                                                (19,  5), (19,  7), (20,  5),
                                                (18,  5), (20,  7), (18,  7),
                                                (17,  6), (21,  6), (18,  6),
                                                (20,  6), (19,  8), (19,  9),
                                                (19, 10), (19, 11), (18,  9),
                                                (20,  9), (18, 12), (20, 12),
                                                (17, 13), (21, 13)
                                                );

type
  Scor = record
    Name: string[30];
    Score, Words: integer;
  end;

Var
  F: file of Scor;
  ScoreBuf: Scor;
  Ch, Chs: Char;
  I,
  Snd,
  StartPos,
  NumHighScores,
  Score, WordsTried,
  Wrongs, Rights: integer;
  GotIt, PlayAgain: Boolean;
  Blanker, Worder: String[30];
  Tester: array[0..30] of char;
  Scorer: array[1..20] of Scor;

procedure Screen;
const Name: string = 'HANGMAN';
begin
  Window(1, 1, 40, 25);
  TextColor(Black);
  TextBackGround(Red);
  ClrScr;
  Window(1, 1, 40, 24);
  TextColor(Black);
  TextBackGround(Black);
  ClrScr;
  Window(1, 1, 40, 25);
  GoToXY(20 - Length(Name) div 2, 1);
  For I:= 1 to Length(Name) do
  begin
    TextColor(Random(15) + 1);
    Write(Name[I]);
  end;
  TextColor(White);
  TextBackGround(Red);
  GoToXY(3, 25); Write('ESCAPE-');
  GoToXY(16, 25); Write('F9-');
  GoToXY(29, 25); Write('F2-');
  TextColor(LightGray);
  GoToXY(10, 25); Write('Quit');
  GoToXY(19, 25); Write('New Game');
  GoToXY(32, 25); Write('Sound');
  TextColor(Red);
  TextBackGround(Black);
  GoToXY(28, 3); Write('Score : ');
  GoToXY(27, 4); Write('out of : ');
  TextColor(Yellow);
  Write(WordsTried * 25);
  GoToXY(36, 3); Write(Score);
  TextColor(Green);
  GoToXY(15, 23); Write('Guess a letter');
  TextColor(White);
  TextBackGround(Black);
end;

procedure ClearLine(LineNo: integer);
var
  G: integer;
begin
  GoToXY(1, LineNo);
  For G:= 1 to 39 do
    Write(' ');
end;

procedure NewWord;
begin
  Rights:= 0;
  Blanker:= '';
  Worder:= '';
  Wrongs:= 0;
  ClearLine(23);
  Screen;
end;

procedure NewGame;
begin
  NewWord;
  Score:= 0;
  WordsTried:= 0;
end;

procedure FindAWord;
begin
  NewWord;
  Worder:= FindWord;
  For I:= 1 to Length(Worder) do
    Insert('_', Blanker, I);
  StartPos:= 20 - Length(Blanker) div 2;
  GoToXY(StartPos + 1, 20); Write(Blanker);
  StrPCopy(Tester, Worder);
end;

procedure EndWord;
begin
  Dec(Score, 13);
  Inc(WordsTried);
  Sound(520 * Snd);
  Delay(300 * Snd);
  Sound(280 * Snd);
  Delay(300 * Snd);
  Sound(140 * Snd);
  Delay(300 * Snd);
  NoSound;
  Window(3, 18, 38, 23);
  ClrScr;
  TextColor(LightBlue);
  GoToXY(10, 1); Write('You have been hung!');
  TextColor(Green);
  GoToXY(9, 3); Write('The word was "', Worder, '".');
  TextColor(White);
  GoToXY(8, 5); Write('Try another word? [Y/N]');
  Repeat
    Chs:= ReadKey;
  Until (UpCase(Chs) = 'Y') or (UpCase(Chs) = 'N');
  if UpCase(Chs) = 'N' then PlayAgain:= False
    else PlayAgain:= True;
  Ch:= #27;
end;

procedure HappyScreen;
var
  X, Y: integer;
begin
  X:= -2;
  Y:= -1;
  While Y < 25 do
  begin
    Inc(Y);
    X:= 0;
    While X < 40 do
    begin
      Inc(X);
      GoToXY(X, Y);
      Write(#1);
    end;
  end;
end;

procedure WinWord;
begin
  TextColor(Yellow);
  HappyScreen;
  Inc(Score, (Chances - Wrongs) div 2);
  Inc(WordsTried);
  Sound(140 * Snd);
  Delay(300 * Snd);
  Sound(280 * Snd);
  Delay(300 * Snd);
  Sound(520 * Snd);
  Delay(300 * Snd);
  NoSound;
  Window(3, 8, 38, 15);
  ClrScr;
  TextColor(LightRed);
  GoToXY(19 - (Length(Worder) + 2) div 2, 2); Write('"', Worder, '"');
  TextColor(Green);
  GoToXY(14, 4); Write('You got it!');
  TextColor(White);
  GoToXY(8, 6); Write('Try another word? [Y/N]');
  Repeat
    Chs:= ReadKey;
  Until (UpCase(Chs) = 'Y') or (UpCase(Chs) = 'N');
  if UpCase(Chs) = 'N' then PlayAgain:= False
    else PlayAgain:= True;
  Ch:= #27;
end;

procedure OutOfHelp;
var
  Bit: integer;
begin
  Window(1, 1, 40, 25);
  Screen;
  TextColor(Brown);
  For Bit:= 1 to Wrongs do
  begin
    GoToXY(WrongBitPos[Bit, 1], WrongBitPos[Bit, 2]);
    Write(WrongBit[Bit]);
  end;
  TextColor(White);
  GoToXY(StartPos + 1, 20); Write(Blanker);
  TextColor(LightRed);
  For Bit:= 1 to Length(Worder) do
  begin
    GoToXY(StartPos + Bit, 20);
    if Tester[Bit - 1] = #0 then Write(Worder[Bit]);
  end;
end;

procedure Help;
begin
  TextColor(Black);
  TextBackGround(Black);
  ClrScr;
  TextBackGround(Cyan);
  Frame(1, 1, 40, 24, 2, 'HANGMAN HELP');
  TextColor(Cyan);
  ClrScr;
  Window(2, 2, 39, 23);
  TextColor(Blue);
  GoToXY(1, 3);
  Writeln('         HOW THE GAME WORKS');
  TextColor(DarkGray);
  Writeln('                                      ');
  Writeln('   This computer game is based on the');
  Writeln(' popular childrens'' game of hangman,');
  Writeln(' and works much the same as the real ');
  Writeln(' game.  To guess a letter, just type ');
  Writeln(' that letter into the keyboard.  To ');
  Write(' toggle the ');
  TextColor(LightGreen); Write('SOUND'); TextColor(DarkGray);
  Write(', press');
  TextColor(LightGreen);  Writeln(' F2, ');
  TextColor(DarkGray);
  Write(' and to ');
  TextColor(Yellow);  Write('QUIT'); TextColor(DarkGray);
  Write(' the game press ');
  TextColor(Yellow);  Writeln('ESCAPE.');
  TextColor(DarkGray);
  Writeln;
  Writeln(' Other than that, just follow the on-');
  Writeln(' screen instructions.');
  ReadKey;
  OutOfHelp;
end;

procedure TestForFunctions;
var
  ChEqual27: boolean;
begin
  ChEqual27:= False;
  Ch:= ReadKey;
  case Ch of
    #59: Help;
    #60:
    begin
      TextColor(Yellow);
      GoToXY(15, 18);
      if Snd <> 0 then Snd:= 0
        else Snd:= 1;
      if Snd = 1 then Write('Sound is on.')
        else Write('Sound is off.');
      Delay(500);
      GoToXY(15, 18); Write('              ');
      TextColor(White);
    end;
    #67:
    begin
      NewWord;
      NewGame;
      PlayAgain:= True;
      ChEqual27:= True;
    end;
  end;
  if not ChEqual27 then Ch:= ReadKey
    else Ch:= #27;
end;

procedure GoodLetter;
begin
  TextColor(LightRed);
  GoToXY(StartPos + I, 20);  Write(Worder[I]);
  Tester[I - 1]:= #0;
  ClearLine(23);
  TextColor(LightMagenta);
  GoToXY(4, 23);
  if Length(Worder) - (Rights + 1) > 1 then
    Write('Well done!  Only ', Length(Worder) - (Rights + 1), ' letters to go!')
  else if Length(Worder) - (Rights + 1) = 1 then
    Write('Well done!  Only 1 letter to go!');
  Inc(Rights);
  if Rights = Length(Worder) then WinWord;
  GotIt:= True;
end;

procedure BadLetter;
begin
  Sound(420 * Snd);
  Delay(100 * Snd);
  Sound(280 * Snd);
  Delay(100 * Snd);
  Sound(140 * Snd);
  Delay(100 * Snd);
  NoSound;
  For I:= 1 to 4 do
  begin
    Inc(Wrongs);
    if Wrongs >= 41 then TextColor(Green)
      else if Wrongs >= 31 then TextColor(Yellow)
        else TextColor(Brown);
    GoToXY(WrongBitPos[Wrongs, 1], WrongBitPos[Wrongs, 2]);
    Write(WrongBit[Wrongs]);
    ClearLine(23);
    TextColor(Blue);
    GoToXY(8, 23); Write('Oh well.  Have another try.');
  end;
  if Wrongs >= 50 then EndWord;
end;

procedure TestLetter;
begin
  For I:= 1 to Length(Worder) do
    if UpCase(Ch) = UpCase(Worder[I]) then
      if Tester[I - 1] <> #0 then
        GoodLetter;
end;

procedure GetCommand;
begin
  Repeat
    Ch:= ReadKey;
    if Ch = #27 then
      PlayAgain:= False;
    if Ch = #0 then TestForFunctions;
    if Ch in ['A'..'Z', 'a'..'z', '0'..'9', '-'] then
      begin
        TestLetter;
        if GotIt = False then
          BadLetter;
      end;
    GotIt:= False;
  Until Ch = #27;
end;

procedure Area(X1, Y1, X2, Y2: integer; Cha: char);
var
  X, Y: integer;
begin
  For Y:= Y1 to Y2 do
    For X:= X1 to X2 do
      begin
        GoToXY(X, Y);
        Write(Cha);
      end;
end;

procedure At(X, Y: integer; Ln: char);
begin
  GoToXY(X, Y);
  Write(Ln);
end;

procedure WriteHangman(StartX: integer; Colour: word);
begin
  TextColor(Colour);
  At(1 + StartX, 1, #179); { H }
  At(1 + StartX, 2, #179);
  At(1 + StartX, 4, #179);
  At(1 + StartX, 5, #179);
  At(5 + StartX, 1, #179);
  At(5 + StartX, 2, #179);
  At(5 + StartX, 4, #179);
  At(5 + StartX, 5, #179);
  At(1 + StartX, 3, #195);
  At(5 + StartX, 3, #180);
  At(2 + StartX, 3, #196);
  At(3 + StartX, 3, #196);
  At(4 + StartX, 3, #196);

  At(7 + StartX, 2, #179); { A }
  At(7 + StartX, 4, #179);
  At(7 + StartX, 5, #179);
  At(11 + StartX, 2, #179);
  At(11 + StartX, 4, #179);
  At(11 + StartX, 5, #179);
  At(7 + StartX, 3, #195);
  At(11 + StartX, 3, #180);
  At(8 + StartX, 1, #196);
  At(9 + StartX, 1, #196);
  At(10 + StartX, 1, #196);
  At(8 + StartX, 3, #196);
  At(9 + StartX, 3, #196);
  At(10 + StartX, 3, #196);
  At(7 + StartX, 1, #218);
  At(11 + StartX, 1, #191);

  At(13 + StartX, 2, #179); { N }
  At(13 + StartX, 3, #179);
  At(13 + StartX, 4, #179);
  At(13 + StartX, 5, #179);
  At(14 + StartX, 2, #179);
  At(14 + StartX, 3, #179);
  At(16 + StartX, 1, #179);
  At(16 + StartX, 2, #179);
  At(16 + StartX, 3, #179);
  At(16 + StartX, 4, #179);
  At(14 + StartX, 4, #179);
  At(15 + StartX, 5, #196);
  At(13 + StartX, 1, #218);
  At(14 + StartX, 1, #191);
  At(14 + StartX, 5, #192);
  At(16 + StartX, 5, #217);

  At(19 + StartX, 1, #196); { G }
  At(20 + StartX, 1, #196);
  At(21 + StartX, 1, #196);
  At(19 + StartX, 5, #196);
  At(20 + StartX, 5, #196);
  At(21 + StartX, 5, #196);
  At(21 + StartX, 3, #196);
  At(18 + StartX, 1, #218);
  At(22 + StartX, 1, #191);
  At(22 + StartX, 3, #191);
  At(18 + StartX, 5, #192);
  At(22 + StartX, 5, #217);

  At(18 + StartX, 2, #179); { M }
  At(18 + StartX, 3, #179);
  At(18 + StartX, 4, #179);
  At(22 + StartX, 4, #179);
  At(24 + StartX, 2, #179);
  At(24 + StartX, 3, #179);
  At(24 + StartX, 4, #179);
  At(24 + StartX, 5, #179);
  At(26 + StartX, 2, #179);
  At(26 + StartX, 3, #179);
  At(28 + StartX, 2, #179);
  At(28 + StartX, 3, #179);
  At(28 + StartX, 4, #179);
  At(28 + StartX, 5, #179);
  At(25 + StartX, 1, #196);
  At(27 + StartX, 1, #196);
  At(24 + StartX, 1, #218);
  At(28 + StartX, 1, #191);
  At(26 + StartX, 1, #194);

  At(7 + StartX + 23, 2, #179); { A }
  At(7 + StartX + 23, 4, #179);
  At(7 + StartX + 23, 5, #179);
  At(11 + StartX + 23, 2, #179);
  At(11 + StartX + 23, 4, #179);
  At(11 + StartX + 23, 5, #179);
  At(7 + StartX + 23, 3, #195);
  At(11 + StartX + 23, 3, #180);
  At(8 + StartX + 23, 1, #196);
  At(9 + StartX + 23, 1, #196);
  At(10 + StartX + 23, 1, #196);
  At(8 + StartX + 23, 3, #196);
  At(9 + StartX + 23, 3, #196);
  At(10 + StartX + 23, 3, #196);
  At(7 + StartX + 23, 1, #218);
  At(11 + StartX + 23, 1, #191);

  At(13 + StartX + 23 , 2, #179); { N }
  At(13 + StartX + 23, 3, #179);
  At(13 + StartX + 23, 4, #179);
  At(13 + StartX + 23, 5, #179);
  At(14 + StartX + 23, 2, #179);
  At(14 + StartX + 23, 3, #179);
  At(16 + StartX + 23, 1, #179);
  At(16 + StartX + 23, 2, #179);
  At(16 + StartX + 23, 3, #179);
  At(16 + StartX + 23, 4, #179);
  At(14 + StartX + 23, 4, #179);
  At(15 + StartX + 23, 5, #196);
  At(13 + StartX + 23, 1, #218);
  At(14 + StartX + 23, 1, #191);
  At(14 + StartX + 23, 5, #192);
  At(16 + StartX + 23, 5, #217);
end;

procedure TitleScreen;
begin
  DisplayANSI(HangManIntro, 1, 1, HangManIntro_Length);
  ReadKey;
end;
(*begin
  TextMode(Co80);
  Window(1, 1, 80, 25);
  TextColor(Black);
  TextBackGround(Black);
  ClrScr;
  TextBackGround(LightGray);
  Area(10, 7, 15, 25, ' ');      { start of gallows }
  Area(10, 7, 55, 8, ' ');
  Area(50, 9, 55, 9, ' ');       { end of gallows }
  TextColor(White);
  GoToXY(10, 7); Write(#218);
  For I:= 11 to 54 do
  begin
    GoToXY(I, 7);
    if I <> 53 then
      Write(#196);
  end;
  For I:= 8 to 25 do
  begin
    GoToXY(10, I);
    Write(#179);
  end;
  TextColor(Yellow);
  TextBackGround(Brown);
  Area(45, 10, 60, 10, #219);     { start of hair }
  Area(42, 11, 63, 11, #219);
  Area(40, 12, 65, 12, #219);
  Area(39, 13, 41, 15, #219);
  Area(64, 13, 66, 15, #219);     { end of hair }
  Area(42, 13, 63, 15, ' ');      { start of face }
  Area(42, 13, 43, 13, #219);     { these two lines are more hair }
  Area(63, 13, 63, 13, #219);     { so that the forehead isn't rectangular }
  Area(40, 16, 65, 17, ' ');
  Area(42, 18, 63, 18, ' ');
  Area(45, 19, 60, 19, ' ');
  Area(47, 20, 58, 20, ' ');      { end of face }
  TextColor(Black);
  Area(48, 15, 49, 15, #219);
  Area(56, 15, 57, 15, #219);
  Area(49, 18, 56, 18, #196);
  TextColor(LightCyan);               { start of coat }
  Area(47, 21, 58, 22, #219);
  Area(44, 22, 61, 22, #219);
  Area(40, 23, 65, 24, #219);
  Area(37, 24, 68, 24, #219);
  Area(35, 25, 70, 25, #219);     { end of Coat }
  TextColor(DarkGray);
  TextBackGround(Black);
  GoToXY(5, 5); Write('Welcome to...');

  WriteHangman(20, Red);
  WriteHangman(19, LightRed);
  TextBackGround(Black);
  TextColor(LightBlue);
  GoToXY(20, 17); Write('Press any key');
  GoToXY(28, 18); Write('to play...');
  ReadKey;
  TextMode(Co40);
  Snd:= 1;
end;      *)

begin
  TitleScreen;
  NewGame;
  Repeat
    Screen;
    FindAWord;
    GetCommand;
  Until PlayAgain = False;
  TextMode(Co80);
end.





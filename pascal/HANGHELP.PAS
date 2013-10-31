unit HangHelp;
interface
const
  XDist = 18;
  YDist = 18;
var
  Ch: char;
  Size: Word;
  procedure Help(FirstTime: Boolean);

implementation
uses Crt, Graph,
     GrafBits, HangGraf;

function HelpPage1: char;
begin
  WoodBar(XDist, YDist, MaxX - XDist, MaxY - YDist);
  SetViewPort(0, 0, MaxX, MaxY, ClipOn);
  WoodBar(XDist + 2, YDist + 2, MaxX - (XDist + 2), MaxY - (YDist + 2));
  SetTextStyle(2, 0, 4);
  SetTextJustify(1, 1);
  SetColor(LightBlue);
  OutTextXY(140, 10 - 4, 'Aim Of The Game');
  SetColor(LightGray);
  OutTextXY(140, 20, 'To guess all the letters in the secret');
  OutTextXY(140, 30, 'word before the man is hung.');
  SetColor(LightBlue);
  OutTextXY(140, 50 - 4, 'How To Play');
  SetColor(LightRed);
  OutTextXY(140, 60 - 4, 'The white ovals at the bottom of the screen');
  OutTextXY(140, 70 - 4, 'tell you how many letters are in the word you');
  OutTextXY(140, 80 - 4, 'are trying to solve.');
  SetColor(Cyan);
  OutTextXY(140, 90 - 4, 'Press the letter on your keyboard that');
  OutTextXY(140, 100 - 4, 'you think may be in the word.  If the letter');
  OutTextXY(140, 110 - 4, 'you press is in the word, it will be displayed');
  OutTextXY(140, 120 - 4, 'in its space in the word, near the bottom of ');
  OutTextXY(140, 130 - 4, 'the screen.');
  SetColor(Yellow);
  OutTextXY(140, 140, 'Press any key to continue, or press ESC to');
  OutTextXY(140, 150, 'play the game.');
  Ch:= ReadKey;
  HelpPage1:= Ch;
end;

function HelpPage2: char;
begin
  SetViewPort(0, 0, MaxX, MaxY, ClipOn);
  WoodBar(XDist + 2, YDist + 2, MaxX - (XDist + 2), MaxY - (YDist + 2));
  SetColor(LightBlue);
  OutTextXY(140, 10 - 4, 'How To Play contd.');
  SetColor(Cyan);
  OutTextXY(140, 20, 'If you guess all the letters in the word, you');
  OutTextXY(140, 30, 'are awarded points, depending on how many');
  OutTextXY(140, 40, 'wrong letters you guessed for that word. If you ');
  OutTextXY(140, 50, 'solved the word without any letters wrong, you');
  OutTextXY(140, 60, 'are awarded 12 points, and 1 less point for ');
  OutTextXY(140, 70, 'each letter you guessed wrong.');
  SetColor(39);
  OutTextXY(140, 80, 'When you guess a letter which is not in the');
  OutTextXY(140, 90, 'word, part of the Hangman will be drawn. ');
  OutTextXY(140, 100, 'If you get 12 letters wrong, the Hangman is');
  OutTextXY(140, 110, 'completed. No points are awarded to you,');
  OutTextXY(140, 120, 'and you are asked if you want to try another');
  OutTextXY(140, 130, 'word.');
  SetColor(Yellow);
  OutTextXY(140, 140, 'Press ESC to play the game, or any key');
  OutTextXY(140, 150, 'to continue.');
  Ch:= ReadKey;
  if Ch <> #27 then HelpPage2:= #0
    else HelpPage2:= #27;
end;

function HelpPage3: char;
begin
  SetViewPort(0, 0, MaxX, MaxY, ClipOn);
  WoodBar(XDist + 2, YDist + 2, MaxX - (XDist + 2), MaxY - (YDist + 2));
  SetColor(LightBlue);
  OutTextXY(140, 10, 'Function Keys');
  SetColor(42);
  OutTextXY(140, 30, 'F1 - View this help screen at any time');
  OutTextXY(140, 40, 'during the game.');
  SetColor(79);
  OutTextXY(140, 50, 'F2 - Turn sound on / off. ');
  SetColor(79);
  OutTextXY(140, 60,'F10 - View high scores.');
  SetColor(96);
  OutTextXY(140, 70, 'Space or Enter - Show used letters.');
  SetColor(68);
  OutTextXY(140, 80, 'ESCAPE - Quits game.');
  SetColor(Yellow);
  OutTextXY(140, 140, 'Press ESC to play the game, or any key');
  OutTextXY(140, 150, 'to re-start help.');
  Ch:= ReadKey;
  if Ch <> #27 then HelpPage3:= #0
    else HelpPage3:= #27;
end;

procedure Help;
var
  Helper: char;
  Img: Pointer;
begin
  if not FirstTime then FreeMem(Img, Size);
  Size:= ImageSize(XDist, YDist, MaxX - XDist, MaxY - YDist);
  GetMem(Img, Size);
  GetImage(XDist, YDist, MaxX - XDist, MaxY - YDist, Img^);
  Helper:= #27;
  Repeat
    Helper:= HelpPage1;
    if Helper <> #27 then
      Helper:= HelpPage2;
    if Helper <> #27 then
      Helper:= HelpPage3;
  Until Helper = #27;
  SetViewPort(0, 0, MaxX, MaxY, ClipOn);
  PutImage(XDist, YDist, Img^, NormalPut);
  Ch:= #0;
end;
end.

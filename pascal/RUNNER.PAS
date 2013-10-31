{$M 8192,0,0}           { Leave memory for child process }
program RunGraphics;
Uses Crt, Dos, ScrnWrit, GGHelp;
const MaxPos = 15;
      MinPos = 3;
      XPos = 20;
      ProgName: array[1..13] of string[8] = ('PATTERNS', 'BUBBLES',
                                              'BOUNCE', 'BALL',
                                              'FLYING', 'DIAMOND',
                                              'LINES', 'STAFIELD 100',
                                              'DOG', 'ROUNDY', 'RANDRECT',
                                              'POLY75', 'PISTON /s /s');
Var
  X, ProgNumber: integer;
  Pos: shortint;
  Ch: char;

procedure Run;
begin
    if ProgName[ProgNumber] <> '' then
    begin
      SwapVectors;
      Exec('C:\COMMAND.COM', '/C ' + ProgName[ProgNumber]);
      SwapVectors;
      if DosError <> 0 then
        WriteLn('Could not execute COMMAND.COM');
      WriteLn;
    end;
end;

procedure Tubes(StX, StY, EnY: integer; FCol, BCol: Word);
begin
  TextColor(FCol);
  TextBackGround(BCol);
  For X:= StY to EnY do
  begin
    WriteAt(StX, X, #176);
    WriteAt(StX + 1, X, #177);
    WriteAt(StX + 2, X, #178);
    WriteAt(StX + 3, X, #219);
    WriteAt(StX + 4, X, #178);
    WriteAt(StX + 5, X, #177);
    WriteAt(StX + 6, X, #176);
  end;
end;

procedure Clips;
begin
  Window(1, 1, 80, 25);
  TextColor(DarkGray);
  WriteAt(2, 8, #219#219#219#219#219#219);
  WriteAt(2, 16, #219#219#219#219#219#219);
  WriteAt(74, 8, #219#219#219#219#219#219);
  WriteAt(74, 16, #219#219#219#219#219#219);
  For X:= 1 to 4 do
  begin
    WriteAt(20, X, #219#219);
    WriteAt(60, X, #219#219);
  end;
end;

procedure MainScreen;
begin
  TextColor(Yellow);
  TextBackGround(Brown);
  ClrScr;
  Tubes(3, 1, 25, Yellow, Brown);
  Tubes(72, 1, 25, Yellow, Brown);
  TextColor(LightCyan);
  TextBackGround(Brown);
  WriteAt(12, 22, 'Choose a program using the arrow keys and press Enter...');
  TextColor(Black);
  WriteAt(25, 24, '...or press ESC to quit.');
  TextBackGround(Black);
  TextColor(White);
  Frame(6, 4, 75, 20, 1, '');
  TextColor(Black);
  ClrScr;
  Clips;
end;

procedure ListChoices;
begin
  Window(8, 5, 73, 19);
  TextColor(LightRed);
  WriteAt(24, 1, 'GLENN''S  GRAPHICS');
  TextColor(LightBlue);
  WriteAt(22, 3, '  Pretty Patterns');
  WriteAt(22, 4, '  Bubbles');
  WriteAt(22, 5, '  Bouncing Ball');
  WriteAt(22, 6, '  Magic Ball');
  WriteAt(22, 7, '  Flying');
  WriteAt(22, 8, '  Diamond');
  WriteAt(22, 9, '  Line Magic');
  WriteAt(22, 10, '  Warp Speed');
  WriteAt(22, 11, '  Cute Dog');
  WriteAt(22, 12, '  Round ''n'' Round');
  WriteAt(22, 13, '  Polygamy');
  WriteAt(22, 14, '  Complex Shapes');
  WriteAt(22, 15, '  Pistons');
end;

procedure Up;
begin
  TextColor(Green);
  GoToXY(XPos, Pos);
  Write(' ');
  Dec(Pos);
  if Pos < MinPos then Pos:= MaxPos;
  WriteAt(XPos, Pos, #26);
end;

procedure Down;
begin
  TextColor(Green);
  WriteAt(XPos, Pos, ' ');
  Inc(Pos);
  if Pos > MaxPos then Pos:= MinPos;
  WriteAt(XPos, Pos, #26);
end;

procedure BackToMenu;
begin
  if KEyPressed then ReadKey;
  TextMode(Co80);
  MainScreen;
  ListChoices;
  TextColor(Green);
  GoToXY(XPos, Pos);
  Write(#26);
end;

procedure SelectThisOne;
begin
  ProgNumber:= Pos - 2;
  Run;
  if KEyPressed then ReadKey;
  BackToMenu;
end;

procedure HelpOnThisOne;
begin
  ProgNumber:= Pos - 2;
  Case ProgNumber of
    1: PatternsInfo;
    2: BubblesInfo;
    3: BallInfo;
    4: BounceInfo;
    5: FlyingInfo;
    6: DiamondInfo;
    7: LinesInfo;
    8: StafieldInfo;
    9: DogInfo;
    10: RoundyInfo;
    11: PolyInfo;
    12: Poly75Info;
    13: PistonInfo;
  end;
  BackToMenu;
end;

procedure MakeChoices;
begin
  TextColor(Green);
  Pos:= MinPos;
  GoToXY(XPos, Pos);
  Write(#26);
  Repeat
    Ch:= ReadKey;
    Case Ch of
      #0:
      begin
        Ch:= ReadKey;
        Case Ch of
          #72: Up;
          #80: Down;
        end;
      end;
      #13: SelectThisOne;
    end;
  Until Ch = #27;
end;

procedure TidyUp;
begin
  Window(1, 1, 80, 25);
  TextColor(White);
  TextBackGround(Blue);
  ClrScr;
end;

begin
  MainScreen;
  ListChoices;
  MakeChoices;
  TidyUp;
end.






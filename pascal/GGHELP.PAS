Unit GGHelp;
interface
  procedure WriteAt(XeX, YiY: integer; Msg: string);
  procedure PatternsInfo;
  procedure BubblesInfo;
  procedure BallInfo;
  procedure BounceInfo;
  procedure FlyingInfo;
  procedure DiamondInfo;
  procedure LinesInfo;
  procedure StafieldInfo;
  procedure DogInfo;
  procedure RoundyInfo;
  procedure PolyInfo;
  procedure Poly75Info;
  procedure PistonInfo;
  var
    F: text;
    S: array[1..25] of String[75];
    I: integer;
    Cha: char;
    Buf: string;

implementation
Uses Crt, ScrnWrit;

procedure WriteAt;
begin
  GoToXY(Xex, YiY);
  Write(Msg);
end;

procedure OpenFile;
begin
  Assign(F, 'GGRAPHIC.INF');
  Reset(F);
end;

procedure ReadFile;
begin
  For I:= 1 to 21 do
    ReadLn(F, S[I]);
end;

procedure CloseFile;
begin
  Close(F);
end;

procedure ScreenReady(FCol, BCol, CmdCol, CmdBCol: word; FrameType: Shortint; Heading: string);
begin
  TextColor(CmdCol);
  TextBackGround(CmdBCol);
  Window(1, 1, 80, 25);
  ClrScr;
  Command_Bar('ESC ','','','','','','Return to Menu','','','','','');
  TextBackGround(BCol);
  TextColor(FCol);
  Frame(1, 1, 80, 24, FrameType, Heading);
  TextColor(BCol);
  ClrScr;
  TextColor(FCol);
end;

procedure PatternsInfo;
begin
  ScreenReady(Yellow, Blue, Green, Black, 1, 'PATTERNS INFO');
  OpenFile;
  ReadFile;
  CloseFile;
  For I:= 1 to 21 do
    WriteAt(3, WhereY + 1, S[I]);
  Cha:= #0;
  While Cha <> #27 do
    Cha:= ReadKey;
end;

procedure BubblesInfo;
begin
  ScreenReady(Black, Cyan, White, DarkGray, 3, 'BUBBLES INFO');
  OpenFile;
  ReadFile;
  ReadFile;
  CloseFile;
  For I:= 1 to 21 do
    WriteAt(3, WhereY + 1, S[I]);
  Cha:= #0;
  While Cha <> #27 do
    Cha:= ReadKey;
end;

procedure BallInfo;
begin
  ScreenReady(Yellow, Magenta, Yellow, Black, 1, 'BOUNCY BALL INFO');
  OpenFile;
  ReadFile;
  ReadFile;
  ReadFile;
  CloseFile;
  For I:= 1 to 21 do
    WriteAt(3, WhereY + 1, S[I]);
  Cha:= #0;
  While Cha <> #27 do
    Cha:= ReadKey;
end;

procedure BounceInfo;
begin
  ScreenReady(Black, Green, Cyan, Black, 1, 'MAGIC BALL INFO');
  OpenFile;
  ReadFile;
  ReadFile;
  ReadFile;
  ReadFile;
  CloseFile;
  For I:= 1 to 21 do
    WriteAt(3, WhereY + 1, S[I]);
  Cha:= #0;
  While Cha <> #27 do
    Cha:= ReadKey;
end;

procedure FlyingInfo;
begin
  ScreenReady(Blue, Black, White, Red, 1, 'FLYING INFO');
  OpenFile;
  For I:= 1 to 5 do
    ReadFile;
  CloseFile;
  For I:= 1 to 21 do
    WriteAt(3, WhereY + 1, S[I]);
  Cha:= #0;
  While Cha <> #27 do
    Cha:= ReadKey;
end;

procedure DiamondInfo;
begin
end;

procedure LinesInfo;
begin
end;

procedure StafieldInfo;
begin
end;

procedure DogInfo;
begin
end;

procedure RoundyInfo;
begin
end;

procedure PolyInfo;
begin
end;

procedure Poly75Info;
begin
end;

procedure PistonInfo;
begin
end;
end.



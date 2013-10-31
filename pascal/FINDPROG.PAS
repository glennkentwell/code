{$M 32192,0,0}           { Leave memory for child process }
program ExeProgs;
uses Crt, Dos, Buttons, Cursor;
const
  MaxDirSize = 1024;
var
  Directory: string[80];
  Name, Namer: string[8];
  Path: string;
  Count, CountExes, TotalExes: integer;
  DirInfo: SearchRec;
  CopyFile, ExeFile: array[1..300] of string[8];

procedure Screen;
begin
  Window(1, 1, 80, 25);
  TextColor(DarkGray);
  TextBackGround(Cyan);
  ClrScr;
  GoToXY(30, 1); Write('Program Finder');
  GoToXY(1, 25);
  TextColor(LightRed);
  Write('KEYS:');
  TextColor(Black);
  Write('  Arrows to scroll');
  TextColor(Yellow);
  Write('  Enter');
  TextColor(Black);
  Write(' - Run selection');
  TextColor(Yellow);
  Write('   Space');
  TextColor(Black);
  Write(' - New dir');
  TextColor(Yellow);
  Write('  ESC');
  TextColor(Black);
  Write(' - Quit');
  Window(1, 2, 80, 24);
  TextColor(LightGray);
  TextBackGround(Blue);
  ClrScr;
  NoCursor;
end;

procedure SortEm;
var
  X, Y: integer;
begin
  CopyFile:= ExeFile;
end;

procedure FindTheDirs;
begin
  Screen;
  Dire:= Directry;
  ChDir(Dire);
  Path:= '*.EXE';
  For X:= 1 to 300 do ExeFile[X]:= '';
  X:= 5;
  Y:= 1;
  Count:= 0;
  CountExes:= 0;
  TotalExes:= 0;
  FindFirst(Path, ReadOnly + Archive, DirInfo);
  while (DosError = 0) and (Count < MaxDirSize) do
  begin
    Inc(Y);
    if Y > 22 then
    begin
      Y:= 2;
      Inc(X, 12);
    end;
    Inc(Count);
    Inc(CountExes);
    Name:= DirInfo.Name;
    I:= 1;
    While Name[I] <> '.' do
    begin
      Insert(Name[I], ExeFile[CountExes], I);
      Inc(I);
    end;
    GoToXY(X, Y);
    Write(ExeFile[CountExes]);
    FindNext(DirInfo);
  end;
  SortEm;
  TotalExes:= TotalExes + CountExes;
end;

function AskDir: string;
var Dir: string;
begin
  Window(1, 25, 80, 25);
  TextColor(Green);
  TextBackGround(Red + Blink);
  ClrScr;
  NormCursor;
  Write(' Choose a directory to search for programs.');
  Directory:= FindTheDirs;
end;

procedure FindTheExes(Directry: string);
var
  Dire: string;
  I, X, Y: integer;
begin
  Screen;
  Dire:= Directry;
  ChDir(Dire);
  Path:= '*.EXE';
  For X:= 1 to 300 do ExeFile[X]:= '';
  X:= 5;
  Y:= 1;
  Count:= 0;
  CountExes:= 0;
  TotalExes:= 0;
  FindFirst(Path, ReadOnly + Archive, DirInfo);
  while (DosError = 0) and (Count < MaxDirSize) do
  begin
    Inc(Y);
    if Y > 22 then
    begin
      Y:= 2;
      Inc(X, 12);
    end;
    Inc(Count);
    Inc(CountExes);
    Name:= DirInfo.Name;
    I:= 1;
    While Name[I] <> '.' do
    begin
      Insert(Name[I], ExeFile[CountExes], I);
      Inc(I);
    end;
    GoToXY(X, Y);
    Write(ExeFile[CountExes]);
    FindNext(DirInfo);
  end;
  SortEm;
  TotalExes:= TotalExes + CountExes;
end;

procedure Run(ProgName: string);
begin
  SwapVectors;
  Exec(GetEnv('COMSPEC'), '/C ' + ProgName);
  SwapVectors;
  if DosError <> 0 then
    WriteLn('Could not execute COMMAND.COM');
end;

procedure Spaces(S: string);
var
  LenSpace, I: integer;
begin
  LenSpace:= 10 - Length(S);
  For I:= 1 to LenSpace do Write(' ');
end;

procedure DoWhatever;
var
  FileNum, LenSpace,
  X, Y1, Y2, I: integer;
  Ch: char;
begin
  FindTheExes(AskDir);
  FileNum:= 1;
  X:= 3;  Y1:= 2;  Y2:= 2;
  TextColor(Yellow);
  TextBackGround(Magenta);
  GoToXY(X, Y2); Write('  ', ExeFile[FileNum]);
  Spaces(ExeFile[FileNum]);
  TextColor(White);
  TextBackGround(Blue);
  GoToXY(67, 1); Write(FileNum, ' ');
  While Key.Key <> Esc do
  begin
    Key.GetKeys;
    TextColor(LightGray);
    TextBackGround(Blue);
    GoToXY(X, Y1); Write('  ', ExeFile[FileNum]);
    Spaces(ExeFile[FileNum]);
    if Key.Key = Down then
      begin
      if FileNum < TotalExes then
        begin
          Inc(FileNum);
          Inc(Y2);
          if Y2 > 22 then
          begin
            Y2:= 2;
            Inc(X, 12);
          end;
        end;
      end;
    if Key.Key = Up then
      begin
      if FileNum > 1 then
      begin
        Dec(FileNum);
        Dec(Y2);
        if Y2 < 2 then
          begin
            Y2:= 22;
            Dec(X, 12);
          end;
      end;
      end;
    if Key.Key = Space then
    begin
      FileNum:= 1;
      X:= 3;  Y2:= 2;
      FindTheExes(AskDir);
    end;
    if Key.Key = Enter then
    begin
      Run(ExeFile[FileNum]);
      While KeyPressed do ReadKey;
      Screen;
      FindTheExes(Directory);
    end;
    TextColor(Yellow);
    TextBackGround(Magenta);
    GoToXY(X, Y2); Write('  ', ExeFile[FileNum]);
    Spaces(ExeFile[FileNum]);
    Y1:= Y2;
    TextColor(White);
    TextBackGround(Blue);
    GoToXY(67, 1); Write(FileNum, ' ');
  end;
end;

begin
  Screen;
  DoWhatever;
  NormCursor;
  Window(1, 1, 80, 25);
  ClrScr;
end.
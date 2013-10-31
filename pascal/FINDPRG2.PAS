{$M 32192,0,0}           { Leave memory for child process }
program FileList;
uses
  Crt, Dos,
  Buttons, Cursor;

const
  MaxDirSize = 300;

type
  TypeOfFiles = (DIR, PROG);
  TApplication = object
    procedure Init;
    procedure Run;
    procedure Done;
  end;
  TFile = object
    Name: string[8];
    FileType: TypeOfFiles;
    procedure Clear;
    procedure Add(HName: string; Attributes: Byte);
    procedure WriteName;
    procedure Run;
  end;
  TList = object
    Files: array[1..MaxDirSize] of TFile;
    DirInfo: SearchRec;
    Directry: string[80];
    Selected,
    Count, TotalFiles: integer;
    procedure Screen;
    procedure NewList;
    procedure FindList(HDirectry, HPath: string; HAttr: Byte);
    procedure DisplayList;
    procedure Select;
    procedure DosShell;
    procedure ParentDir;
    procedure Memory;
    function Dir: string;
  end;

var
  I, X, Y: integer;
  FileViewer: TApplication;
  FirstDirectory: TList;

procedure TFile.Clear;
begin
  Name:= '';
  FileType:= DIR;
end;

procedure TFile.Add;
begin
  Clear;
  I:= 1;
  Repeat
    Insert(HName[I], Name, Length(Name) + 1);
    Inc(I);
  Until (HName[I] = '.') or (I = Length(HName) + 1);
  if (HName[I] = '.') and (HName[I - 1] = '.') and (Length(HName) = 2) then
    Insert(HName[I], Name, Length(Name) + 1);
  if Attributes = Archive then FileType:= PROG;
  if Attributes = Directory then FileType:= DIR;
end;

procedure TFile.WriteName;
begin
  if FileType = DIR then TextColor(LightGray)
  else TextColor(Yellow);
  Write('  ', Name);
  For I:= Length(Name) to 9 do Write(' ');
end;

procedure TFile.Run;
var
  ChangeDir: string[80];
begin
  if FileType = PROG then
  begin
    SwapVectors;
    Exec(GetEnv('COMSPEC'), '/C ' + Name);
    SwapVectors;
    if DosError <> 0 then
      WriteLn('Could not execute COMMAND.COM');
    FirstDirectory.Screen;
    FirstDirectory.DisplayList;
  end;
  if FileType = DIR then
  begin
    ChangeDir:= FirstDirectory.Dir;
    FirstDirectory.Screen;
    FirstDirectory.NewList;
    FirstDirectory.FindList(ChangeDir + Name, '*.'#0#0#0, Directory);
    FirstDirectory.FindList('', '*.COM', Archive);
    FirstDirectory.FindList('', '*.EXE', Archive);
    FirstDirectory.DisplayList;
  end;
end;

procedure TList.Screen;
begin
  Window(1, 1, 80, 25);
  TextColor(DarkGray);
  TextBackGround(Cyan);
  ClrScr;
  GoToXY(30, 1); Write('Program Finder');
  GoToXY(1, 25);
  TextColor(LightRed);  Write('KEYS:');
  TextColor(Black);     Write('  Arrows to scroll');
  TextColor(Yellow);    Write('  Enter');
  TextColor(Black);     Write(' - Run selection');
  TextColor(Yellow);    Write('   Space');
  TextColor(Black);     Write(' - Dos Shell');
  TextColor(Yellow);    Write('  ESC');
  TextColor(Black);     Write(' - Quit');
  Window(1, 2, 80, 24);
  TextColor(LightGray);
  TextBackGround(Blue);
  ClrScr;
  NoCursor;
end;

procedure TList.NewList;
begin
  Count:= 0;
  TotalFiles:= 0;
  Directry:= '';
end;

procedure TList.FindList;
begin
  Directry:= HDirectry;
  ChDir(Directry);
  FindFirst(HPath, HAttr, DirInfo);
  While (DosError = 0) and (Count < MaxDirSize) do
  begin
    Inc(Count);
    Files[TotalFiles + Count].Add(DirInfo.Name, HAttr);
    FindNext(DirInfo);
  end;
  TotalFiles:= TotalFiles + Count;
  Count:= 0;
end;

procedure TList.DisplayList;
begin
  X:= 5;  Y:= 2;
  Count:= 0;
  Repeat
    GoToXY(X, Y);
    Inc(Count);
    Files[Count].WriteName;
    Inc(Y);
    if Y > 22 then
      begin
        Y:= 2;
        Inc(X, 12);
      end;
  Until Count >= TotalFiles;
  X:= 5;  Y:= 2;
  Count:= 1;
end;

procedure TList.DosShell;
begin
  SwapVectors;
  Window(1, 1, 80, 25);
  TextBackGround(Blue);
  ClrScr;
  NormCursor;
  Writeln('Type EXIT to return to Program Finder.');
  Exec(GetEnv('COMSPEC'), '/C ' + 'C:\COMMAND.COM');
  SwapVectors;
  if DosError <> 0 then
  begin
    WriteLn('Could not execute COMMAND.COM');
    Readln;
  end;
  NoCursor;
  Screen;
  NewList;
  FindList('', '*.'#0#0#0, Directory);
  FindList('', '*.COM' + '*.EXE', Archive);
  DisplayList;
end;

procedure TList.Select;
var
  OldCount, Xx, Yy: integer;
begin
  X:= 5;
  Y:= 2;
  Count:= 1;
  TextBackGround(Magenta);
  GoToXY(X, Y);  Files[Count].WriteName;
  While Key.Key <> Esc do
  begin
    Key.GetKeys;
    Xx:= X;
    Yy:= Y;
    OldCount:= Count;
    if Key.Key = Down then
      begin
        if Count < TotalFiles then
        begin
          Inc(Count);
          Inc(Y);
          if Y > 22 then
          begin
            Inc(X, 12);
            Y:= 2;
          end;
        end;
      end;
    if Key.Key = Up then
      begin
        if Count > 1 then
        begin
          Dec(Count);
          Dec(Y);
          if Y < 2 then
          begin
            Y:= 22;
            Dec(X, 12);
          end;
        end;
      end;
    if Key.Key = Home then
      begin
        Count:= 1;
        X:= 5;  Y:= 2;
      end;
    if Key.Key = _End then
      begin
        Repeat
          Inc(Count);
          Inc(Y);
          if Y > 22 then
          begin
            Y:= 2;
            Inc(X, 12);
          end;
        Until Count = TotalFiles;
      end;
   if Key.Key = Left then
     if Count - 21 > 0 then
      begin
          Dec(Count, 21);
        Dec(X, 12);
      end;
   if Key.Key = Right then
     if Count + 21 <= TotalFiles then
     begin
       Inc(Count, 21);
       Inc(X, 12);
     end;
   if Key.Key = F5 then Memory;
   if Key.Key = Enter then Files[Count].Run
    else
      if Key.Key = Space then DosShell
        else
          begin
            TextBackGround(Blue);
            GoToXY(Xx, Yy);  Files[OldCount].WriteName;
          end;
    TextBackGround(Magenta);
    GoToXY(X, Y);  Files[Count].WriteName;
  end;
end;

procedure TList.ParentDir;
begin
  Screen;
  NewList;
  FindList('..', '*.'#0#0#0, Directory);
  FindList('', '*.COM', Archive);
  FindList('', '*.EXE', Archive);
  DisplayList;
end;

procedure TList.Memory;
begin
  TextBackGround(Black);
  Window(21, 10, 62, 20);
  ClrScr;
  TextBackGround(LightGray);
  Window(19, 9, 60, 19);
  ClrScr;
  TextColor(Yellow);
  GoToXY (10, 2); Writeln ('MEMORY & DISK INFORMATION');
  TextColor(Blue);
  GoToXY (19, 4);  Writeln ('Memory:');
  GoToXY(9, 5); Write(MemAvail:8,' bytes free');
  TextColor(Black);
  GoToXY(5, 7); Write('Free Disk Space: ', DiskFree(0):12, ' bytes');
  GoToXY(5, 8); Write('of Disk Size: ', DiskSize(0):15, ' bytes.');
  TextColor(LightRed);
  GoToXY(16, 10); Write('Press a key...');
  Readkey;
  Screen;
  DisplayList;
end;

function TList.Dir: string;
begin
  Dir:= Directry;
end;

procedure TApplication.Init;
begin
end;

procedure TApplication.Run;
begin
  FirstDirectory.Screen;
  FirstDirectory.NewList;
  FirstDirectory.FindList('', '*.'#0#0#0, Directory);
  FirstDirectory.FindList('', '*.COM', Archive);
  FirstDirectory.FindList('', '*.EXE', Archive);
  FirstDirectory.DisplayList;
  FirstDirectory.Select;
end;

procedure TApplication.Done;
begin
  TextColor(LightGray);
  TextBackGround(Black);
  Window(1, 1, 80, 25);
  ClrScr;
  NormCursor;
end;

begin
  FileViewer.Init;
  FileViewer.Run;
  FileViewer.Done;
end.
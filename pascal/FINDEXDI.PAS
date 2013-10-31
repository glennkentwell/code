program Hopeful;
uses
  Crt, Dos;

const
  MaxDirSize = 1024;

var
  F: text;
  Path: String;
  Count,
  TotalExes,
  CountExes, CountDirs: integer;
  DirInfo: SearchRec;
  FileNameBuf: string;
  ExeFile: array[1..200] of string[90];
  Directories: array[1..100] of string[90];

procedure FindTheExes(Directry: string);
var
  Dire: string;
begin
  Dire:= 'C:\' + Directry;
  ChDir(Dire);
  Writeln(F, ' ');
  Writeln(F, 'Directory : ', Dire);
  Path:= '*.EXE';
  Count := 0;
  CountExes:= 0;
  FindFirst(Path, ReadOnly + Archive, DirInfo);
  while (DosError = 0) and (Count < MaxDirSize) do
  begin
    Inc(Count);
    Inc(CountExes);
    ExeFile[CountExes]:= DirInfo.Name;
    Write(ExeFile[CountExes],' ');
    Writeln(F, ExeFile[CountExes],' ');
    FindNext(DirInfo);
  end;
  TotalExes:= TotalExes + CountExes;
  Writeln(F, CountExes,' EXE files in directory ', Dire);
end;

procedure FindTheSubDirs(Directry, CurDir: string);
var
  Dire: string;
begin
  Dire:= 'C:\' + Directry;
  ChDir(Dire);
  Path:= '*.';
  FindFirst(Path, Directory, DirInfo);
  while (DosError = 0) and (Count < MaxDirSize) do
  begin
    if (DirInfo.Name <> '.') and (DirInfo.Name <> '..') then
    Directories[CountDirs]:= Directry + '\' + DirInfo.Name;
    Writeln(DirInfo.Name,' ');
    Inc(Count);
    Inc(CountDirs);
    FindNext(DirInfo);
  end;
  ChDir(CurDir);
end;

procedure FindTheDirs;
var
  I: integer;
  CurDir: string[80];
begin
  ClrScr;
  Path:= '*.';
  GetDir(0, CurDir);
  CountDirs:= 1;
  FindFirst(Path, Directory, DirInfo);
  while (DosError = 0) and (Count < MaxDirSize) do
  begin
    Directories[CountDirs]:= DirInfo.Name;
    Writeln(DirInfo.Name,' ');
    Inc(Count);
    Inc(CountDirs);
    FindTheSubDirs(DirInfo.Name, CurDir);
    FindNext(DirInfo);
  end;
  For I:= 1 to CountDirs do
    FindTheExes(Directories[I]);
end;

begin
  Assign(F, '\glenns\exefiles.txt');
  Rewrite(F);
  ChDir('C:\');
  TotalExes:= 0;
  FindTheDirs;
  Writeln(F, '');
  Writeln(F, 'Total EXE files on drive : ', TotalExes);
  Close(F);
end.
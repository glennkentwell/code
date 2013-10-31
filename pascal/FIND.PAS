Program Cool;
Uses Dos;
Var DirInfo : SearchRec;
  Dirs : Array[1..50] of string[80];
  I, J, T : integer;
  DirD : string;
begin
  ChDir ('\');
  FindFirst ('*.*',Directory, DirInfo);
  I := 1;
  While DosError = 0 do
  begin
    if DirInfo.Attr = Directory then
    begin
      Dirs[I] := DirInfo.Name;
      Inc(I);
    end;
    FindNext(DirInfo);
   end;
  FindFirst (ParamStr(1),AnyFile,DirInfo);
  While DosError = 0 do
  begin
    Writeln ('Found as  \',DirInfo.Name);
    FindNext (DirInfo);
  end;
  For J := 1 to I do
  begin
    DirD := '\' + Dirs[J];
    ChDir(DirD);
    FindFirst (ParamStr(1),AnyFile,DirInfo);
    While DosError = 0 do
    begin

      Writeln ('Found as \',Dirs[J],'\',DirInfo.Name,'   ',DirInfo.Size,' bytes.');
      FindNext (DirInfo);
    end;
  end;
end.

program NoCarriageReturns;
uses
  Crt;

const
  FileNamePrompt = 'Filename : ';
  NewFileNamePrompt = 'New Filename : ';
  Blank: char = ' ';
  MaxChars = 16036;
var
  Txt: file;
  Count: Word;
  C: char;
  X, Y, NumChars: integer;
  Ch: array[1..MaxChars] of ^char;
  FileName, NewFileName: string;

procedure OpenFileToRead;
begin
  ClrScr;
  Write(FileNamePrompt);
  Readln(FileName);
  Write(NewFileNamePrompt);
  Readln(NewFileName);
  Assign(Txt, FileName);
  Reset(Txt, 1);
end;

procedure OpenFileToWrite;
var
  OtherFileName: string[8];
begin
  Assign(Txt, NewFileName);
  Rewrite(Txt, 1);
end;

procedure CloseFile;
begin
  Close(Txt);
end;

procedure ReadFile;
begin
  X:= 0;
  Count:= 1;
  While (not Eof(Txt)) and (X < MaxChars) do
  begin
    Inc(X);
    BlockRead(Txt, C, Count);
    GetMem(Ch[X], 1);
    Ch[X]^:= C;
    Write(Ch[X]^);
  end;
  NumChars:= X;
end;

procedure WriteFile;
begin
  X:= 0;
  While X <= NumChars do
  begin
    Inc(X);
    if (Ch[X]^ <> #13) and (Ch[X]^ <> #10) and (Ch[X]^ <> #12) then
      BlockWrite(Txt, Ch[X]^, Count)
      else if (Ch[X]^ = #13) and (Ch[X + 1]^ = #10) then
      begin
        BlockWrite(Txt, Ch[X]^, Count);
        BlockWrite(Txt, Ch[X + 1]^, Count);
      end;
  end;
end;

begin
  OpenFileToRead;
  ReadFile;
  CloseFile;
  OpenFileToWrite;
  WriteFile;
  CloseFile;
end.


program RudeDos;
Uses Crt, Dos;
const
  Answer: array[0..20] of string = ('Get Stuffed!',
                                    'No, I won''t do that',
                                    'That costs money!',
                                    'Nuh, I''m not doin'' that for ya.',
                                    'What do you think I am, a supercomputer?',
                                    'Learn how to use DOS, why dontcha?',
                                    'Blah, blah, blah, whatever!',
                                    'I said NO, DAMMIT!',
                                    'That WON''T work!!',
                                    'Don''t you EVER try that AGAIN!',
                                    'Don''t bother trying again!',
                                    'Back Orf!',
                                    'Eh?',
                                    'Spludge!',
                                    'What?',
                                    'This ain''t Windows 95 here, sonny!',
                                    'Slow down, I''m only 16 megahertz!',
                                    'Welcome to RudeDOS.',
                                    'Dream on!',
                                    'Don''t you get the hint, yet?  You can''t use me!',
                                    'Bleep, Bleep, blop blip bloop blan blah, I am a very slow computah.');
Var
  Dir, Str: string;
  Ch: Char;
  I: integer;

procedure RecognizeCommand;
begin
  if (Str = 'cls') or (Str = 'CLS') then
  begin
    ClrScr;
    Str:= '';
  end;
end;

procedure FindComment;
begin
  RecognizeCommand;
  Randomize;
  if Str <> '' then
  begin
    I:= Random(20);
    WriteLn(Answer[I]);
    WriteLn;
  end;
end;

procedure FindKey;
begin
  if Ch = #0 then
    Ch:= ReadKey;
  if Ch = #65 then Ch:= #1;
  if Ch in ['A'..'Z', 'a'..'z', ' ', '.', ',', '/', '\'] then
  begin
    Write(Ch);
    Insert(Ch, Str, Length(Str) + 1);
  end;
  if Ch = #8 then
  begin
    GoToXY(WhereX - 1, WhereY);
    Write(' ');
    GoToXY(WhereX - 1, WhereY);
  end;
  if Ch = #27 then
  begin
    GoToXY(WhereX - Length(Str), WhereY);
    For I:= 1 to Length(Str) do
    Write(' ');
    GoToXY(WhereX - Length(Str), WhereY);
    Str:= '';
  end;
end;

procedure GetCommand;
begin
  GetDir(0, Dir);
  Write(Dir, '>');
  Str:= '';
  Repeat
    Ch:= ReadKey;
    FindKey;
  Until (Ch = #13) or (Ch = #1);
  WriteLn;
  if Ch <> #1 then Ch:= #0;
end;

begin
  ClrScr;
  Randomize;
  Repeat
    GetCommand;
    FindComment;
  Until Ch = #1;
end.


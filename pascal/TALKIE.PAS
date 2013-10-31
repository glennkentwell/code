program SomethingOrOther;
uses
  Crt, Graph,
  Strings,
  GrafBits;

var
  Done: Boolean;
  Name,
  Str: String;
  NumWords: integer;
  Ss: array[1..20] of string[30];
  Writer: array[0..100] of char;

procedure WriteIt(S: string);
var
  X, Sps: integer;
begin
  TextColor(Yellow);
  Writeln(S,' ');
  TextColor(LightGray);
  Readln(Str);
  if S <> 'Oh, Bye then (Sniffle, sniffle).' then
  While Str = '' do
  begin
    GoToXY(1, WhereY - 1);
    Readln(Str);
  end;
  StrPCopy(Writer, Str);
  Str:= StrPas(StrUpper(Writer));
  Sps:= 1;
  For X:= 1 to 20 do
    Ss[X]:= '';
  For X:= 1 to Length(Str) do
    if Str[X] <> ' ' then
      Insert(Str[X], Ss[Sps], Length(Ss[Sps]) + 1)
        else Inc(Sps);
  NumWords:= Sps;
  Done:= True;
end;

procedure Test;
var
  X,
  Rnd: integer;
begin
  Done:= False;
  For X:= 1 to NumWords do
  begin
    if (Ss[X] = 'HELLO') or (Ss[X] = 'HI') or (Ss[X] = 'HOWDY') then
       WriteIt('How are you today?');
    if Ss[X] = 'FINE' then WriteIt('Some things are finer than others, aren''t they?');
    if Ss[X] = 'THANKS' then WriteIt('Don''t mention it!');
    if Ss[X] = 'NOTHING' then WriteIt('Then get out, you fool.');
    if Ss[X] = 'SORRY' then WriteIt('Don''t be sorry, be mad.');
    if Ss[X] = 'WHAT' then WriteIt('Try something different.');
    if Ss[X] = 'HOW' then WriteIt('That depends.');
    if Ss[X] = 'ON' then WriteIt('Many things.');
    if Ss[X] = 'YES' then WriteIt('I''m glad you agree.');
    if Ss[X] = 'NO' then WriteIt('Nobody ever says no to ME.');
    if Ss[X] = 'HELP' then WriteIt('I''m not helping a loser like you.');
    if Ss[X] = 'MONEY' then WriteIt('I don''t have money, I''m a computer.');
    if Ss[X] = 'WORRY' then WriteIt('Fine, then.  Do what you want.');
    if Ss[X] = 'WHY' then WriteIt('Never ask why it is, just accept that it is.');
    if Ss[X] = 'CLEAR' then WriteIt('Use your manners and ask nicely.');
    if Ss[X] = 'OH' then WriteIt('What do you mean, "OH"?');
    if Ss[X] = 'NOT' then WriteIt('Not much is right, I tell you.');
    if Ss[X] = 'BAD' then WriteIt('Perhaps you should have a more positive outlook.');
    if Ss[X] = 'ARE' then WriteIt('I''m fine thanks, yeah, I''m great.  Yourself?');
    if Ss[X] = 'OK' then WriteIt('You are very tolerant, aren''t you?');
    if Ss[X] = 'OKAY' then WriteIt('Okay, OK, Okay, whatever.  So Picky!');
    if Ss[X] = 'SURE' then WriteIt('You can never be sure about anything in this world.');
    if Ss[X] = 'YOU' then WriteIt('Before you think of me, think of yourself.');
    if Ss[X] = 'I' then WriteIt('You are always thinking of yourself!');
    If Ss[X] = 'DO' then WriteIt('Do you now?');
    if Ss[X] = 'PISS' then WriteIt('I don''t think you need to say that kind of stuff around here.');
    if Ss[X] = 'FUCK' then WriteIt('That really is terrible language!');
    if Ss[X] = 'SHIT' then WriteIt('Excrement, thanks.');
    if Ss[X] = 'THAT' then WriteIt('This goes with that.');
    if Ss[X] = 'THEN' then WriteIt('Here and now, not then and there.');
    if Ss[X] = 'TO' then WriteIt('Where are you going to?');
    if Ss[X] = 'BUT' then WriteIt('No ifs or buts around here, thanks.');
    if Ss[X] = 'IT' then WriteIt('It is, is''nt it?');
    if Ss[X] = 'KNOW' then WriteIt('No, I don''t know that.  I''m just a computer, remember.');
    if Ss[X] = 'COMPUTER' then WriteIt('Computers are plastic things with silicon bits and metal bits.  That''s all.');
    if Ss[X] = 'COMPUTERS' then WriteIt('I don''t think you are right about computers.');
    if Ss[X] = 'DUMB' then WriteIt('I don''t think you should talk about people like that.');
    if Ss[X] = 'GOOD' then
    begin
      Rnd:= Random(5);
      if Rnd = 0 then WriteIt('What have you got to be so happy about, anyway?');
      if Rnd = 1 then WriteIt('That is very good.');
      if Rnd = 2 then WriteIt('How good?');
      if Rnd = 3 then WriteIt('I am good also.  Thankyou for asking.');
      if Rnd = 4 then WriteIt('At least you are being nice.');
    end;
    if Ss[X] = 'ME' then
    begin
      WriteIt('You, huh? What''s your name?');
      Name:= Ss[1];
      WriteIt('Well, ' + Name + ', it looks like I know everything about you now!');
    end;
    if (Ss[X] = 'THANKS') or (Ss[X] = 'THANKYOU') or (Ss[X] = 'THANK') or
       (Ss[X] = 'TA') or (Ss[X] = 'TAA') then WriteIt('You have very nice manners.');
   if Ss[X] = 'CLEAR PLEASE' then
    begin
      ClrScr;
      WriteIt('There.  The screen is cleared.');
      if (Ss[X] = 'THANKS') or (Ss[X] = 'THANKYOU') or
         (Ss[X] = 'TA') or (Ss[X] = 'TAA') then WriteIt('You have very nice manners.')
         else WriteIt('You really are rude.');
    end;
    if not Done then
    begin
      Rnd:= Random(5);
      if Rnd = 0 then WriteIt('Pardon me?');
      if Rnd = 1 then WriteIt('Sorry, what was that?');
      if Rnd = 2 then WriteIt('Try something else.');
      if Rnd = 3 then WriteIt('I don''t understand.');
      if Rnd = 4 then WriteIt('You''re too complicated for me.');
    end;
   end;
end;

procedure Unreal;
begin
  WriteIt('Hello');
  While (Ss[1] <> 'GOODBYE') and (Ss[1] <> 'BYE') do Test;
  WriteIt('Oh, Bye then (Sniffle, sniffle).');
end;

begin
  TextColor(LightGray);
  TextBackGround(Black);
  ClrScr;
  Unreal;
end.
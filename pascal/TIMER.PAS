program Timer;
uses Crt, Dos;

var
  Hr, Min, Sec, Hnd: integer;
  h, m,
  SNow, s, hund : Word;

function LeadingZero(w : Word) : String;
var
  s : String;
begin
  Str(w:0,s);
  if Length(s) = 1 then
    s := '0' + s;
  LeadingZero := s;
end;

begin
  TextColor(Blue);
  TextBackGround(Blue);
  ClrScr;
  TextColor(Yellow);
  Hr:= 0;
  Min:= 0;
  Sec:= 0;
  ReadKey;
  GetTime(h,m,s,hund);
  SNow:= S;
  While not KeyPressed do
  begin
    GetTime(h,m,s,hund);
    GoToXY(1, 1);
    Writeln(LeadingZero(H),':', LeadingZero(M),':', LeadingZero(S),'.',LeadingZero(hund));
{    if S <> SNow then
    begin
      Inc(Sec);
      SNow:= S;
    end;
    if Sec > 59 then
    begin
      Inc(Min);
      Sec:= 0;
    end;
    if Min > 59 then
    begin
      Inc(Hr);
      Min:= 0;
    end;
    if Hr > 24 then Hr:= 0;
    GoToXY(1, 1);
    Writeln(LeadingZero(Hr),':', LeadingZero(Min),':', LeadingZero(Sec));}
  end;
end.
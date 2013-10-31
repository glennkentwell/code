unit DatsTime;

interface
  procedure FindDate;
  procedure FindTime;
  procedure WriteTime (Exx, Why : integer; GetIt : integer);
  procedure WriteDate (Exx, Why : integer; GetIt : integer);
  function LeadingZero(w: Word) : string;

const
  days : array [0..6] of String[9] = ('Sunday','Monday','Tuesday',
                        'Wednesday','Thursday','Friday','Saturday');
var
  h, min, sec, hund : Word;
  y, m, d, dow : Word;
  AmOrPm, s : String;

implementation
uses crt, dos;

procedure FindDate;
begin
  GetDate(y,m,d,dow);
end;

function LeadingZero;
begin
  Str(w:0,s);
  if Length(s) = 1 then
    s := '0' + s;
  LeadingZero := s;
end;

procedure FindTime;
begin
  GetTime(h,min,sec,hund);
  if h > 11 then
  begin
    if h <> 12 then
    h := h - 12;
    AmOrPm := 'pm';
  end
    else AmOrPm := 'am';
end;

procedure WriteDate;
begin
  if GetIt = 1 then FindDate;
  GoToXY (Exx, Why);
  Write (days[dow],', ',d,'/',m,'/',y);
end;

procedure WriteTime;
begin
  if GetIt = 1 then FindTime;
  if Hund <= 5 then
  begin
    GoToXY (Exx, Why);
    Write((h),':',leadingZero(min),':',LeadingZero(sec),' ',AmOrPm);
  end;
end;
end.




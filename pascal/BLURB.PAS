program Blurb;
uses Crt, Cursor;
var
  Txt: Text;
  No: integer;
  Line: array[1..328] of string[80];

begin
  TextColor(White);
  TextBackGround(Black);
  NoCursor;
  ClrScr;
  Assign(Txt, 'BLURB.TXT');
  Reset(Txt);
  For No:= 1 to 328 do
    Readln(Txt, Line[No]);
  Close(Txt);
  No:= 1;
  While not KeyPressed do
  begin
    Writeln(Line[No]);
    Delay(5);
    Inc(No);
    if No > 328 then No:= 1;
  end;
  NormCursor;
end.
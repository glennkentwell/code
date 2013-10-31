program TheCuntsCanEatShit;
uses Crt, Cursor;
const
  AFuckingLot = 20000000;
var
  F: text;
  X, Y, OldY: longint;

begin
  ClrScr;
  NoCursor;
  Assign(F, 's.txt');
  ReWrite(F);
  Writeln('eAtShIt is fucking copyrighted');
  Writeln('so don''t fucking copy it, right?');
  Writeln;
  Write('Completed ' );
  For X:= 1 to AFuckingLot do
  begin
    Write(F, 's');
    Inc(OldY);
    if OldY = 200000 then
    begin
      Y:= Round((X / AFuckingLot) * 100);
      OldY:= 0;
      GotoXY(13, 4);
      Write(Y:3,'%');
    end;
  end;
  Close(F);
  NormCursor;
  if Keypressed then ReadKey;
end.
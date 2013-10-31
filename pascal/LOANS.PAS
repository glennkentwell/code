program what;
Uses Graph, Crt, GrafBits;
var
  NumPayments,  Payment,
  Total, Principal, Rate: real;
  Calcs, Term,
  X, Y: integer;

procedure Calculate;
var
  Rater: real;
begin
  Case Calcs of
    1: Calcs:= 1;
    2: Calcs:= 12;
    3: Calcs:= 365;
  end;
  Rater:= ((Rate/100)/Calcs) + 1;
  Total:= Rater;
  For X:= 1 to Term - 1 do
    Total:= Total * Rater;
  Total:= Total * Principal;
  Payment:= Total / NumPayments;
end;

procedure GetValuesScreen;
begin
  ClrScr;
  GoToXY(10, 5); Write('           Starting Amount: ');
  GoToXY(10, 7); Write('Rate of interest per annum: ');
  GoToXY(10, 9); Write('          Number of terms : ');
  GoToXY(10, 11); Write('       Interest calculated: ');
  GoToXY(10, 12); Write('1. Annually   2.  Monthly  3. Daily');
  GoToXY(10, 14); Write('        Number of payments: ');
end;

procedure GetValues;
begin
  GetValuesScreen;
  GoToXY(38, 5); ReadLn(Principal);
  GoToXY(38, 7); ReadLn(Rate);
  GoToXY(38, 9); ReadLn(Term);
  GoToXY(38, 11); ReadLn(Calcs);
  GoToXY(38, 14); ReadLn(NumPayments);
end;

procedure WriteStuffOut;
begin
  GoToXY(10, 17); Write('Total amount at end of term = $', Total:6:2);
  GoToXY(10, 19); Write('Interest earned = $', Total - Principal:6:2);
  GoToXY(10, 21); Write('Each payment = $', Payment:6:2);
  GoToXY(20, 25); Write('Press a key.');
  ReadKey;
end;

begin
  GetValues;
  Calculate;
  WriteStuffOut;
end.

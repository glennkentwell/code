(*
   Glenn Kentwell  97060941
   Computer Science 1
   Semester 1 1997
   Tutorial 6  (Monday 5-6pm)
   Program to calculate the deposit required for a loan.
*)
program CalcDeposit;
uses Crt;
const
  MidAddOn = 1250;     { $1250 is added to deposit if $25,000 < loan < $50000}
  HiAddOn = 5000;      { $5000 is added to deposit if $50,000 < loan < $100,000}
  LowPercent = 0.05;   { deposit is 5% of loan amount if loan < $25,000 }
  MidPercent = 0.10;   { deposit is 10% if between $25,000 and $50,000 }
  HiPercent = 0.25;    { deposit is 25% if between $50,000 and $100,000 }
  LowBracket = 25000;  { loans less than $25,000  }
  MidBracket = 50000;  { loans less than $50,000  }
  HiBracket = 100000;  { loans less than $100,000 }
  InvalidLoan = -1;    { variable Deposit is given this value if loan > 100,000}
  LoanPrompt = 'Amount of loan : ';
  DepositAnswer = 'The deposit required is $';
  AnotherQuery = 'Calculate another deposit? [Y/n] ';
  LoanTooHigh = 'Sorry, I can only calculate deposits for loans $100,000 or less';
var
  LoanAmount, Deposit: longint;

procedure CalculateDeposit;
(*  This procedure calculates the deposit required depending on the size
    of the loan requested.                                                 *)
begin
  If LoanAmount < LowBracket then
    Deposit:= Round(LoanAmount * LowPercent)
    else
    If (LoanAmount >= LowBracket) and (LoanAmount < MidBracket) then
      Deposit:= Round((LoanAmount - LowBracket) * MidPercent) + MidAddOn
    else
    If (LoanAmount >= MidBracket) and (LoanAmount <= HiBracket) then
      Deposit:= Round((LoanAmount - MidBracket) * HiPercent) + HiAddOn
    else
      If LoanAmount > HiBracket then Deposit:= InvalidLoan;
end;

procedure GiveAnswer;
(*  This procedure writes the amount of the deposit to the screen if the
    variable Deposit is not -1, ie the loan was more than $100,000      *)
begin
  if Deposit <> InvalidLoan then
    Write(DepositAnswer, Deposit)
  else Write(LoanTooHigh);
end;

function Loans: Boolean;
(*  This function prompts the user for a loan amount, calls the procedures
    CalculateDeposit and GiveAnswer, then asks the user if they want to
    calculate another deposit.  If the user presses the 'n' key on the
    keyboard, this function is assigned the value False, otherwise it is
    given the value True.                                                *)
var
  Ch: char;
begin
  Write(LoanPrompt);
  Readln(LoanAmount);
  CalculateDeposit;
  GiveAnswer;
  Writeln;
  Write(AnotherQuery);
  Ch:= ReadKey;
  if UpCase(Ch) <> 'N' then
    Loans:= True
    else Loans:= False;
  Writeln;
end;

(*  The main program part clears the screen, then calls the function Loans.
    Loans is called repeatedly until it becomes False, then the program ends.
*)
begin
  ClrScr;
  While Loans do
    Loans;
end.

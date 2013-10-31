(*
  Jarrett Yap 97045843
  Computer Science 1
  Semester 1 1997
  Assignment 3
  Sales Report
*)
program SalesFileReader;
uses Crt, Printer;
const
  TopTitle = '                            MULTI-DISK COMPUTER COMPANY';
  Title2 = '                              SALES REPORT';
  TitleLineOne = 'SALESPERSON   SALESPERSON         PRODUCT     QTY     PRICE   EXTENSION';
  TitleLineTwo = 'NUMBER        NAME                CODE        SOLD            AMOUNT';
  TotalFor = '  TOTAL FOR';
  TotalForReport = '  TOTAL FOR REPORT  ';
  FileName = 'saledata.dat';       { This is the name of the data file. }

Type
   EmployeeID   = 1000 .. 9999;
   ProductCode  = 1000 .. 9999;
   SalesRecord  = Record
     SalespersonNo      : EmployeeID;
     SalespersonName    : String [11];
     ProductNo          : ProductCode;
     QuantitySold       : Integer;
     UnitPrice          : Real;
   End {SalesRecord};

var
  Sale: SalesRecord;
  CurrentNo, PrevNo: integer;  { These integers determine whether to
                                 calculate the subtotal for each salesperson
                               }
  PrevName: string;            { Used to store the last salesperson's name }
  SalesTotal, SubTotal: Real;  { Used to calculate the total sales }
  SalesFile: file of SalesRecord; { File variable for the salesfile }
  Day, Month, Year: shortint;    { Store the date typed in by user }
  Extension: Real;               { Stores Price * units sold for each sale }

procedure Setup;
{ This procedure clears the screen, opens the data file for reading, and
prompts the user for the date.  It also writes the headings of the sales
report to the screen.
}
begin
  ClrScr;
  SalesTotal:= 0;
  SubTotal:= 0;
  Assign(SalesFile, FileName);
  Reset(SalesFile);
  Write('Date: ');
  Readln(Day, Month, Year);
  ClrScr;
  Writeln(Lst, TopTitle);
  Write(Lst, Day,'/', Month,'/', Year);
  Writeln(Lst, Title2);
  Writeln(Lst);
  Writeln(Lst, TitleLineOne);
  Writeln(Lst, TitleLineTwo);
  Writeln(Lst);
end;

procedure ReadFromFile;
begin
  Read(SalesFile, Sale);
end;

procedure PrintDetails;
{ Send sales details to printer }
begin
  Write(Lst,Sale.SalesPersonNo, '           ');
  Write(Lst,Sale.SalesPersonName, '        ' );
  Write(Lst,Sale.ProductNo,'       ');
  Write(Lst,Sale.QuantitySold:2,'      ');
  Write(Lst,Sale.UnitPrice:6:2,' ');
  Writeln(Lst, Extension:8:2);
end;

procedure DoTheMaths;
{ Calculates the extension and sales amount }
begin
  Extension:= Sale.QuantitySold * Sale.UnitPrice;
  SubTotal:= SubTotal + Extension;
end;

procedure WriteSubTotal;
{ Prints the subtotal for each sales person }
begin
  Writeln(Lst);
  Write(Lst,TotalFor);
  Write(Lst,PrevName,'                                    ');
  Writeln(Lst, SubTotal:10:2);
  Writeln(Lst);
end;

procedure CleanUp;
{ Close data file }
begin
  Close(SalesFile);
end;

begin
  Setup;
  ReadFromFile;
  PrevNo:= Sale.SalesPersonNo;
  CurrentNo:= Sale.SalesPersonNo;
  PrevName:= Sale.SalesPersonName;
  While not Eof(SalesFile) do
  begin
    ReadFromFile;
    CurrentNo:= Sale.SalesPersonNo;
    If PrevNo <> CurrentNo then
    begin
      WriteSubTotal;
      SalesTotal:= SalesTotal + SubTotal;
      SubTotal:= 0;
      PrevNo:= CurrentNo;
      PrevName:= Sale.SalesPersonName;
    end;
    DoTheMaths;
    PrintDetails;
  end; { WHILE }
  WriteSubTotal;
  SalesTotal:= SalesTotal + SubTotal;
  Write(Lst, TotalForReport,'                                      ', SalesTotal:10:2);
  CleanUp;
end.

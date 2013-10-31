program SalesFileReader;
uses Crt;
const
  TopTitle = '                          MULTI-DISK COMPUTER COMPANY';
  Title2 = '                            SALES REPORT';
  TitleLineOne = 'SALESPERSON   SALESPERSON     PRODUCT QTY     PRICE       EXTENSION';
  TitleLineTwo = 'NUMBER        NAME            CODE    SOLD                AMOUNT';
  TotalFor = '   TOTAL FOR ';
  TotalForReport = 'TOTAL FOR REPORT';
  FileName = 'saledata.dat';

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
  PageNo, CurrentNo, PrevNo: integer;
  PrevName: string;
  Extension,
  SalesTotal, SubTotal: real;
  SalesFile: file of SalesRecord;
  Day, Month, Year: shortint;

procedure Setup;
begin
  SalesTotal:= 0;
  SubTotal:= 0;
  Assign(SalesFile, FileName);
  Reset(SalesFile);
  Write('Date: ');
  Readln(Day, Month, Year);
  ClrScr;
  Writeln(TopTitle);
  Write(Day,'/', Month,'/', Year);
  Writeln(Title2);
  Writeln(TitleLineOne);
  Writeln(TitleLineTwo);
  Writeln;
end;

procedure ReadFromFile;
begin
  Read(SalesFile, Sale);
end;

procedure PrintDetails;
begin
  Write(Sale.SalesPersonNo);
  GoToXY(14, WhereY);
  Write(Sale.SalesPersonName);
  GoToXY(31, WhereY);
  Write(Sale.ProductNo);
  GoToXY(39, WhereY);
  Write(Sale.QuantitySold:2);
  GoToXY(47, WhereY);
  Write(Sale.UnitPrice:6:2);
  GoToXY(59, WhereY);
  Writeln(Extension:8:2);
end;

procedure DoTheMaths;
begin
  Extension:= Sale.UnitPrice * Sale.QuantitySold;
  SubTotal:= SubTotal + Extension;
  CurrentNo:= Sale.SalesPersonNo;
end;

procedure WriteTheSubTotal;
begin
  Writeln;
  Write(TotalFor);
  Write(PrevName);
  GoToXY(59, WhereY);
  Writeln(SubTotal:8:2);
  Writeln;
end;

procedure CleanUp;
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
    If PrevNo <> CurrentNo then
    begin
      WriteTheSubTotal;
      SubTotal:= 0;
      PrevNo:= CurrentNo;
      PrevName:= Sale.SalesPersonName;
    end;
    PrintDetails;
    SalesTotal:= SalesTotal + SubTotal;
    ReadFromFile;
    DoTheMaths;
  end; { WHILE }
  WriteTheSubTotal;
  SalesTotal:= SalesTotal + SubTotal;
  GoToXY(59, WhereY);
  Writeln;
  Write(SalesTotal:10:2);
  CleanUp;
end.

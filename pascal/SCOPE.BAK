program Sound;
uses Graph, Grafbits, Crt, Dsp, Cursor;
var
  LastX, LastY,
  X, Y: integer;
  Ch: char;
  Colour,
  Zoom, Del, Proc: integer;
  DiffProc: Boolean;

procedure TestBounds(var TheVar: integer; Min, Max: integer);
begin
  If TheVar < Min then TheVar:= Min;
  If TheVar > Max then TheVar:= Max;
end;

procedure RotateBounds(var TheVar: integer; Min, Max: integer);
begin
  If TheVar < Min then TheVar:= Max;
  If TheVar > Max then TheVar:= Min;
end;

procedure ChangeProc(NewProc: integer);
begin
  Proc:= NewProc;
  DiffProc:= True;
end;

procedure TestKeys;
begin
    Ch:= ReadKey;
    Case UpCase(Ch) of
      '1': ChangeProc(1);
      '2': ChangeProc(2);
      '3': ChangeProc(3);
      '4': ChangeProc(4);
      '5': ChangeProc(5);
      'H': ChangeProc(99);
      '+': Dec(Del);
      '-': Inc(Del);
      'Z': Inc(Zoom);
      'X': Dec(Zoom);
      'C': Inc(Colour);
      #27: DiffProc:= True;
     end;
    TestBounds(Del, 0, 100);
    TestBounds(Zoom, 1, 10);
    RotateBounds(Colour, 1, 15);
end;

procedure Lines;
begin
  DiffProc:= False;
  While not DiffProc do
  begin
  Repeat
    Inc(X);
    RotateBounds(X, 0, MaxX);
    LastX:= X;
    LastY:= Y;
    Y:= (ReadDAC - 128) div Zoom;
    SetColor(Black);
    Line(X, 0, X, MaxY);
    SetColor(Colour);
    Line(X, DivY + Y, LastX, DivY + LastY);
    Delay(Del);
  Until KeyPressed;
    TestKeys;
  end;
end;

procedure Dots;
begin
  SetColor(Black);
  DiffProc:= False;
  While not DiffProc do
  begin
  Repeat
    Inc(X);
    RotateBounds(X, 0, MaxX);
    Y:= (ReadDAC - 128) div Zoom;
    Line(X, 0, X, MaxY);
    PutPixel(X, DivY + Y, Colour);
    Delay(Del);
  Until KeyPressed;
    TestKeys;
  end;
end;

procedure Graphs;
begin
  DiffProc:= False;
  While not DiffProc do
  begin
  Repeat
    Inc(X);
    RotateBounds(X, 0, MaxX);
    Y:= ReadDAC div Zoom;
    SetColor(Black);
    Line(X, 0, X, MaxY);
    SetColor(Colour);
    Line(X, MaxY, X, MaxY - Y);
    Delay(Del);
  Until KeyPressed;
    TestKeys;
  end;
end;

procedure Cols256;
begin
  CloseGraph;
  VGA256;
  RGB256;
  DiffProc:= False;
  While not DiffProc do
  begin
    Repeat
      Inc(X);
      RotateBounds(X, 0, MaxX);
      Y:= ReadDAC div 4; {Optimum zoom level for smooth colour}
      SetColor(Black);
      Line(X, 0, X, MaxY);
      SetColor(Y);
      Line(X, MaxY, X, MaxY - Y);
      Delay(Del);
    Until KeyPressed;
    TestKeys;
  end;
  CloseGraph;
  VGA256;
end;

procedure Text;
begin
  CloseGraph;
  DiffProc:= False;
  While not DiffProc do
  begin
  Repeat
    Y:= ReadDAC;
    Write(Y:8);
    Delay(Del);
  Until KeyPressed;
    TestKeys;
  end;
  VGA256;
end;

procedure Help;
begin
  CloseGraph;
  DiffProc:= False;
  Writeln('This is the help shit');
  Writeln;
  Writeln;
  Writeln('K E Y S');
  Writeln;
  Writeln('[ 1..5 ] Viewing modes');
  Writeln;
  Writeln('   C    : Scroll through colours');
  Writeln(' Z / X  : Zoom in / out');
  Writeln(' + / -  : Faster / slower sample speed');
  Writeln('   H    : Help');
  Writeln('  Esc   : Quit');
  Writeln;
  Writeln;
  Writeln('Press any key...');
  NoCursor;
  ReadKey;
  TestKeys;
  VGA256;
end;

procedure OpenScreen;
begin
  GraphicsScreen;
  SetColor(Blue);
  SetTextStyle(0, 0, 5);
  SetTextJustify(1, 1);
  OutTextXY(DivX, DivY, 'S C O P E');
  SetColor(LightRed);
  OutTextXY(DivX + 3, DivY + 3, 'S C O P E');
  ReadKey;
  CloseGraph;
end;

begin
  OpenScreen;
  Zoom:= 1;
  Del:= 0;
  Colour:= 15;
  VGA256; {GraphicsScreen;}
  SetColor(Yellow);
  While not ResetDSP(2) do;
  X:= 0;
  Y:= 0;
  LastX:= 0;
  LastY:= 0;
  Proc:= 1;
  Repeat
    Case Proc of
      1: Lines;
      2: Dots;
      3: Graphs;
      4: Text;
      5: Cols256;
      99: Help;
    end;
  Until Ch = #27;
  CloseGraph;
end.


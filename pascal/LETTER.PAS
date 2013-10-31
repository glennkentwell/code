Program Letter;
Uses Crt, GrafBits, Graph;
Type PSTring = ^String;
Var
  gm, EX, I, X, Y : integer;
  Colour, BackColour, FontI, FontSizeI : array[1..50] of integer;
  NoWords : integer;
  F : Text;
  Title, Direct, ReadBuffer : String[80];
  Wordy : array[1..2000] of PString;
  KeyP, PageText : char;
  P, Pb : Pointer;

procedure CheckKeys;
begin
  KeyP := ReadKey;
  Case KeyP of
  #75:
  begin
    Dec(EX,2);
    if EX < 0 then EX := 0;
    Repeat
      if I <= 1 then Break;
      Dec(I);
    Until Wordy[I]^ = '|';
    if I > 1 then
    Dec(I);
    Repeat
      if I <= 1 then Break;
      Dec(I);
    Until Wordy[I]^ = '|';
  end;
  #71:
  begin
    EX := 0;
    I := 1;
  end;
  end;
end;

procedure FileInit;
begin
  Assign (F,'LETTER.TXT');
  Reset (F);
end;

procedure ReadLetterPage;
begin
  ReadLn(F, Colour[1], BackColour[1]);
  Readln(F,FontI[1],FontSizeI[1]);
  SetColor(Colour[1]);
  SetBkColor(BackColour[1]);
  I:= 1;
  Repeat
    ReadBuffer := '';
    Read(F,PageText);
    While PageText <> ' ' do
    begin
      if PageText = '|' then Break;
      if PageText = #26 then Break;
      Insert (PageText,ReadBuffer,Length(ReadBuffer) + 1);
      Read (F, PageText);
    end;
    Inc(I);
    GetMem(Wordy[I],Length(ReadBuffer)+1);
    Wordy[I]^ := ReadBuffer;
    if PageText = '|' then
    begin
      Inc(I);
      GetMem (Wordy[I],2);
      Wordy[I]^ := '|';
      Inc(EX);
      ReadLn (F, Colour[EX], BackColour[EX]);
      Readln (F,FontI[EX], FontSizeI[EX]);
    end;
    if PageText = #26 then
    begin
      Inc(I);
      GetMem (Wordy[I],2);
      Wordy[I]^ := PageText;
    end;
    if I = 1999 then
    begin
      CloseGraph;
      Write ('Too many words.  Limit of 2000 words.');
      Halt(1);
    end;
  Until PageText = #26;
  I := 2;
end;

procedure WritePageOnScreen;
begin
  EX := 1;
  Repeat
  ClearViewPort;
  SetTextStyle (FontI[EX],0,FontSizeI[EX]);
  SetColor (Colour[EX]);
  SetBkColor (BackColour[EX]);
  X := TextWidth('M'); Y := 1;
  While Wordy[I]^ <> '|' do
  begin
    OutTextXY (X,Y,Wordy[I]^);
    Inc(X,TextWidth(Wordy[I]^) + TextWidth('M'));
    if X >= (MaxX - TextWidth(Wordy[I+1]^)) then
    begin
      Inc(Y,TextHeight('M') + TextHeight('M') div 4);
      X := TextWidth('M');
    end;
    if Wordy[I]^ = #26 then Break;
    Inc(I);
  end;
  if Wordy[I]^ = #26 then Exit;
  if KeyPressed then ReadKey;
  KeyP := ReadKey;
  case KeyP of
    #27: Exit;
    #0: CheckKeys;
  end;
  Inc(I);
  Inc(EX);
  Until Wordy[I]^ = #26;
end;

procedure StartUpGraphics;
Var
  Size, Sizeb : Word;
  A, B, G, H : integer;
begin
  GraphicsScreen('C:\TP\BGI');
  ScreenVars;
  a := 100; b := 100;
  SetColor(DarkGray);
  ellipse (a,b,111,69,75,25);
  ellipse (a,b-7,179,0,35,5); {ufo body}
  ellipse (a,b,10,171,35,35); {ufo window}
  SetFillStyle(1, DarkGray);
  FloodFill(a, b, DarkGray);
  SetColor(LightGray);
  ellipse (a,b,20,60,73,22);
  SetColor(White);
  ellipse (a,b,20,61,72,21);
  SetColor(Black);
  ellipse (a,b,180,300,74,23);
  ellipse (a,b,180,285,74,22);
  ellipse (a,b,180,270,73,21);
  SetColor(LightBlue);
  ellipse (a,b-7,179,0,35,5); {ufo body}
  ellipse (a,b,30,70,30,30);  {foreground color}
  ellipse (a,b,10,171,35,35); {ufo window}
  SetFillStyle(1, Blue);
  FloodFill(a, b - 20, LightBlue);
  Size := (ImageSize (20,60,180,130));
  GetMem(P,Size);
  GetImage(20,60,180,130,P^);
  ClearDevice;
  SetColor (15);
  A := 1;
  B := 1;
  Repeat
    Inc(A, 1);
    Inc(B, 1);
    PutImage(A, B, P^, NormalPut);
    PutImage(MaxX - A, MaxY - B, P^, NormalPut);
  Until (B >= GetMaxY) or (KeyPressed);
  ClearDevice;
  A := 0;
  Repeat
    Inc(A,2);
    Dec(B,2);
    PutImage(A, B, P^, NormalPut);
    if KeyPressed then Break;
  Until A > GetMaxX + 10;
  A := DivX;
  B := GetMaxY;
  ClearDevice;
  Repeat
    Dec(B,2);
    PutImage(A,B,P^,NormalPut);
    if KeyPressed then Break;
  Until B <= DivY;
  Repeat
    Dec(A,2);
    Dec(B,2);
    PutImage(A,B,P^,NormalPut);
    if KeyPressed then Break;
  Until B <= -10;
  CloseGraph;
end;

procedure ScreenStuff;
var
  Gd, Gm: integer;
begin
  GetDir (0,Direct);
  GraphicsScreen('C:\TP\BGI');
  ScreenVars;
  gm := GetGraphMode;
  FileInit;
  Line (0,40,GetMaxX, 40);
  Line (0,GetMaxY - 20,GetMaxX, GetMaxY - 20);
  SetTextJustify (1,1);
  OutTextXY (DivX, GetMaxY - 10,'FIRST PAGE Home    LAST PAGE Left Arrow    NEXT PAGE Any Key     QUIT Escape');
  SetViewPort (0,0,GetMaxX, 40,ClipOn);
  ReadLn (F,Colour[I], BackColour[I]);
  Readln (F, Title);
  SetColor (Colour[I]);
  SetBkColor (BackColour[I]);
  SetTextStyle (7,0,6);
  OutTextXY (DivX, 10, Title);
  SetViewPort (4,44,GetMaxX - 4, GetMaxY - 21,ClipOn);
  MaxX := GetMaxX - 8;
  MaxY := GetMaxY - 8;
  SetTextJustify (0,2);
end;

begin
  StartUpGraphics;
  ScreenStuff;
  EX := 1;
  Repeat
    ReadLetterPage;
    WritePageOnScreen;
  Until (KeyP = #27) or (Wordy[I]^ = #26);
  Close (F);
  CloseGraph;
end.
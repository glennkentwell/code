program WhateverItIs;
uses
  Crt, Graph,
  GrafBits;
type
  KeyType = array[1..2] of char;

const
  Space: KeyType = (' ', #0);
  F1: KeyType = (#0, #59);
  F2: KeyType = (#0, #60);
  F3: KeyType = (#0, #61);
  F4: KeyType = (#0, #62);
  F5: KeyType = (#0, #63);
  F6: KeyType = (#0, #64);
  F7: KeyType = (#0, #65);
  F8: KeyType = (#0, #66);
  F9: KeyType = (#0, #67);
  F10: KeyType = (#0, #68);
  One: KeyType = ('1', #0);
  Two: KeyType = ('2', #0);
  Three: KeyType = ('3', #0);
  Four: KeyType = ('4', #0);
  Five: KeyType = ('5', #0);
  Six: KeyType = ('6', #0);
  Seven: KeyType = ('7', #0);
  Eight: KeyType = ('8', #0);
  Nine: KeyType = ('9', #0);
  Zero: KeyType = ('0', #0);
  Decimal: KeyType = ('.', #0);
  Plus: KeyType = (#13, #0);
  Till: KeyType = ('+', #0);

type
  InOut = (ButtonIn, ButtonOut);
  TButton = object
    XPos, YPos: integer;
    Text: string;
    Key: KeyType;
    procedure Draw(X, Y: integer; S: string; InOrOut: InOut; Keys: KeyType);
    procedure ReDraw;
    procedure TestForPress;
    procedure Press;
  end;
  TKey = object
    Key: KeyType;
    procedure GetKeys;
    function KeyOne: char;
    function KeyTwo: char;
  end;

var
  IntStr, DecStr,
  Ss: string;
  Cash, Change,
  Number, Total: real;
  X, Y: integer;
  Ch: char;
  Quay: TKey;
  TillPress, PlusPress: Boolean;
  Button: array[1..50] of TButton;

procedure TButton.Draw;
var
  TxtYPos: shortint;
begin
  XPos:= X;
  YPos:= Y;
  Text:= S;
  Key:= Keys;
  SetTextJustify(0, 2);
  Bar(X - TextWidth(' '), Y - TextHeight('X') div 2,
      X + TextWidth(S) + TextWidth(' '), Y + TextHeight(S) + TextHeight(S) div 2);
  if InOrOut = ButtonOut then SetColor(White)
    else SetColor(DarkGray);
  Line(X - TextWidth(' '), Y - TextHeight('X') div 2, X + TextWidth(S) + TextWidth(' '), Y - TextHeight(S) div 2);
  Line(X - TextWidth(' '), Y - TextHeight('X') div 2, X - TextWidth(' '), Y + TextHeight(S)+TextHeight(S)div 2);
  if InOrOut = ButtonOut then SetColor(DarkGray)
    else SetColor(White);
  Line(X + TextWidth(S) + TextWidth(' '), Y - TextHeight(S) div 2,
       X + TextWidth(S) + TextWidth(' '), Y + TextHeight(S) + TextHeight(S) div 2);
  Line(X - TextWidth(' '), Y + TextHeight(S) + TextHeight(S) div 2,
       X + TextWidth(S) + TextWidth(' '), Y + TextHeight(S) + TextHeight(S) div 2);
  if InOrOut = ButtonIn then TxtYPos:= 1
    else TxtYPos:= 0;
  SetColor(Black);
  OutTextXY(X - 1, Y + TxtYPos, S);
  SetColor(White);
  OutTextXY(X, Y + TxtYPos, S);
end;

procedure TButton.ReDraw;
begin
  Draw(XPos, YPos, Text, ButtonOut, KEy);
end;

procedure TButton.TestForPress;
var
  Cha: KeyType;
begin
  Cha[1]:= #0;
  Cha[2]:= #0;
  if Key[1] = Quay.KeyOne then
    if Key[2] = Quay.KeyTwo then Press;
end;

procedure TButton.Press;
var
  I: integer;
begin
  Draw(XPos, YPos, Text, ButtonIn, Key);
    For I:= 400 downto 320 do
    begin
      Sound(I);
      Delay(1);
    end;
    NoSound;
    Delay(100);
  ReDraw;
end;

procedure TKey.GetKeys;
begin
  Key[1]:= #0;
  Key[2]:= #0;
  Key[1]:= ReadKey;
  if KeyPressed then Key[2]:= ReadKey;
end;

function TKey.KeyOne;
begin
  KeyOne:= Key[1];
end;

function TKey.KeyTwo;
begin
  KeyTwo:= Key[2];
end;

procedure DoStringStuff;
begin
  if Length(IntStr) < 8 then
  begin
    Insert(Quay.KeyOne, IntStr, Length(IntStr) + 1);
    if Length(IntStr) = 3 then Insert('.', IntStr, 1);
    if Length(IntStr) > 2 then
    begin
      IntStr[Length(IntStr) - 3]:= IntStr[Length(IntStr) - 2];
      IntStr[Length(IntStr) - 2]:= '.';
    end;
  end;
end;

procedure AddUp;
var
  G, H: integer;
begin
  SetColor(Yellow);
  SetTextJustify(0, 1);
  SetFillStyle(1, Black);
  SetTextStyle(2, 0, 10);
  SetUserCharSize(10, 1, 10, 1);
  if Quay.KeyOne in ['0'..'9'] then
  begin
    PlusPress:= False;
    Bar(100, 50, MaxX - 20, 50 + TextHeight('X'));
    DoStringStuff;
    SetColor(Red);
    SetTextJustify(2, 1);
    For G:= -5 to 5 do
      OutTextXY(620 + G, 50 + TextHeight('X') div 2, IntStr);
  end;
  if Quay.KeyOne = #13 then
  begin
      Val(IntStr, Number, G);
      Val(DecStr, H, G);
      Number:= Number + H;
      Total:= Total + Number;
      Bar(100, 50, MaxX - 20, 150);
      Str(Total:6:2, DecStr);
      SetColor(Red);
      SetTextJustify(2, 1);
      For G:= -5 to 5 do
        OutTextXY(620 + G, 50 + TextHeight('X') div 2, DecStr);
      IntStr:= '';
      DecStr:= '';
      PlusPress:= True;
  end;
  if Quay.KeyOne = Till[1] then
  begin
    if not PlusPress then
    begin
      Bar(100, 50, MaxX - 20, 50 + TextHeight('X'));
      Val(IntStr, Cash, G);
      Val(DecStr, H, G);
      Cash:= Cash + H;
      Change:= Cash - Total;
      Bar(100, 50, MaxX - 20, 150);
      IntStr:= '';            {   \|||||///     }
      DecStr:= '';            {  \ 00  ] //     }
    end;                      {  | [    //      }
    SetTextJustify(2, 1);     {  \ \_/  |       }
    Str(Change:6:2, DecStr);   {   \___  |       }
    Total:= 0;                {      \  |       }
    For G:= -5 to 5 do
      OutTextXY(620 + G, 50 + TextHeight('X') div 2, DecStr);
  end;
  SetFillStyle(1, LightGray);
  SetTextStyle(0, 0, 2);
end;

procedure DrawScreen;
begin
  GraphicsScreen;
  SetColor(Blue);
  SetRGBPalette(Green, 35, 35, 35);
  SetFillStyle(1, Green);
  Bar(0, 0, MaxX, MaxY);
  SetFillStyle(1, Black);
  Bar(20, 49, MaxX - 19, 170);
  Rectangle(20, 49, MaxX - 19, 170);
  SetLineStyle(0, 0, 3);
  SetColor(White);
  Line(18, 173, MaxX - 16, 173);
  Line(MaxX - 16, 173, MaxX - 16, 47);
  SetColor(DarkGray);
  Line(18, 47, MaxX - 16, 47);
  Line(18, 47, 18, 173);
  TillPress:= False;
  SetTextJustify(0, 1);
  SetTextStyle(2, 0, 10);
  SetUserCharSize(10, 1, 10, 1);
  SetFillStyle(1, LightGray);
  SetColor(Yellow);
  For X:= -5 to 5 do
    OutTextXY(X + 55, 50 + TextHeight('X') div 2, '$');
  SetTextStyle(0, 0, 2);
end;

begin
  DrawScreen;
  Y:= -10;
  Button[2].Draw(250, 280, '1', ButtonOut, One);
  Button[3].Draw(300, 280, '2', ButtonOut, Two);
  Button[4].Draw(350, 280, '3', ButtonOut, Three);
  Button[5].Draw(250, 245, '4', ButtonOut, Four);
  Button[6].Draw(300, 245, '5', ButtonOut, Five);
  Button[7].Draw(350, 245, '6', ButtonOut, Six);
  Button[8].Draw(250, 210, '7', ButtonOut, Seven);
  Button[9].Draw(300, 210, '8', ButtonOut, Eight);
  Button[10].Draw(350, 210, '9', ButtonOut, Nine);
  Button[1].Draw(250, 315, '0   ', ButtonOut, Zero);
  Button[11].Draw(350, 315, '.', ButtonOut, Decimal);
  Button[12].Draw(410, 315, '  + ', ButtonOut, Plus);
  Button[13].Draw(410, 280, 'Till', ButtonOut, Till);
  While Ch <> #27 do
  begin
    Quay.GetKeys;
    For X:= 1 to 13 do Button[X].TestForPress;
    AddUp;
    Ch:= Quay.KeyOne;
  end;
  CloseGraph;
end.
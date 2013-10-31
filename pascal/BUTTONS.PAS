unit Buttons;
{ See the sample thingy called BtnSampl.pas to tell ya how to use this stuff }

interface
type
  KeyType = array[1..2] of char;

const
  One: KeyType = ('1', #0);     Two: KeyType = ('2', #0);
  Three: KeyType = ('3', #0);   Four: KeyType = ('4', #0);
  Five: KeyType = ('5', #0);    Six: KeyType = ('6', #0);
  Seven: KeyType = ('7', #0);   Eight: KeyType = ('8', #0);
  Nine: KeyType = ('9', #0);    Zero: KeyType = ('0', #0);
  Dot: KeyType = ('.', #0);     Plus: KeyType = ('+', #0);
  Star: KeyType = ('*', #0);    Slash: KeyType = ('/', #0);
  BkSlash: KeyType = ('\', #0); Equals: KeyType = ('=', #0);

  Enter: KeyType = (#13, #0);
  a: KeyType = ('a', #0);  b: KeyType = ('b', #0);
  c: KeyType = ('c', #0);  d: KeyType = ('d', #0);
  e: KeyType = ('e', #0);  f: KeyType = ('f', #0);
  g: KeyType = ('g', #0);  h: KeyType = ('h', #0);
  i: KeyType = ('i', #0);  j: KeyType = ('j', #0);
  k: KeyType = ('k', #0);  l: KeyType = ('l', #0);
  m: KeyType = ('m', #0);  n: KeyType = ('n', #0);
  o: KeyType = ('o', #0);  p: KeyType = ('p', #0);
  q: KeyType = ('q', #0);  r: KeyType = ('r', #0);
  s: KeyType = ('s', #0);  t: KeyType = ('t', #0);
  u: KeyType = ('u', #0);  v: KeyType = ('v', #0);
  w: KeyType = ('w', #0);  x: KeyType = ('x', #0);
  y: KeyType = ('y', #0);  z: KeyType = ('z', #0);
  Space: KeyType = (' ', #0);

  F1: KeyType = (#0, #59);  F2: KeyType = (#0, #60);
  F3: KeyType = (#0, #61);  F4: KeyType = (#0, #62);
  F5: KeyType = (#0, #63);  F6: KeyType = (#0, #64);
  F7: KeyType = (#0, #65);  F8: KeyType = (#0, #66);
  F9: KeyType = (#0, #67);  F10: KeyType = (#0, #68);

  ALTA: KeyType = (#0, #30);  ALTB: KeyType = (#0, #48);
  ALTC: KeyType = (#0, #46);  ALTD: KeyType = (#0, #32);
  ALTE: KeyType = (#0, #18);  ALTF: KeyType = (#0, #33);
  ALTG: KeyType = (#0, #34);  ALTH: KeyType = (#0, #35);
  ALTI: KeyType = (#0, #23);  ALTJ: KeyType = (#0, #36);
  ALTK: KeyType = (#0, #37);  ALTL: KeyType = (#0, #38);
  ALTM: KeyType = (#0, #50);  ALTN: KeyType = (#0, #49);
  ALTO: KeyType = (#0, #24);  ALTP: KeyType = (#0, #25);
  ALTQ: KeyType = (#0, #16);  ALTR: KeyType = (#0, #19);
  ALTS: KeyType = (#0, #31);  ALTT: KeyType = (#0, #20);
  ALTU: KeyType = (#0, #22);  ALTV: KeyType = (#0, #47);
  ALTW: KeyType = (#0, #17);  ALTX: KeyType = (#0, #45);
  ALTY: KeyType = (#0, #21);  ALTZ: KeyType = (#0, #44);

  Up: KeyType = (#0, #72);     Down: KeyType = (#0, #80);
  Left: KeyType = (#0, #75);   Right: KeyType = (#0, #77);
  PgUp: KeyType = (#0, #73);   PgDn: KeyType = (#0, #81);
  Home: KeyType = (#0, #71);   _End: KeyType = (#0, #79);

  Del: KeyType = (#0, #83);  Ins: KeyType = (#0, #82);
  BkSp: KeyType = (#8, #0);  Esc: KeyType = (#27, #0);
  Tab: KeyType = (#9, #0);   ShiftTab: KeyType = (#0, #15);

  Null: KeyType = (#0, #0);

type
  InOut = (ButtonIn, ButtonOut);
  TButton = object
    XPos, YPos: integer;
    Text: string;
    Keys: KeyType;
    ColourChange: Boolean;
    FaceCol, TextCol,
    Shadow, Highlight: Word;
    procedure Draw(X, Y: integer; S: string; InOrOut: InOut; Kee: KeyType);
    procedure ChangeColour(Face, TextCo, High, Shad: Word);
    procedure ReDraw;
    procedure Press;
    procedure TestForPress;
  end;
  TKey = object
    Key: KeyType;
    procedure GetKeys;
    function KeyOne: char;
    function KeyTwo: char;
  end;
var
  Key: TKey;

implementation
uses Graph, Crt;

procedure TButton.Draw;
var
  TxtYPos: shortint;
begin
  XPos:= X;
  YPos:= Y;
  Text:= S;
  Keys:= Kee;
  if not ColourChange then
    begin
      FaceCol:= LightGray;
      TextCol:= White;
      Shadow:= DarkGray;
      Highlight:= White;
      SetRGBPalette(LightGray, 36, 36, 36);
    end;
  SetTextJustify(0, 2);
  SetFillStyle(1, FaceCol);
  Bar(X - TextWidth(' '), Y - TextHeight('X') div 2,
      X + TextWidth(S) + TextWidth(' '), Y + TextHeight(S) + TextHeight(S) div 2);
  if InOrOut = ButtonOut then SetColor(Highlight)
    else SetColor(Shadow);
  Line(X - TextWidth(' '), Y - TextHeight('X') div 2, X + TextWidth(S) + TextWidth(' '), Y - TextHeight(S) div 2);
  Line(X - TextWidth(' '), Y - TextHeight('X') div 2 + 1, X + TextWidth(S) + TextWidth(' '), Y - TextHeight(S) div 2 + 1);
  Line(X - TextWidth(' '), Y - TextHeight('X') div 2, X - TextWidth(' '), Y + TextHeight(S)+TextHeight(S)div 2);
  Line(X - TextWidth(' ') + 1, Y - TextHeight('X') div 2, X - TextWidth(' ') + 1, Y + TextHeight(S)+TextHeight(S)div 2);
  if InOrOut = ButtonOut then SetColor(Shadow)
    else SetColor(Highlight);
  Line(X + TextWidth(S) + TextWidth(' '), Y - TextHeight(S) div 2,
       X + TextWidth(S) + TextWidth(' '), Y + TextHeight(S) + TextHeight(S) div 2);
  Line(X - TextWidth(' '), Y + TextHeight(S) + TextHeight(S) div 2,
       X + TextWidth(S) + TextWidth(' '), Y + TextHeight(S) + TextHeight(S) div 2);
  Line(X + TextWidth(S) + TextWidth(' ') - 1, Y - TextHeight(S) div 2 + 1,
       X + TextWidth(S) + TextWidth(' ') - 1, Y + TextHeight(S) + TextHeight(S) div 2);
  Line(X - TextWidth(' ') + 1, Y + TextHeight(S) + TextHeight(S) div 2 - 1,
       X + TextWidth(S) + TextWidth(' '), Y + TextHeight(S) + TextHeight(S) div 2 - 1);
  if InOrOut = ButtonIn then TxtYPos:= 1
    else TxtYPos:= 0;
  SetColor(Black);
  { top horizontal }
  Line(X - TextWidth(' '), Y - TextHeight('X') div 2 - 1,
       X + TextWidth(S) + TextWidth(' '), Y - TextHeight('X') div 2 - 1);
  { left vertical }
  Line(X - TextWidth(' ') - 1, Y - TextHeight('X') div 2,
       X - TextWidth(' ') - 1, Y + TextHeight('X') + TextHeight(S) div 2);
  { right vertical }
  Line(X + TextWidth(S) + TextWidth(' ') + 1, Y - TextHeight('X') div 2,
       X + TextWidth(S) + TextWidth(' ') + 1, Y + TextHeight('X') + TextHeight(S) div 2);
  { bottom horizontal }
  Line(X - TextWidth(' '), Y + TextHeight('X') + TextHeight(S) div 2 + 1,
       X + TextWidth(S) + TextWidth(' '), Y + TextHeight('X') + TextHeight(S) div 2 + 1);
  OutTextXY(X - 1, Y + TxtYPos, S);
  SetColor(TextCol);
  OutTextXY(X, Y + TxtYPos, S);
end;

procedure TButton.ChangeColour;
begin
  FaceCol:= Face;
  TextCol:= TextCo;
  Shadow:= Shad;
  Highlight:= High;
  ColourChange:= True;
  ReDraw;
end;

procedure TButton.ReDraw;
begin
  Draw(XPos, YPos, Text, ButtonOut, Keys);
end;

procedure TButton.TestForPress;
var
  Cha: KeyType;
begin
  Cha[1]:= #0;
  Cha[2]:= #0;
  if Keys[1] = Key.KeyOne then
    if Keys[2] = Key.KeyTwo then Press;
end;

procedure TButton.Press;
var
  I: integer;
begin
  Draw(XPos, YPos, Text, ButtonIn, Keys);
{    For I:= 920 to 980 do
    begin
      Sound(I);
      Delay(1);
    end;}
  Delay(150);
  NoSound;
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
end.
{
 Ackshully, this is BtnSampl.pas

program Whatever;
uses
  Crt, Graph,
  GrafBits, Buttons;

var
  Button: TButton;

begin
  GraphicsScreen;
  While Key.KeyOne <> Esc[1] do
  begin
    Button.Draw(DivX, DivY, 'Hi there, I''m a button.', ButtonOut, Space);
    Key.GetKeys;
    Button.TestForPress;
  end;
  CloseGraph;
end.
}
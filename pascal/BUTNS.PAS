program WithButtons;
uses
  Crt, Graph,
  GrafBits, Buttons;


var
  cmdQuit,
  cmdSpace, cmdEnter, cmdPlus: TButton;

procedure TopBar;
begin
  SetColor(White);
  SetFillStyle(1, LightGray);
  Bar(0, 20, MaxX, 50);
  Line(0, 20, MaxX, 20);
  Line(0, 20, 0, 50);
  SetColor(DarkGray);
  Line(0, 50, MaxX, 50);
  Line(MaxX, 50, MaxX, 20);
end;

procedure Title(Text: string);
begin
  SetColor(White);
  SetFillStyle(1, Blue);
  Bar(0, 0, MaxX, 20);
  SetTextJustify(1, 0);
  OutTextXY(DivX, 13, Text);
end;

procedure Bottom(Text: string);
begin
  SetColor(Black);
  SetFillStyle(1, LightGray);
  Bar(0, MaxY, MaxX, MaxY - 20);
  Line(0, MaxY - 20, MaxX, MaxY - 20);
  SetTextJustify(1, 1);
  OutTextXY(DivX, MaxY - 10, Text);
end;

procedure DoButtons;
begin
  SetTextStyle(0, 1, 1);
  cmdSpace.Draw(20, 30, '           ', ButtonOut, Space);
  cmdPlus.Draw(260, 30, '          ', ButtonOut, BkSp);
  cmdEnter.Draw(140, 30, '           ', ButtonOut, Enter);
  cmdQuit.Draw(MaxX - 100, 30, '    ', ButtonOut, Esc);
end;

procedure EmbossedTextBox(XPos, YPos, CharWidth: integer;
                          TextStyle, TextSize: Word;
                          Name: string);
var
  I,
  NameWid,
  Ht, Wid: integer;
  S: string;
begin
  S:= '';
  For I:= 1 to CharWidth + 1 do Insert(' ', S, Length(S) + 1);
  Ht:= TextHeight(S);
  Wid:= TextWidth(S);
  NameWid:= TextWidth(Name);
  SetTextStyle(TextStyle, 0, TextSize);
  SetFillStyle(1, LightGray);
  Bar(XPos, YPos, XPos + NameWid + Wid + 20, YPos + Ht * 2 + 20);
  SetColor(DarkGray);
  Line(XPos + NameWid + Wid + 20, YPos + Ht * 2 + 20, XPos, YPos + Ht * 2 + 20);      { shadow bottom line}
  Line(XPos + NameWid + Wid + 19, YPos + Ht * 2 + 19, XPos + 1, YPos + Ht * 2 + 19);  { top shadow line }
  SetColor(White);
  Line(XPos + NameWid + Wid + 20, YPos + Ht * 2 + 20, XPos, YPos + Ht * 2 + 20);      { shadow bottom line}
  Line(XPos + NameWid + Wid + 19, YPos + Ht * 2 + 19, XPos + 1, YPos + Ht * 2 + 19);  { top shadow line }
  SetFillStyle(1, White);
  Bar(XPos + NameWid + 10, YPos + 10, XPos + NameWid + Wid, YPos + Ht * 2 + 10);
  SetColor(Black);
  OutTextXY(XPos + 5, YPos + (Ht + 20) div 2, Name);
end;


begin
  GraphicsScreen;
  SetFillStyle(1, LightGreen);
  SetTextStyle(2, 0, 5);
  Title('This is QuikMenu, man.');
  Bottom('This is the bottom.');
  TopBar;
  DoButtons;
  SetViewPort(0, 51, MaxX, MaxY - 21, ClipOn);
  SetFillStyle(1, Blue);
  FloodFill(1, 1, Yellow);
  SetViewPort(0, 0, MaxX, MaxY, ClipOn);
  EmbossedTextBox(100, 100, 20, 0, 1, 'Text Box');
  While Key.KeyOne <> #27 do
  begin
    Key.GetKeys;
    cmdSpace.TestForPress;
    cmdQuit.TestForPress;
    cmdEnter.TestForPress;
    cmdPlus.TestForPress;
  end;
  CloseGraph;
end.


program Colouring_In;
uses Crt, Graph, GrafBits, Buttons;
type
  RGBRec = record
    RedVal, GreenVal, BlueVal : Integer;
     { Intensity values (values from 0 to 63) }
    Name: String;
    ColorNum: Integer;
     { The VGA color palette number as mapped into 16 color palette }
  end;

var
  Red, Green, Blue,
  I: integer;
  Average: real;
  Ch: char;
  S: String;

begin
  GraphicsScreen;
  SetFillStyle(1, LightGray);
  Bar(100, 100, 300, 200);
  SetFillStyle(1, Black);
  Bar(208, 118, 262, 172);
  SetColor(White);
  Line(99, 100, 99, 200);
  Line(99, 99, 300, 99);

  Line(205, 175, 265, 175);
  Line(265, 175, 265, 115);
  SetColor(DarkGray);
  Line(99, 201, 301, 201);
  Line(301, 201, 301, 101);
  Line(99, 202, 301, 202);
  Line(302, 202, 302, 100);

  Line(205, 115, 265, 115);
  Line(205, 115, 205, 175);
  SetColor(LightRed);
  SetTextStyle(7, 0, 4);
  OutTextXY(110, 50, 'The Colours');
  SetTextStyle(0, 0, 1);
  While Key.KeyOne <> #27 do
  begin
    SetRGBPalette(1, Red, Green, Blue);
    For I:= 0 to 65 do
    begin
      SetColor(1);
      SetFillStyle(1, 1);
      Bar(210, 120, 260, 170);
    end;
      SetFillStyle(1, LightGray);
      Bar(100, 100, 200, 200);
      SetColor(Black);
      Str(Red, S);
      OutTextXY(120, 120, 'Red : ' + S);
      Str(Green, S);
      OutTextXY(105, 140, 'Green : ' + S);
      Str(Blue, S);
      OutTextXY(113, 160, 'Blue : ' + S);
      Str(Average:4:1, S);
      OutTextXY(113, 180, 'Av.  : ' + S);
      Key.GetKeys;
      Case UpCase(Key.KeyOne) of
        'R': Inc(Red);
        'E': Dec(Red);
        'G': Inc(Green);
        'F': Dec(Green);
        'B': Inc(Blue);
        'V': Dec(Blue);
        #0:
        begin
          Case Key.KeyTwo of
            #48: Inc(Blue, 5);
            #47: Dec(Blue, 5);
            #34: Inc(Green, 5);
            #33: Dec(Green, 5);
            #19: Inc(Red, 5);
            #18: Dec(Red, 5);
          end;
        end;
      end;
    if Red > 63 then Red:= 63;
    if Red < 0 then Red:= 0;
    if Green > 63 then Green:= 63;
    if Green < 0 then Green:= 0;
    if Blue > 63 then Blue:= 63;
    if Blue < 0 then Blue:= 0;
    Average:= (Red + Blue + Green) / 3;
  end;
  CloseGraph;
end.

const
  { Table of suggested colors for VGA 16 color modes }
  Colors : array[0..MaxColors] of RGBRec = (
   ( RedVal:0;GreenVal:0;BlueVal:0;Name:'Black';ColorNum: 0),
   ( RedVal:0;GreenVal:0;BlueVal:40;Name:'Blue';ColorNum: 1),
   ( RedVal:0;GreenVal:40;BlueVal:0;Name:'Green';ColorNum: 2),
   ( RedVal:0;GreenVal:40;BlueVal:40;Name:'Cyan';ColorNum: 3),
   ( RedVal:40;GreenVal:7;BlueVal:7;Name:'Red';ColorNum: 4),
   ( RedVal:40;GreenVal:0;BlueVal:40;Name:'Magenta';ColorNum: 5),
   ( RedVal:40;GreenVal:30; BlueVal:0;Name:'Brown';ColorNum: 20),
   ( RedVal:49;GreenVal:49;BlueVal:49;Name:'Light Gray';ColorNum: 7),
   ( RedVal:26;GreenVal:26;BlueVal:26;Name:'Dark Gray';ColorNum: 56),
   ( RedVal:0;GreenVal:0;BlueVal:63;Name:'Light Blue';ColorNum: 57),
   ( RedVal:9;GreenVal:63;BlueVal:9;Name:'Light Green';ColorNum: 58),
   ( RedVal:0;GreenVal:63;BlueVal:63;Name:'Light Cyan';ColorNum: 59),
   ( RedVal:63;GreenVal:10;BlueVal:10;Name:'Light Red';ColorNum: 60),
   ( RedVal:44;GreenVal:0;BlueVal:63;Name:'Light Magenta';
          ColorNum: 61),
   ( RedVal:63;GreenVal:63;BlueVal:18;Name:'Yellow';ColorNum: 62),
   ( RedVal:63; GreenVal:63; BlueVal:63; Name: 'White'; ColorNum: 63)
  );
var
  Driver, Mode, I, Error: Integer;
begin
  { Initialize Graphics Mode }
  Driver := VGA;
  Mode := VGAHi;
  InitGraph(Driver, Mode, ' ');
  Error := GraphResult;
  if Error <> GrOk then
    begin
      writeln(GraphErrorMsg(Error));
      halt(1);
    end;
  SetFillStyle(SolidFill, Green);   { Clear }
  Bar(0, 0, GetMaxX, GetMaxY);
  if GraphResult < 0 then
    Halt(1); { Zero palette, make graphics invisible }
  SetRGBPalette(Colors[0].ColorNum, 63, 63, 63);
  for i := 1 to 15 do
    with Colors[i] do
      SetRGBPalette(ColorNum, 0, 0, 0);

  { Display the color name using its color with an appropriate background }

 { Notice how with the current palette settings, only the text for"Press
   any key...", "Black", "Light Gray", and "White" are visible.This occurs
   because the palette entry for color 0 (Black) has been set to display as
   white. For the text "Light Gray" and "White,"color 0 (Black) is used as
   the background.}
  SetColor(0);
  OutTextXY(0, 10, 'Press Any Key...');
  for I := 0 to 15 do
  begin
    with Colors[I] do
      begin
        SetColor(I);
        SetFillStyle(SolidFill, (I xor 15) and 7);
        { "(I xor 15)" gives an appropriate background }
        { " and 7" reduces the intensity of the background }
        Bar(10, (I + 2) * 10 - 1, 10 + TextWidth(Name),
          (I + 2) * 10 + TextHeight(Name) - 1);
        OutTextXY(10, (I + 2) * 10, Name);
      end;
  end;
  ReadKey;
 { Restore original colors to the palette. The default colors might vary
   depending upon the initial values used by your video system.}
  for i := 0 to 15 do
    with Colors[i] do
      SetRGBPalette(ColorNum, RedVal, GreenVal, BlueVal);
  { Wait for a keypress and then quit graphics and end. }
  ReadKey;
  Closegraph;
end.

var
  X, Y: integer;
  Red, Green, Blue: integer;
procedure ChangeColour(Colour: Word; R, G, B: integer);
begin

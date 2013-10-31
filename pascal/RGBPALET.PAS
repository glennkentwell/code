program TryDrivers;
Uses Graph, Crt, GrafBits;
type
  RGBRec = record
    RedVal, GreenVal, BlueVal: integer;
    Name: String;
    ColorNum: integer;
  end;

const
  Colors: array[0..15] of RGBRec = (
    (RedVal:0;  GreenVal:0;  BlueVal:0;  Name: 'Black';        ColorNum:0),
    (RedVal:0;  GreenVal:0;  BlueVal:40; Name: 'Blue';         ColorNum:1),
    (RedVal:0;  GreenVal:40; BlueVal:0;  Name: 'Green';        ColorNum:2),
    (RedVal:0;  GreenVal:40; BlueVal:40; Name: 'Cyan';         ColorNum:3),
    (RedVal:40; GreenVal:7;  BlueVal:7;  Name: 'Red';          ColorNum:4),
    (RedVal:40; GreenVal:0;  BlueVal:40;  Name: 'Magenta';      ColorNum:5),
    (RedVal:40; GreenVal:30; BlueVal:0;  Name: 'Brown';        ColorNum:20),
    (RedVal:49; GreenVal:49; BlueVal:49;  Name: 'LightGray';    ColorNum:7),
    (RedVal:26; GreenVal:26; BlueVal:26; Name: 'DarkGray';     ColorNum:56),
    (RedVal:0;  GreenVal:0;  BlueVal:63; Name: 'LightBlue';    ColorNum:57),
    (RedVal:9;  GreenVal:63; BlueVal:9;  Name: 'LightGreen';   ColorNum:58),
    (RedVal:0;  GreenVal:63; BlueVal:63; Name: 'LightCyan';    ColorNum:59),
    (RedVal:63; GreenVal:10; BlueVal:10; Name: 'LightRed';     ColorNum:60),
    (RedVal:44; GreenVal:0;  BlueVal:63; Name: 'LightMagenta'; ColorNum:61),
    (RedVal:63; GreenVal:63; BlueVal:18; Name: 'Yellow';       ColorNum:62),
    (RedVal:63; GreenVal:63; BlueVal:63; Name: 'White';        ColorNum:63));

Var
  Gd, Gm,
  X, Y, I: integer;

begin
  Gd:= VGA;
  Gm:= 0;
  InitGraph(Gd, Gm, '\tp\bgi');
  For I:= 0 to 9 do
    with Colors[I] do
      SetRGBPalette(ColorNum, RedVal, GreenVal, BlueVal);
  For I:= 0 to 9 do
    Circle(100, 100, 20 - I);
  ReadKey;
  CloseGraph;
end.
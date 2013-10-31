program RolePlay;
uses Crt,
     Cursor, Buttons,
     UnCrunch, RolePics;
type
  TPerson = record
    Points, Level, Money: integer;
  end;

var
  Play: Boolean;
procedure MoonMenu; forward;
procedure MercuryMenu; forward;
procedure VenusMenu; forward;
procedure MarsMenu; forward;
procedure SaturnMenu; forward;
procedure JupiterMenu; forward;
procedure UranusMenu; forward;
procedure NeptuneMenu; forward;
procedure PlutoMenu; forward;
procedure GalaxyMenu; forward;
procedure Instructions; forward;
procedure Newspaper; forward;
procedure ShopMenu; forward;
procedure SpaceClubMenu; forward;
procedure Stats; forward;

procedure Text(Fore, Back: Word);
begin
  TextColor(Fore);
  TextBackGround(Back);
end;

procedure Option(X, Y: integer;  Colour, LetterCol: Word; Letter, S: string);
begin
  Text(Colour, Black);
  GoToXY(X, Y);  Write('[');
  Text(LetterCol, Black);  Write(Letter);
  Text(Colour, Black);  Write(']  ', S);
end;

procedure Prompt(X, Y: integer; Colour: Word; S: string);
begin
  Text(Colour, Black);
  GoToXY(X, Y);
  Write(S);
  NormCursor;
end;

procedure Capital(K: KeyType);
begin
  Key.Key[1]:= UpCase(K[1]);
  Key.Key[2]:= UpCase(K[2]);
end;

procedure Intro;
begin
  Text(LightGray + Blink, Black);
  ClrScr;
  NoCursor;
  DisplayANSI(RoleIntro, 1, 1, RoleIntro_Length);
  Key.GetKeys;
end;

procedure SureYaWannaPlay;
begin
  ClrScr;
  DisplayANSI(RoleSRP, 1, 1, RoleSRP_Length);
  Option(20, 15, Green, LightGreen, 'W', 'Warp to game');
  Option(20, 17, Green, LightGreen, 'I', 'Instructions');
  Option(20, 19, Green, LightGreen, 'Q', 'Abort mission');
  GoToXY(WhereX - 1, WhereY);
  Repeat
    Key.GetKeys;
  Until (Key.Key = W) or
        (Key.Key = I) or
        (Key.Key = Q) or
        (Key.Key = Enter);
  if Key.Key = W then Play:= True;
  if Key.Key = Enter then Play:= True;
  if Key.Key = I then Instructions;
  if Key.Key = Q then Play:= False;
end;

procedure Instructions;
begin
end;

procedure EarthMenu;
var
  Col, X, Y: integer;
begin
  Key.Key:= Enter;
  if Play then
  While Key.Key <> Q do
  begin
    ClrScr;
    DisplayANSI(Earth, 1, 1, Earth_Length);
    Option(50, 3, LightBlue, Yellow, 'O', 'Moon     ');
    Option(50, 4, LightBlue, Yellow, 'M', 'Mercury  ');
    Option(50, 5, LightBlue, Yellow, 'V', 'Venus    ');
    Option(50, 6, LightBlue, Yellow, 'A', 'mArs     ');
    Option(50, 7, LightBlue, Yellow, 'J', 'Jupiter  ');
    Option(50, 8, LightBlue, Yellow, 'T', 'saTurn   ');
    Option(50, 9, LightBlue, Yellow, 'U', 'Uranus   ');
    Option(50, 10, LightBlue, Yellow, 'N', 'Neptune ');
    Option(50, 11, LightBlue, Yellow, 'P', 'Pluto   ');
    Option(50, 13, LightBlue, Yellow, 'G', 'Other galaxies');
    Option(50, 14, LightBlue, Yellow, 'R', 'Read the newspapers');
    Option(50, 15, LightBlue, Yellow, 'B', 'Buy supplies');
    Option(50, 16, LightBlue, Yellow, 'C', 'Space Travellers'' Club');
    Option(50, 17, LightBlue, Yellow, 'S', 'View stats');
    Option(50, 19, Magenta, Yellow, 'Q', 'Quit now');
    Key.GetKeys;
    if Key.Key = O then MoonMenu;
    if Key.Key = M then MercuryMenu;
    if Key.Key = V then VenusMenu;
    if Key.Key = A then MarsMenu;
    if Key.Key = T then SaturnMenu;
    if Key.Key = J then JupiterMenu;
    if Key.Key = U then UranusMenu;
    if Key.Key = N then NeptuneMenu;
    if Key.Key = P then PlutoMenu;
    if Key.Key = G then GalaxyMenu;
    if Key.Key = R then Newspaper;
    if Key.Key = B then ShopMenu;
    if Key.Key = C then SpaceClubMenu;
    if Key.Key = V then Stats;
  end;
end;

procedure Newspaper;
begin
  ClrScr;
  DisplayANSI(News, 1, 1, News_Length);
  Key.GetKeys;
end;

procedure ShopMenu;
begin
  ClrScr;
  DisplayANSI(Shop, 1, 1, Shop_Length);
  Key.GetKeys;
end;

procedure SpaceClubMenu;
begin
  ClrScr;
  DisplayANSI(SpaceClub, 1, 1, SpaceClub_Length);
  Option(45, 10, Blue, LightMagenta, 'T', 'Talk to President');
  Option(45, 11, Blue, LightMagenta, 'C', 'Converse with other members');
  Option(45, 12, Blue, LightMagenta, 'L', 'Leave Travellers Club');
  Key.GetKeys;
end;

procedure Stats;
begin
end;

procedure MoonMenu;
begin
  ClrScr;
  DisplayANSI(Moon, 1, 1, Moon_Length);
  Key.GetKeys;
end;

procedure MercuryMenu;
begin
end;

procedure VenusMenu;
begin
end;

procedure MarsMenu;
begin
  ClrScr;
  DisplayANSI(Mars, 1, 1, Mars_Length);
  Option(45, 10, LightRed, Yellow, 'L', 'Look for stray Martians');
  Option(45, 11, LightRed, Yellow, 'V', 'Visit nearest colony');
  Option(45, 12, LightRed, Yellow, 'B', 'Visit base on Mars');
  Option(45, 13, LightRed, Yellow, 'S', 'Supplies');
  Option(45, 15, Blue, Yellow, 'R', 'Return to Earth');
  Key.GetKeys;
end;

procedure SaturnMenu;
begin
  ClrScr;
  DisplayANSI(Saturn, 1, 1, Saturn_Length);
  Key.GetKeys;
end;

procedure JupiterMenu;
begin
  ClrScr;
  DisplayANSI(Jupiter, 1, 1, Jupiter_Length);
  Key.GetKeys;
end;

procedure UranusMenu;
begin
  ClrScr;
  DisplayANSI(Uranus, 1, 1, Uranus_Length);
  Key.GetKeys;
end;

procedure NeptuneMenu;
begin
  ClrScr;
  DisplayANSI(Neptune, 1, 1, Neptune_Length);
  Key.GetKeys;
end;

procedure PlutoMenu;
begin
  ClrScr;
  DisplayANSI(Pluto, 1, 1, Pluto_Length);
  Key.GetKeys;
end;


procedure GalaxyMenu;
begin
  ClrScr;
  DisplayANSI(Galaxy, 1, 1, Galaxy_Length);
  Key.GetKeys;
end;

begin
  Intro;
  SureYaWannaPlay;
  EarthMenu;
  ClrScr;
end.

unit MagScrn;
interface
uses Buttons;
procedure Window1;
procedure Window2;
procedure Window3;
procedure Line(Col: Word);
procedure GeneralScreen(BFore, BBack, Fore, Back: Word; TopMsg, BotMsg: string);
procedure HighLightBar(Length: integer; Colour, OrigColour: Word);
function Reatln(MaxLen: integer): string;
var
  ReatlnChar: KeyType;

implementation
uses Crt;
procedure Line;
var
  X: byte;
begin
  TextColor(Col);
  For X:= 1 to 80 do Write(#196);
end;

procedure Window1;
begin
  Window(1, 2, 80, 8);
  ClrScr;
end;

procedure Window2;
begin
  Window(1, 10, 80, 16);
  ClrScr;
end;

procedure Window3;
begin
  Window(1, 18, 80, 24);
  ClrScr;
end;

function Reatln(MaxLen: integer): string;
var
  StartX, X: integer;
  S, St: string;
  Stop: Boolean;
begin
  S:= '';  St:= '';
  Stop:= False;
  StartX:= WhereX;
  While not Stop do
  begin
    Key.GetKeys;
    if Ord(Key.KeyOne) in [32..126] then
      begin
        if Length(S) < MaxLen then
        begin
          Write(Key.KeyOne);
          Insert(Key.KeyOne, S, Length(S) + 1);
        end
        else
        begin
          GoToXY(WhereX - 1, WhereY);
          Write(Key.KeyOne);
          Insert(Key.KeyOne, S, Length(S));
        end;
      end;
    if Key.Key = BkSp then
      begin
        if WhereX > StartX then
        begin
          GoToXY(WhereX - 1, WhereY); Write(' ');
          GoToXY(WhereX - 1, WhereY);
          Delete(S, Length(S), 1);
        end;
      end;
    if (Key.Key = Enter) or (Key.Key = Up) or (Key.Key = Down) or
       (Key.Key = Home) or (Key.Key = _End) or (Key.Key = Esc) then
         begin
           Stop:= True;
           ReatlnChar:= Key.Key;
         end;
  end;
  Reatln:= S;
end;

procedure HighLightBar;
var
  I: integer;
begin
  TextBackGround(Colour);
  For I:= 1 to Length do Write(' ');
  TextBackGround(OrigColour);
end;

procedure GeneralScreen;
begin
  TextColor(BFore);
  TextBackGround(BBack);
  Window(1, 1, 80, 25);
  ClrScr;
  GoToXY(40 - Length(TopMsg) div 2, 1);
  Write(TopMsg);
  GoToXY(40 - Length(BotMsg) div 2, 25);
  Write(BotMsg);
  TextColor(Fore);
  TextBackGround(Back);
  Window(1, 2, 80, 24);
  ClrScr;
end;
end.
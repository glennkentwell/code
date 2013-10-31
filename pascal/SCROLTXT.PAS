program Text;
uses Crt, Graph, GrafBits;
var
  XPos, YPos: integer;
  X, Y, C: integer;
  Texta: string;

begin
  If ParamCount = 0 then
    Texta:= 'You didn''t type in a string, dickhead.'
    else
    begin
      Texta:= '';
      For X:= 1 to ParamCount do
        Texta:= Texta + ' ' + ParamStr(X);
    end;
  GraphicsScreen;
  SetTextStyle(0, 0, 2);
  Repeat
    ClearDevice;
    XPos:= Random(MaxX - TextWidth(Texta));
    YPos:= Random(MaxY - TextHeight(Texta));
    X:= 0;
    SetColor(Red);
    C:= TextWidth('X') * Y;
    For Y:= 1 to Length(Texta) do
    begin
      C:= TextWidth('X') * Y;
      OutTextXY(XPos div 2 + C, YPos, Texta[Y]);
      Delay(50);
    end;
    For Y:= 1 to Length(Texta) do
    if not KeyPressed then
    begin
      C:= TextWidth('X') * Y;
      SetColor(Yellow);
      OutTextXY(XPos div 2 + C, YPos, Texta[Y]);
      Delay(20);
      SetColor(Red);
      OutTextXY(XPos div 2 + C, YPos, Texta[Y]);
    end;
    For Y:= Length(Texta) downto 1 do
    if not KeyPressed then
    begin
      C:= TextWidth('X') * Y;
      SetColor(Yellow);
      OutTextXY(XPos div 2 + C, YPos, Texta[Y]);
      Delay(20);
      SetColor(Red);
      OutTextXY(XPos div 2 + C, YPos, Texta[Y]);
    end;
  Until KeyPressed;
  ReadKey;
  CloseGraph;
end.
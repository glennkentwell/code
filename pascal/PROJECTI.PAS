program Projectiles;
uses Crt, Graph, GrafBits;
var
  Time,
  XDist, YDist: longint;
  Theta, Velocity,
  SpeedHoriz, SpeedVert: real;

function AskStuff(Msg: string): real;
var
  Ch: char;
  BufStr, Str: string;
  Number: real;
  XPos, YPos,
  Code: integer;
begin
  ClearDevice;
  Str:= '';
  SetTextStyle(0, 0, 1);
  SetUserCharSize(1, 2, 1, 2);
  OutText('Enter ' +  Msg + ' : ');
  XPos:= TextWidth('Enter ' + Msg + ' : ');
  YPos:= 0;
  Ch:= ReadKey;
  While Ch <> #13 do
  begin
    if Ch in ['0'..'9','.'] then
    begin
      OutText(Ch);
      Insert(Ch, Str, Length(Str) + 1);
      Inc(XPos, TextWidth(Ch));
    end
    else if Ch = #8 then
    begin
      Dec(XPos, TextWidth('5'));
      MoveTo(XPos, YPos);
      SetFillStyle(1, Black);
      Bar(XPos, YPos, XPos + TextWidth('H'), YPos + TextHeight('H'));
      MoveTo(XPos, YPos);
      BufStr:= '';
      For Code:= 1 to Length(Str) - 1 do
        BufStr[Code]:= Str[Code];
      Str:= BufStr;
    end;
    Ch:= ReadKey;
  end;
  Val(Str, Number, Code);
  AskStuff:= Number;
end;

procedure Calculate;
begin
  Theta:= AskStuff('angle');
  Velocity:= AskStuff('velocity');
  ClearDevice;
  SpeedHoriz:= Velocity * (Cos(Theta));
  SpeedVert:= Velocity * (Sin(Theta));
  Time:= 1;
  YDist:= 1;
  While (YDist <> 0) and (not KeyPressed) do
  begin
    YDist:= Round((SpeedVert * (Time div 1000)) + (9.8 * Sqr(Time div 1000))/2);   { s = ut + 1/2a * Sqr(t) }
    XDist:= Round((SpeedHoriz * (Time div 1000)) + (9.8 * Sqr(Time div 1000))/2);
    Inc(Time, 100);
    PutPixel(XDist, MaxY - YDist, Yellow);
    Delay(10);
    if XDist = 0 then XDist:= 1;
    if YDist = 0 then YDist:= 1;
    SpeedHoriz:= Round(((Time div 1000) + (9.8 * Sqr(Time div 1000))/2) /XDist);
    SpeedVert:= Round(((Time div 1000) + (9.8 * Sqr(Time div 1000))/2) /YDist);
    ClearDevice;
  end;
end;

begin
  GraphicsScreen('\tp\bgi');
  Calculate;
end.

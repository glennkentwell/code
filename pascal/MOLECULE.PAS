program Nothing;
Uses Graph, Crt, GrafBits, Strings;
Var
  Gd, Gm,
  X, Y, Nums,
  XP, YP, Tmr,
  Rad, Col: integer;
  Ch: Char;
  S: string[50];
  Ps: array[0..50] of Char;
  JustHelping: Boolean;

procedure WriteOptions;
begin
  CloseGraph;
  JustHelping:= True;
  Writeln('The colours for this little bubble thingy are :-');
  Writeln('Red');
  Writeln('Blue');
  Writeln('Yellow');
  Writeln('Green');
  Writeln('Magenta');
  Writeln('Purple');
  Writeln('Aqua');
  Writeln('Grey');
end;

procedure ArGeeBees;
var
  Wd: Colour;
begin
  Y:= 0;
  S:= ParamStr(1);
  StrPCopy(Ps, S);
  if S = '?' then WriteOptions
    else JustHelping:= False;
  S:= StrPas(StrUpper(Ps));
  if not JustHelping then
  begin
    if S = 'RED' then Wd:= Re else
      if S = 'BLUE' then Wd:= Bl else
        if S = 'YELLOW' then Wd:= Ye else
          if S = 'GREEN' then Wd:= Gr else
            if S = 'MAGENTA' then Wd:= LPu else
              if S = 'PURPLE' then Wd:= Pu else
                if S = 'AQUA' then Wd:= Aq else
                  if S = 'GREY' then Wd:= Grey else Wd:= Gr;
    GradePalette(Wd);
  end;
end;

procedure ActualBubbles;
begin
  Randomize;
  Nums:= 0;
  Repeat
    Inc(Nums);
    if Nums = 100 then
    begin
      Nums:= 0;
      ClearDevice;
    end;
    XP:= Random(MaxX);
    YP:= Random(MaxY);
    Rad:= Random(60) + 30;
    Tmr:= Rad div 15;
    Y:= 15;
    For X:= 0 to 15 do
    begin
      Inc(Y);
      SetFillStyle(1, Y);
      SetColor(Y);
      FillEllipse(XP, YP, Rad, Rad);
      Dec(Rad, Tmr);
    end;
  Until KeyPressed;
end;

begin
  VESAScreen(1);
  ScreenVars;
  ArGeeBees;
  if not JustHelping then ActualBubbles;
  While KeyPressed do ReadKey;
  CloseGraph;
end.
program Nothing;
Uses Graph, Crt, GrafBits, Strings;
var
  X, Y,
  XP, YP, Rad, Tmr : integer;
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
                  if S = 'GREY' then Wd:= Grey else Wd:= Pu;
    GradePalette(Wd);
  end;
end;

procedure DoBubbles;
var
  Others: array[1..20, 1..4] of integer;
  NumOthers, Inty: integer;
begin
  Randomize;
  XP:= Random(MaxX);
  YP:= Random(MaxY);
  Rad:= Random(40) + 20;
  Tmr:= Rad div 15;
  NumOthers:= Random(20) + 1;
  For Inty:= 1 to NumOthers do
  begin
    Others[Inty, 1]:= Random(120) - (Random(60));
    Others[Inty, 2]:= Random(120) - (Random(60));
    Others[Inty, 3]:= Random(40) + 20;
    Others[Inty, 4]:= Others[Inty, 3] div 15
  end;
  Y:= 15;
  For X:= 0 to 15 do
  begin
    Inc(Y);
    SetFillStyle(1, Y);
    SetColor(Y);
    FillEllipse(XP, YP, Rad, Rad);
    For Inty:= 1 to NumOthers do
    begin
      FillEllipse(XP + Others[Inty, 1], YP + Others[Inty, 2], Others[Inty, 3], Others[Inty, 3]);
      Dec(Others[Inty, 3], Others[Inty, 4]);
    end;
    Dec(Rad, Tmr);
  end;
end;

begin
  GraphicsScreen;
  ArGeeBees;
  While not KeyPressed do DoBubbles;
  CloseGraph;
end.
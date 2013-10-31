program Pistons;
Uses Graph, GrafBits, Crt, Dos;
type
  TPiston = object
    X, Y, Number : integer;
    Dir, Fire: Boolean;
    procedure Init;
    procedure Vroom;
    procedure DrawMe;
  end;

Var
  Piston: array[1..4] of TPiston;
  PistonPic: Pointer;
  F: File;
  Size, Result: Word;
  I, J, Motion, Dela, RevCount, Snd : integer;
  Del : Real;
  H, M, S, Hu, H1, M1, S1, Hu1: Word;
  Min, Sec, Hund, Hr, Se, Mi, Hun,
  Time, Revs : real;

procedure CountRevs;
Var St : String;
begin
  Sec := S - S1;
  if Sec < 0 then Sec:= 60 + Sec;
  Se := Sec/60;
  Hun := Hu - Hu1;
  if Hun < 0 then Hund:= 100 + Hun;
  Hun := (Hund/100) /60;
  Time := Se + Hun;
  Revs := RevCount/Time;
  RevCount:= 0;
  Str(Revs:4:2, St);
  Insert(' RPM', St, Length(St) + 1);
  Bar(DivX - 100, 0, DivX + 100, 40);
  SetColor(LightGreen);
  OutTextXY(DivX, 20, St);
  SetColor(Black);
  GetTime (H1, M1, S1, Hu1);
end;

procedure TPiston.Init;
begin
  X := 50 * I + 20 * I + DivX - 200;
  if (I = 2) or (I = 3) then
  begin
    Y := DivY - 25;
    Dir := True;
  end
  else
  begin
    Y := DivY + 25;
    Dir := False;
  end;
  if (I = 1) or (I = 3) then Fire := True;
  Number := I;
end;

procedure TPiston.Vroom;
begin
  Case Dir of
    True:
    begin
      Inc(Y, Motion);
      if Y > DivY + 20 then
      begin
        Dir := False;
        Y := DivY + 20;
      end;
    end;
    False:
    begin
      Dec(Y, Motion);
      if Y < DivY - 20 then
      begin
        Dir := True;
        Y := DivY - 20;
        if Snd <> 0 then
        if I = 1 then
        begin
          Inc(RevCount);
          if RevCount = 10 then CountRevs;
        end;
        if Fire = True then
          begin
            Fire := False;
            if Snd <> 0 then
            begin
              Point(50 * I + I * 20 + DivX - 175, DivY - 40, 18, Yellow);
              Sound(Snd); Delay(1);
              Point(50 * I + I * 20 + DivX - 175, DivY - 40, 18, Black);
              NoSound;
              GetTime (H, M, S, Hu);
            end;
          end
        else Fire := True;
      end;
    end;
  end;
end;

procedure TPiston.DrawMe;
begin
  PutImage(X, Y, PistonPic^, XORPut);
end;

procedure GetPistonImage;
begin
  Size := ImageSize(DivX - 25, DivY - 25, DivX + 25, DivY + 20);
  GetMem(PistonPic, Size);
  Assign(F, 'c:\glenns\PISTON.PIC');
  Reset(F, Size);
  BlockRead(F, PistonPic^, 1, Result);
  Close(F);
end;

procedure GetDelay;
begin
  Val(ParamStr(1), Del, I);
  if Del < 1 then
  begin
    Dela := Round(1000 * Del);
    Motion := 5;
  end
  else
  begin
    Dela := 0;
    Motion := Round(Del);
  end;
  if ParamCount = 2 then Snd := 0 else Snd := 100;
end;

begin
  I:= VGA;
  J:= 1;
  InitGraph(I, J, 'C:\TP\BGI');
  DivX:= GetMaxX div 2;
  DivY:= GetMaxY div 2;
  GetTime (H1, M1, S1, Hu1);
  GetDelay;
  GetPistonImage;
    For I := 1 to 4 do
      Piston[I].Init;
  ClearDevice;
    SetColor(Black);
    SetFillStyle(1, Black);
  Repeat
    SetVisualPage(2);
    SetActivePage(1);
    Delay(Dela);
    Bar(DivX - 200, DivY - 50, DivX + 200, DivY + 70);
    For I := 1 to 4 do Piston[I].DrawMe;
    For I := 1 to 4 do Piston[I].Vroom;
    SetVisualPage(1);
    SetActivePage(2);
    Delay(Dela);
    Bar(DivX - 200, DivY - 50, DivX + 200, DivY + 70);
    For I := 4 downto 1 do Piston[I].DrawMe;
    For I := 4 downto 1 do Piston[I].Vroom;
  Until KeyPressed;
  ReadKEy;
  CloseGraph;
end.


{$N+,E+}  { 8087 Emulator Compiler Directive }
program Speed;
Uses Graph, Crt, GrafBits, ScrnWrit;
const GearName: array[1..7] of string[10] = ('1st Gear', '2nd Gear',
                                             '3rd Gear', '4th Gear',
                                             '5th Gear', '6th Gear',
                                             '7th Gear');
type
  TCar = object
    Ratio: array[1..7] of real;
    CarName: string;
    FinalDrive,
    WheelRevs, TotalWheelCirc, WheelDiam, TyreWidth, TyreProfile: real;

  end;

Var
  KMH: array[1..7, 0..40] of real;
  Revs: array[0..40] of integer;
  Pix, MaxKMH, XPix, YPix: real;
  RPM, Gear,
  PixX, PixY,
  Gd, Gm,
  Skip, Count,
  ParamCounter,
  I, It: integer;
  S: String;
  Ch:Char;
  F: text;

procedure ScreenForAsk;
begin
  TextBackGround(Blue);
  Window(1, 1, 80, 25);
  ClrScr;
  TextColor(Yellow);
  GoToXY(10, 4); Write('Car Name: ');
  GoToXY(20, 6); Write('ENTER RATIOS');
  GoToXY(10, 8); Write('1st Gear: ');
  GoToXY(10, 9); Write('2nd Gear: ');
  GoToXY(10, 10); Write('3rd Gear: ');
  GoToXY(10, 11); Write('4th Gear: ');
  GoToXY(10, 12); Write('5th Gear: ');
  GoToXY(10, 13); Write('6th Gear: ');
  GoToXY(10, 14); Write('7th Gear: ');
  GoToXY(7, 16); Write('Final Drive:');
  GoToXY(8, 17); Write('Wheel Diam: ');
  GoToXY(30, 17); Write('[inches]');
  GoToXY(8, 18); Write('Tyre Width: ');
  GoToXY(30, 18); Write('[mm]');
  GoToXY(6, 19); Write('Tyre Profile: ');
end;

procedure OpenFile;
begin
  ParamCounter:= ParamCount;
  if ParamCounter <> 0 then
  begin
    Assign(F, ParamStr(1));
    Reset(F);
  end;
end;

procedure AskUser;
begin
  TextColor(Blue);
  TextBackGround(Blue);
  ClrScr;
  TextColor(Yellow);
  Frame(10, 8, 70, 20, 2, '');
  GoToXY(9, 2); Write('That''s the end of the file ', ParamStr(1), '!');
  GoToXY(9, 4); Write('Press the number of your choice:');
  GoToXY(16, 6); Write('[ 1 ] Graph the same car again');
  GoToXY(16, 8); Write('[ 2 ] Enter new ratios');
  GoToXY(16, 10); Write('[ 3 ] Quit SPEED');
  Ch:= ReadKey;
  Case Ch of
    '1': Reset(F);
    '2':
    begin
      ParamCounter:= 0;
      Close(F);
    end;
    '3': Ch:= #27;
  end;
end;

procedure ReadFromFile;
begin
  if Eof(F) then AskUser;
  if ParamCounter <> 0 then
  begin
    ReadLn(F, CarName);
    For I:= 1 to 7 do
    begin
      Read(F, Ratio[I]);
      if Ratio[I] = 0 then Ratio[I]:= 1000;
    end;
    Readln(F, FinalDrive);
    Readln(F, WheelDiam);
    Readln(F, TyreWidth);
    Readln(F, TyreProfile);
  end;
end;

procedure CloseFile;
begin
  if ParamCounter <> 0 then
  Close(F);
end;

procedure Ask;
const GoToer = 20;
begin
  TextMode(Co80);
  if ParamCounter <> 0 then ReadFromFile;
  if ParamCounter = 0 then
  begin
    ScreenForAsk;
    TextColor(White);
    GoToXY(GoToer, 4); ReadLn(CarName);
    For I:= 1 to 7 do
    begin
      GoToXY(GoToer, I + 7);
      Read(Ratio[I]);
      if Ratio[I] = 0 then Ratio[I]:= 1000;
    end;
    GoToXY(GoToer, 16); Readln(FinalDrive);
    GoToXY(GoToer, 17); Readln(WheelDiam);
    GoToXY(GoToer, 18); Readln(TyreWidth);
    GoToXY(GoToer, 19); Readln(TyreProfile);
  end;
end;

function FindWheelDiam: real;
Var
  R, Re: real;
begin
  R:= WheelDiam * 24.5;
  Re:= (TyreWidth * TyreProfile) / 100;
  FindWheelDiam:= (R + (Re * 2)) / 1000;        {Convert to metres}
end;

function WheelCircum: real;
begin
  WheelCircum:= (FindWheelDiam * Pi) / 1000; {Convert to Km}
end;

procedure FindSpeeds(GearRatio: real);
Var
  Int: integer;
  Ret: extended;
begin
  RPM:= 250;
  Int:= 1;
  TotalWheelCirc:= WheelCircum;
  While RPM <= 10000 do
  begin
    Ret:= RPM;
    Ret:= Ret * 60;
    WheelRevs:= Ret / (GearRatio * FinalDrive);
    KMH[It, Int]:= WheelRevs * TotalWheelCirc;
    if KMH[It, Int] > MaxKMH then MaxKMH:= KMH[It, Int];
    Revs[Int]:= RPM;
    Inc(Int);
    Inc(RPM, 250);
  end;
  if MaxKMH > 360 then MaxKMH:= 360;
end;

procedure WorkItOut;
Var Itl: integer;
begin
  For It:= 1 to 7 do
  begin
    KMH[It, 0]:= 0;
    FindSpeeds(Ratio[It]);
  end;
    Revs[0]:= 0;
end;

function GetPixX: integer;
begin
  Pix:= MaxX;
  XPix:= Pix / 10000;
  GetPixX:= Round(XPix * 1000);
end;

function GetPixY: integer;
begin
  Pix:= MaxY;
  YPix:= Pix / MaxKMH;
  GetPixY:= Round(YPix * 10);
end;

procedure InitGraphScreen;
begin
  Gd:= Detect;
  InitGraph(Gd, Gm, '');
  ScreenVars;
  PixX:= GetPixX;
  PixY:= GetPixY;
  SetFillStyle(1, White);
  FloodFill(1, 1, White);
end;

procedure DarkAxisLines;
begin
  SetColor(DarkGray);
  I:= PixY;
  While I < MaxY do
  begin
    Inc(I, PixY);
    Line(PixX, MaxY - I, MAxX, MaxY - I);
  end;
  SetColor(DarkGray);
  I:= 0;
  While I < MaxX do
  begin
    Inc(I, PixX);
    Line(I, MAxY - PixY * 2, I, 0);
    SetFillStyle(1, Green);
    FloodFill(1, 1, DarkGray);
  end;
end;

procedure LightAxisLines;
begin
  SetColor(LightGray);
  I:= PixY + (PixY div 2);
  While I < MaxY do
  begin
    Inc(I, PixY);
    Line(PixX, MaxY - I, MAxX, MaxY - I);
  end;
  SetColor(LightGray);
  I:= PixX div 4;
  While I < MaxX do
  begin
    Inc(I, PixX div 4);
    Line(I, MAxY - PixY * 2, I, 0);
  end;
end;

procedure AxisLabels;
begin
  SetTextJustify(1, 1);
  SetColor(Red);
  I:= 0;
  Count:= 0;
  While Count < 9000 do
  begin
    Str(Count, S);
    OutTextXY((I * PixX) + PixX, MaxY - (PixY + (PixY div 2)), S);
    Inc(I);
    Inc(Count, 1000);
  end;
  Count:= 0;
  I:= 0;
  OutTextXY(DivX, MaxY - (PixY div 2), 'Engine Speed (RPM)');
  SetColor(Blue);
  SetTextStyle(0, 1, 1);
  OutTextXY((PixX div 4), DivY, 'Car Speed (KM/H)');
  SetTextStyle(0, 0, 1);
  While Count < 400 do
  begin
    Str(Count, S);
    OutTextXY((PixX div 4) * 3, MaxY - ((PixY * I) + (PixY * 2)), S);
    Inc(I);
    Inc(Count, 10);
  end;
  SetTextStyle(0, 0, 2);
  SetTextJustify(1, 1);
  OutTextXY(DivX, 20, CarName);
  SetTextStyle(0, 0, 1);
end;

procedure DrawTheGraph;
Var
  XPos, YPos, XPoss, YPoss: integer;
begin
  InitGraphScreen;
  LightAxisLines;
  DarkAxisLines;
  AxisLabels;
  Skip:= MaxX div PixX;
  For Gear:= 1 to 7 do
  begin
    SetColor(Gear);
    For I:= 1 to 40 do
    begin
      if Ratio[Gear] <> 1000 then
      begin
        XPos:= Round(XPix * Revs[I-1]) + PixX;
        YPos:= MaxY - Round(YPix * KMH[Gear, I - 1]) - (PixY * 2);
        XPoss:= Round(XPix * Revs[I]) + PixX;
        YPoss:= MaxY - Round(YPix * KMH[Gear, I]) - (PixY * 2);
        Line(XPos, YPos, XPoss, YPoss);
        if I = 25 then
          OutTextXY(XPoss, YPoss, GearName[Gear]);
      end;
  end;
end;
  Ch:= ReadKey;
  CloseGraph;
end;

procedure DisplayFigures;
begin
  TextMode(co80 + Font8x8);
  TextColor(White);
  TextBackGround(Blue);
  It:= 1;
  Ch:= #0;
  While Ch <> #27 do
  begin
    TextColor(Yellow);
    ClrScr;
    WriteLn;
    WriteLn(CarName);
    WriteLn;
    WriteLn(GearName[It]);
    WriteLn;
    TextColor(White);
    For I:= 0 to 40 do
      WriteLn('At ', Revs[I], ' RPM, speed = ',KMH[It, I]:4:2, ' km/h');
    WriteLn;
    TextColor(Yellow);
    WriteLn('Press SPACE BAR for next gear, ENTER for previous gear, ESCAPE to go to graph.');
    Ch:= ReadKey;
    if Ch = #13 then Dec(It);
    if It < 1 then It:= 1;
    if Ch = ' ' then Inc(It);
    if It > 7 then It:= 7;
  end;
  Ch:= #0;
  if ParamCounter <> 0 then Reset(F);
end;

begin
  OpenFile;
  Repeat
    Ask;
    WorkItOut;
    DrawTheGraph;
    if Ch = #0 then
      Ch:= ReadKey;
      if Ch = #59 then DisplayFigures;
  Until Ch = #27;
  TextMode(Co80);
end.




program ReadFromFilesMan;
uses Graph, Crt, GrafBits;
type
  TMan = object
    XSize, YSize,
    CurrentPic: Byte;
    Dir: Boolean;
    XPos, YPos: integer;
    procedure MoveMe(XDist, YDist: integer);
    procedure MoveTheMan;
    procedure Jump;
    function Position: longint;
  end;

  TLift = object
    XPos, YPos: integer;
    procedure PutAt(Xx, Yy: integer);
    procedure Rise;
    function Position: longint;
  end;

var
  Ch: char;
  F: File;
  Size: Word;
  X, Y,
  Gd, Gm: integer;
  Still,
  Rt1, Rt2,
  Lt1, Lt2: Pointer;
  Man: TMan;
  Lift1: TLift;

function TMan.Position;
begin
  Position:= XPos + Ypos;
end;

function TLift.Position;
begin
  Position:= XPos + Ypos;
end;

procedure TLift.PutAt;
const
   Length = 30;
   Width = 10;
   Colour = 25;
begin
  XPos:= Xx;
  YPos:= Yy;
  SetFillStyle(1, Colour);
  SetColor(Colour);
  Bar(XPos, YPos, XPos + Length, Ypos + Width);
end;

procedure TLift.Rise;
var
  Xp, Yp: integer;
  Size: word;
  Lift: Pointer;
begin
  Size:= ImageSize(XPos, YPos - 30, XPos + 30, YPos + 22);
  GetMem(Lift, Size);
  GetImage(XPos, YPos - 30, XPos + 30, YPos + 22, Lift^);
  For Yp:= 0 to 50 do
    PutImage(XPos, YPos - Yp, Lift^, NormalPut);
end;

procedure TMan.MoveTheMan;
begin
  Case Dir of
    True:
      begin
        if CurrentPic = 1 then CurrentPic:= 0
          else CurrentPic:= 1;
        if CurrentPic = 0 then PutImage(XPos, YPos, Rt1^, NormalPut)
          else
            PutImage(XPos, YPos, Rt2^, NormalPut);
      end;
    False:
      begin
        if CurrentPic = 1 then CurrentPic:= 0
          else CurrentPic:= 1;
        if CurrentPic = 0 then PutImage(XPos, YPos, Lt1^, NormalPut)
        else
          PutImage(XPos, YPos, Lt2^, NormalPut);
      end;
  end;
  Sound(120);
  Delay(1);
  NoSound;
end;

procedure TMan.MoveMe;
begin
  if XDist >= 0 then Dir:= True
    else Dir:= False;
  XPos:= XPos + XDist;
  YPos:= YPos + YDist;
  if XDist <> 0 then MoveTheMan
  else
    PutImage(XPos, YPos, Still^, NormalPut);
end;

procedure TMan.Jump;
const
  Del = 10;
  Snd = 100;
var
  Ht, Move: integer;
  LMover, RMover: Boolean;
  Imij: Pointer;
begin
  Ht:= 0;
  Move:= 0;
    Ch:= ReadKey;
    Case Ch of
      #0:
      begin
        Ch:= ReadKey;
        Case Ch of
          #75: LMover:= True;
          #77: RMover:= True;
        end;
      end;
    end;
  if RMover then Imij:= @Rt2^
  else
    if LMover then Imij:= @Lt2^
    else Imij:= @Still^;
  Repeat
    PutImage(XPos, YPos - Ht, Imij^, NormalPut);
    Inc(Ht, 2);
    if RMover then Inc(XPos);
    if LMover then Dec(XPos);
    Sound(Ht * Snd);
    Delay(Del);
  Until Ht >= 50;
  Repeat
    PutImage(XPos, YPos - Ht, Imij^, NormalPut);
    Dec(Ht, 2);
    if RMover then Inc(XPos);
    if LMover then Dec(XPos);
    Sound(Ht * Snd);
    Delay(Del);
  Until Ht <= 0;
  NoSound;
end;

procedure Initialize;
begin
  Gd:= InstallUserDriver('VGA256', nil);
  Gm:= 1;
  InitGraph(Gd, Gm, '\tp\bgi');
  ScreenVars;
end;

procedure ReadFromFiles;
begin
  Size:= ImageSize(0, 0, 25, 30);

  GetMem(Still, Size);
  GetMem(Rt1, Size);
  GetMem(Rt2, Size);
  GetMem(Lt1, Size);
  GetMem(Lt2, Size);

  Assign(F, '\GLENNS\STILLMAN.PIC');
  Reset(F, Size);
  BlockRead(F, Still^, 1);
  Close(F);

  Assign(F, '\GLENNS\RIGHT1.PIC');
  Reset(F, Size);
  BlockRead(F, Rt1^, 1);
  Close(F);

  Assign(F, '\GLENNS\RIGHT2.PIC');
  Reset(F, Size);
  BlockRead(F, Rt2^, 1);
  Close(F);

  Assign(F, '\GLENNS\LEFT1.PIC');
  Reset(F, Size);
  BlockRead(F, Lt1^, 1);
  Close(F);

  Assign(F, '\GLENNS\LEFT2.PIC');
  Reset(F, Size);
  BlockRead(F, Lt2^, 1);
  Close(F);
end;

procedure TestForCollisions;
var LPos, MPos: longint;
begin
  MPos:=Man.Position;
  LPos:=Lift1.Position;
  if Man.Position > Lift1.Position - 10 then
    if Man.Position < Lift1.Position + 10 then
       Lift1.Rise;
end;

procedure KeyMove;
const Del = 10;
begin
  ClearDevice;
  Lift1.PutAt(200, MaxY - 20);
  Y:= MaxY - 30;
  Man.MoveMe(X, Y);
  While Ch <> #27 do
  begin
    TestForCollisions;
    Ch:= ReadKey;
  Case Ch of
    ' ': Man.Jump;
    #0:
    begin
      Ch:= ReadKey;
      Case Ch of
        #75:
        begin
          X:= -5;
          Y:= 0;
          Man.MoveMe(X, Y);
          Delay(Del);
        end;
        #77:
        begin
          X:= 5;
          Y:= 0;
          Man.MoveMe(X, Y);
          Delay(Del);
        end;
        #72:
        begin
          Y:= -1;
          X:= 0;
          Man.MoveMe(X, Y);
          Delay(Del);
        end;
        #80:
        begin
          Y:= 1;
          X:= 0;
          Man.MoveMe(X, Y);
          Delay(Del);
        end;
      end;
    end;
  end;
  end;
end;

begin
  Initialize;
  ReadFromFiles;
  KeyMove;
  CloseGraph;
end.
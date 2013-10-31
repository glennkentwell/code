program CoolShit;
uses Crt, Graph, GrafBits;
const
  X = 1;
  Y = 2;
  MaxTentacles = 49;

type
  EndBit = record
    X, Y: integer;
    Dir: shortint;
  end;
  Star = object
    XPos, YPos: integer;
    Tentacles: shortint;
    Colour: Word;
    Dead: Boolean;
    Tentacle: array[1..MaxTentacles + 1] of EndBit;
    procedure Init;
    procedure Grow;
  end;

var
  Drawn, StarCount, Counter: integer;
  Grower: array[1..20] of Star;

procedure Star.Init;
begin
  Tentacles:= Random(MaxTentacles) + 1;
  XPos:= Random(MaxX);
  YPos:= Random(MaxY);
  For Counter:= 1 to Tentacles do
  begin
    Tentacle[Counter].X:= XPos;
    Tentacle[Counter].Y:= YPos;
    Tentacle[Counter].Dir:= Random(5);
  end;
  Colour:= Random(14) + 1;
  Counter:= 1;
  Dead:= False;
  if Drawn > 100 then
  begin
    SetColor(Black);
    SetFillStyle(1, Black);
    FillEllipse(Random(MaxX), Random(MaxY), Random(MaxX), Random(MaxY));
    Drawn:= 0;
  end;
end;

procedure Star.Grow;
begin
  For Counter:= 1 to Tentacles do
  begin
    Case Tentacle[Counter].Dir of
      0:  begin
            Tentacle[Counter].X:= Tentacle[Counter].X + Random(12) - 5;
     {up}   Tentacle[Counter].Y:= Tentacle[Counter].Y - Random(7);
          end;
      1:  begin
            Tentacle[Counter].X:= Tentacle[Counter].X + Random(7);
   {right}  Tentacle[Counter].Y:= Tentacle[Counter].Y + Random(12) - 5;
          end;
      2:  begin
            Tentacle[Counter].X:= Tentacle[Counter].X - Random(7);
   {left}   Tentacle[Counter].Y:= Tentacle[Counter].Y + Random(12) - 5;
          end;
      4:  begin
            Tentacle[Counter].X:= Tentacle[Counter].X + Random(12) - 5;
    {down}  Tentacle[Counter].Y:= Tentacle[Counter].Y + Random(7);
          end;
    end;
    PutPixel(Tentacle[Counter].X, Tentacle[Counter].Y, Colour);
    if (Tentacle[Counter].X > MaxX) or (Tentacle[Counter].X < 0) or
       (Tentacle[Counter].Y > MaxY) or (Tentacle[Counter].Y < 0) then
       Dead:= True;
  end;
  if Dead then
  begin
    Inc(Drawn);
    Init;
  end;
end;

procedure StartStuff;
begin
  VESAScreen(1);
  Randomize;
  For StarCount:= 1 to 20 do
    Grower[StarCount].Init;
  While not KeyPressed do
  begin
    For StarCount:= 1 to 20 do
      Grower[StarCount].Grow;
  end;
end;

begin
  StartStuff;
  CloseGraph;
  if KeyPressed then ReadKey;
end.

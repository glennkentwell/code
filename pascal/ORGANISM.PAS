program Lifer;
uses
  Graph, Crt,
  GrafBits;

const
  DeathAge = 20;

type
  TLife = object
    XPos, YPos,
    Age, Pixels: integer;
    FirstChild,
    SecondChild: Pointer;

  end;

var
  X, Y: integer;

procedure
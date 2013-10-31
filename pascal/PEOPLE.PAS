program People;
uses
  Crt, Graph,
  GrafBits, Buttons;

const
  MaxPeople = 7500;
type
  StanceType = (Still, LeftLeg, MidStep, RightLeg);
  TPerson = object
    Step,
    X, Y: integer;
    Colour: Word;
    procedure Born;
    procedure Draw(Stance: StanceType);
    procedure Move;
    procedure Walk(Stepping: integer);
    procedure Die;
  end;

var
  X, Y,
  NumPeople,
  Controller,
  NextColour: integer;
  Person: array[1..MaxPeople] of TPerson;
  LastKey: KeyType;

procedure TPerson.Born;
begin
  Colour:= NextColour;
  Inc(NextColour);
  X:= Random(MaxX div 8);
  Y:= Random(MaxY div 16);
  X:= X * 8;
  Y:= Y * 16;
  Step:= 1;
end;

procedure TPerson.Draw;
begin
  SetColor(Colour);
  if Stance = Still then
  begin
    SetFillStyle(1, Black);
    Bar(X - 3, Y - 6, X + 3, Y + 7);
    Line(X, Y + 2, X + 2, Y + 5);      { left thigh      }
    Line(X, Y + 2, X - 2, Y + 5);      { right thigh     }
    Line(X + 2, Y + 5, X + 2, Y + 7);  { left shin       }
    Line(X - 2, Y + 5, X - 2, Y + 7);  { right shin      }
    Line(X + 1, Y - 2, X + 2, Y - 1);  { left upper arm  }
    Line(X - 1, Y - 2, X - 2, Y - 1);  { right upper arm }
    Line(X + 2, Y, X + 2, Y + 1);      { left forearm    }
    Line(X - 2, Y, X - 2, Y + 1);      { right forearm   }
  end;
  if Stance = LeftLeg then
  begin
    Line(X, Y + 3, X - 2, Y + 6);      { left thigh      }
    Line(X, Y + 3, X, Y + 5);          { right thigh     }
    Line(X - 2, Y + 6, X - 2, Y + 7);  { left shin       }
    Line(X + 1, Y + 6, X + 2, Y + 6);  { right shin      }
    Line(X + 1, Y - 2, X + 3, Y);      { left upper arm  }
    Line(X - 1, Y - 2, X - 3, Y);      { right upper arm }
    Line(X + 3, Y, X + 2, Y + 1);      { left forearm    }
    Line(X - 3, Y, X - 4, Y - 1);      { right forearm   }
  end;
  if Stance = MidStep then
  begin
    Line(X, Y + 3, X, Y + 6);          { left thigh      }
    Line(X, Y + 3, X, Y + 6);          { right thigh     }
    Line(X, Y + 6, X + 1, Y + 7);      { left shin       }
    Line(X, Y + 6, X - 1, Y + 7);      { right shin      }
    Line(X + 1, Y - 2, X + 1, Y + 1);  { left upper arm  }
    Line(X - 1, Y - 2, X - 1, Y + 1);  { right upper arm }
    Line(X + 1, Y + 1, X + 2, Y + 2);  { left forearm    }
    Line(X - 1, Y + 1, X - 2, Y + 2);  { right forearm   }
  end;
  if Stance = RightLeg then
  begin
    Line(X, Y + 3, X + 1, Y + 5);      { left thigh      }
    Line(X, Y + 3, X - 1, Y + 5);      { right thigh     }
    Line(X + 1, Y + 5, X + 3, Y + 5);  { left shin       }
    Line(X - 1, Y + 5, X - 1, Y + 7);  { right shin      }
    Line(X + 1, Y - 2, X - 2, Y);      { left upper arm  }
    Line(X - 1, Y - 2, X + 2, Y - 1);  { right upper arm }
    Line(X - 2, Y, X - 3, Y - 1);      { left forearm    }
    Line(X + 2, Y - 1, X + 2, Y);      { right forearm   }
  end;
  SetColor(Colour);
  SetFillStyle(1, Colour);
  Line(X, Y - 3, X, Y + 2);            { body }
  FillEllipse(X, Y - 5, 2, 1);         { head }
end;

procedure TPerson.Move;
begin
  if Step = 1 then
  Draw(LeftLeg);
  if Step = 2 then
  Draw(RightLeg);
  if Step = 3 then
  Draw(MidStep);
  Delay(30);
  Inc(Step);
  if Step > 3 then Step:= 1;
end;
{  Bar(X - 8, Y - 10, X + 7, Y + 11);}

procedure TPerson.Walk;
var
  Steps: integer;
begin
  For Steps:= 1 to Stepping do
  begin
    SetFillStyle(1, Black);
    if Key.Key = Left then
      if X > 8 then
      begin
        Dec(X, 4);
        Bar(X - 3, Y - 6, X + 7, Y + 7);
        Move;
      end;
    if Key.Key = Right then
      if X < MaxX - 8 then
      begin
        Inc(X, 4);
        Bar(X - 8, Y - 6, X + 3, Y + 7);
        Move;
      end;
    if Key.Key = Up then
      if Y > 11 then
      begin
        Dec(Y, 4);
        Bar(X - 4, Y - 6, X + 3, Y + 11);
        Move;
      end;
    if Key.Key = Down then
      if Y < MaxY - 11 then
      begin
        Inc(Y, 4);
        Bar(X - 4, Y - 10, X + 3, Y + 7);
        Move;
      end;
  end;
end;

procedure TPerson.Die;
begin
end;

procedure Init;
begin
  Write('Number of people : ');
  Readln(NumPeople);
  Writeln('Do you want : ');
  Writeln('              1.  Keyboard control');
  Writeln('              2.  Computer control');
  Write  ('              ');
  Readln(Controller);
  Randomize;
  GraphicsScreen;
{  VGA256;
  VESAScreen(1); }
  NextColour:= 1;
end;

procedure KeyboardControl;
begin
  For X:= 1 to NumPeople do
  begin
    Person[X].Born;
    Person[X].Draw(Still);
  end;
  While Key.Key <> Esc do
  begin
    if Key.Key <> Esc then Key.GetKeys;
    LastKey:= Key.Key;
    While (Key.Key = LastKey) and (Key.Key <> Esc) do
    begin
      Person[X].Walk(1);
      Key.GetKeys;
    end;
    Person[X].Draw(Still);
    Inc(X);
    if X > NumPeople then X:= 1;
  end;
end;

procedure FindDirection;
var
  Direction: integer;
begin
  Direction:= Random(4) + 1;
  if Direction = 1 then Key.Key:= Up;
  if Direction = 2 then Key.Key:= Down;
  if Direction = 3 then Key.Key:= Left;
  if Direction = 4 then Key.Key:= Right;
end;

procedure RandomControl;
var
  Distance: integer;
begin
  For X:= 1 to NumPeople do
  begin
    Person[X].Born;
    Person[X].Draw(Still);
  end;
  While not KeyPressed do
  begin
    FindDirection;
    Distance:= Random(MaxY div 10) + 1;
    Person[X].Walk(Distance);
    For Y:= 1 to NumPeople do
      Person[Y].Draw(Still);
    Inc(X);
    if X > NumPeople then X:= 1;
  end;
end;

procedure Start;
begin
  if Controller = 1 then KeyBoardControl;
  if Controller <> 1 then RandomControl;
end;

begin
  Init;
  Start;
  CloseGraph;
end.

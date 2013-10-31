program TryTurtle;
Uses Crt, Graph3;
Var
  Gd, Gm, X, Y: integer;
  Ch: Char;

procedure Setdelay(C: Char);
begin
  if C = 'f' then Dec(X, 5)
  else Inc(X, 5);
  if X < 0 then X:= 0;
  TurtleDelay(X);
end;


begin
{  Gd:= EGA;
  Gm:= 0;
  InitGraph(Gd, Gm,'C:\TP\BGI');}
  GraphColorMode;
  ClearScreen;
  Wrap;
  X:= 20;
  TurtleDelay(X);
  PenDown;
  Home;
  ShowTurtle;
    Repeat
      begin
      Ch:= ReadKey;
      Case Ch of
      #0:
      begin
        Ch:= ReadKey;
        Case Ch of
          #72:begin
                SetHeading(North);
                Forwd(1);
              end;
          #75:begin
                SetHeading(West);
                Forwd(1);
               end;
          #77:begin
                SetHeading(East);
                Forwd(1);
              end;
          #80:begin
                SetHeading(South);
                Forwd(1);
              end;
          #115:begin
                 SetHeading(West);
                 Forwd(4);
               end;
          #116:begin
                 SetHeading(East);
                 Forwd(4);
               end;
        end;
      end;
      #13: PenUp;
      ' ': PenDown;
      'n': ClearScreen;
      end;
      end;
    Until Ch = #27;
end.

program Crap;
Uses Crt, ScrnWrit;
Var
  X, Y, Counter, UpTo : integer;
  Ch: array[0..400] of Char;

procedure BackSpace;
begin
  if WhereX = 1 then GoToXY(78, WhereY - 1)
  else GoToXY(WhereX - 1, WhereY);
  Write (' ');
  For X:= Counter to UpTo do
  begin
    Ch[X-1]:= Ch[X];
    Write(Ch[X]);
  end;
end;

procedure EnterKey;
begin
  GoToXY(1, WhereY + 1);
  Ch[Counter]:= #20;
  Inc(Counter);
end;

procedure WriteTheInfo;
begin
  ClrScr;
  X:= Counter;
  GoToXY (1, 10);
  For Counter:= 0 to X do
  Case Ch[Counter] of
    #20: GoToXY(1, WhereY + 1);
    #27:
    begin
      Inc(Counter);
      Dec(Counter);
    end;
    else Write(Ch[Counter])
  end;
end;

procedure Up;
begin
  GoToXY(WhereX, WhereY - 1);
  Dec(Counter, 78);
end;

procedure Down;
begin
  GoToXY(WhereX, WhereY + 1);
  Inc(Counter, 78);
end;

procedure Left;
begin
  GoToXY(WhereX - 1, WhereY);
end;

procedure Right;
begin
  GoToXY(WhereX + 1, WhereY);
end;

begin
  TextBackGround(LightGray);
  ClrScr;
  TextColor(Black);
  Command_Bar('ESC','F1','F2','','','',' Quit  ',' Nothing  ',' Also Nothing','','','');
  TextColor(White);
  TextBackGround(Blue);
  Frame(1, 2, 80, 24, 2, 'TRYHARD EDITOR');
  ClrScr;
  TextColor(Yellow);
  Counter:= 0;
  Repeat
    Ch[Counter]:= ReadKey;
    Case Ch[Counter] of
      #27: X:= 1;
      #8: BackSpace;
      #13: EnterKey;
      #0:
      begin
        Ch[Counter]:= ReadKey;
        Case Ch[Counter] of
          #72: Up;
          #75: Left;
          #77: Right;
          #80: Down;
        end;
      end;
    else
    begin
      Write(Ch[Counter]);
      Inc(Counter);
      UpTo:= Counter;
    end;
    end;
  Until Ch[Counter] = #27;
  WriteTheInfo;
end.
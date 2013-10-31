program KnightsTour;
(*
   Glenn Kentwell  97060941
   Computer Science 1
   Semester 1 1997
   Tutorial 6  (Monday 5-6pm)
   Program to simulate the tour of a knight around a chessboard.
*)
uses Crt;
var
  XPos, YPos,       { represent the chessboard coordinates of the Knight }
  Count,            { Count is used for miscellaneous counting }
  Moves,            { integer to count the number of moves made }
  NewPosition: integer;  { used to select the next move to make }
  TheBoard: array[1..8, 1..8] of integer;  {this 2D array represents the
                                            chessboard }
  GoodPos, Blocked: Boolean;     { GoodPos tests if the new position chosen
                                   has already been moved to or is off the
                                   board
                                   Blocked is used to flag if the Knight is
                                   blocked }

procedure TestPos(X, Y: integer);
{ This procedure tests the new position to see if it has been moved to
  previously, and that it is on the board.  GoodPos returns True if the
  new position is OK.
}
begin
  GoodPos:= False;
  If (X >= 1) and (X <= 8) then
    If (Y >= 1) and (Y <= 8) then
      If TheBoard[X, Y] = 0 then
        GoodPos:= True
end { TestPos };

procedure GetNewPos(X, Y, TryMove: integer);
{ This procedure is called with X and Y being the current position of the
  Knight.  GetNewPos is called repeatedly, with TryMove being given values
  1 to 8 systematically until a position is found for which GoodPos returns
  True
}
var
  OldX, OldY: integer;
begin
  NewPosition:= TryMove;
  OldX:= X;
  OldY:= Y;
  Case NewPosition of
    0:
    begin
      X:= OldX + 1;
      Y:= OldY + 2;
    end;
    1:
    begin
      X:= OldX + 2;
      Y:= OldY + 1;
    end;
    2:
    begin
      X:= OldX - 1;
      Y:= OldY + 2;
    end;
    3:
    begin
      X:= OldX - 2;
      Y:= OldY + 1;
    end;
    4:
    begin
      X:= OldX + 1;
      Y:= OldY - 2;
    end;
    5:
    begin
      X:= OldX + 2;
      Y:= OldY - 1;
    end;
    6:
    begin
      X:= OldX - 1;
      Y:= OldY - 2;
    end;
    7:
    begin
      X:= OldX - 2;
      Y:= OldY - 1;
    end;
  end { Case };
  TestPos(X, Y);
  if GoodPos then
  begin
    XPos:= X;
    YPos:= Y;
  end;
end { GetRandomPos};

procedure StoreMove;
{ This procedure puts the integer value of Moves into the array TheBoard,
  which represents the chessboard.  Moves represents the number of moves
  made by the Knight.
}
begin
  Moves:= Moves + 1;
  TheBoard[XPos, YPos]:= Moves;
end { StoreMove };

procedure DisplayTour;
{ DisplayTour uses the array TheBoard to display a representation of the
  chessboard of the screen.  If the position hasn't been moved to, ** is
  displayed, otherwise the number of the move is displayed in that
  position.
}
begin
  XPos:= 1;
  YPos:= 1;
  While YPos <= 8 do
  begin
    While XPos <= 8 do
    begin
      if TheBoard[XPos, YPos] = 0 then
        Write('**')
      else Write(TheBoard[XPos, YPos]:2);
      Write(' ');
      XPos:= XPos + 1;
    end;
    Writeln;
    XPos:= 1;
    YPos:= YPos + 1;
  end;
  Writeln;
  Write('Number of moves: ', Moves);
  ReadKey;
end { DisplayMove };

procedure TourTheBoard;
{ TourTheBoard moves the Knight from the starting position by calling
  GetNewPos, doing this repeatedly until the Knight cannot move anymore,
  and it is blocked.  TourTheBoard calls the procedure StoreMove after
  each successful move.
}
begin
  Repeat
    Count:= 0;
    Repeat
      GetNewPos(XPos, YPos, Count);
      Count:= Count + 1;
    Until GoodPos or (Count = 9);
    If Count < 9 then
      StoreMove
    else
      Blocked:= True;
  Until Blocked;
end { TourTheBoard };

procedure Initialise;
{ Initialise clears the screen and initialises the random number generator,
  so that a random starting position can be generated for the Knight.  It
  then stores the first move in memory.
}
begin
  ClrScr;
  Randomize;
  XPos:= Random(8) + 1;
  YPos:= Random(8) + 1;
  StoreMove;
end; { Initialise }

begin { Main }
  Initialise;
  TourTheBoard;
  DisplayTour;
end. { Main }



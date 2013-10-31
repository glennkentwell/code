program Burdees;
uses
  Crt, Graph, GrafBits;

type
  TBird = object
    JumpDistance,
    XPos, YPos: integer;
    PicSize: Word;
    Place, Image: Pointer;
    procedure DrawBird;
    procedure FindAPlace;
    procedure JumpToPlace;
  end;

var
  Bird: TBird;
  Ch: char;
  X, Y,
  I: integer;

procedure TBird.DrawBird;
begin
  PutPixel(0, 2, Brown);
  PutPixel(1, 2, Brown);
  PutPixel(1, 3, Brown);
  SetColor(Yellow);
  Line(2, 1, 2, 6);
  Line(3, 0, 3, 6);
  Line(4, 1, 4, 7);
  Line(5, 5, 5, 7);
  Line(6, 7, 7, 7);
  PutPixel(6, 6, Yellow);
  SetColor(Brown);
  Line(3, 8, 3, 9);
  PutPixel(2, 9, Brown);
  PicSize:= ImageSize(0, 0, 7, 9);
  GetMem(Image, PicSize);
  GetMem(Place, PicSize);
  GetImage(0, 0, 7, 9, Image^);
  XPos:= Random(MaxX);
  YPos:= Random(MaxY);
  JumpDistance:= 50;
  ClearDevice;
end;

procedure TBird.FindAPlace;
begin
  PutImage(XPos - 4, YPos - 4, Place^, NormalPut);
  Repeat
    XPos:= Random(MaxX);
    YPos:= Random(MaxY);
  Until (XPos > 0) and (XPos < MaxX) and (YPos > 0) and (YPos < MaxY);
end;

procedure TBird.JumpToPlace;
begin
  GetImage(XPos - 4, YPos - 4, XPos + 3, YPos + 5, Place^);
  PutImage(XPos - 4, YPos - 4, Image^, NormalPut);
end;

procedure FatController;
begin
  Bird.DrawBird;
  Ch:= #0;
  While not KeyPressed do
  begin
    Bird.FindAPlace;
    Bird.JumpToPlace;
    For Y:= 1 to 2 do
    For X:= 5 to 10 do
    begin
      Sound(X * 500);
      Delay(20);
    end;
    NoSound;
    Delay(500);
  end;
  Ch:= ReadKey;
end;

begin
  GraphicsScreen;
  FatController;
  CloseGraph;
end.



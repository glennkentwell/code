program Tennis;
uses Crt, Dos, Graph, GrafBits;
const
  MOUSEINTR = $33;
type
  TBall = object
    MaxMoveDist, Speed,
    X, Y: integer;
    XDir, YDir: shortint;
    Mask, Image: Pointer;
    procedure Init;
    procedure Create;
    procedure Move;
    procedure Draw;
    procedure Erase;
    procedure TestThePosition;
    procedure ChangeDir(Which: Boolean);
  end;
  TPaddle = object
    OldY, Y, Length: integer;
    Image: Pointer;
    procedure Init;
    procedure Move;
    procedure Create;
    procedure Draw;
    procedure Erase;
    function GetPos: integer;
  end;
  TMouse = object
    X, Y: Word;
    ButtonA, ButtonB: Boolean;
    function GetPos: integer;
    procedure GetMousePos(var Ex, Why : word; var button1, button2 : boolean);
  end;

var
  Ball: TBall;
  Paddle: TPaddle;
  Mouse: TMouse;
  Size: Word;
  Left, Top,
  Right, Bottom,
  PaddleWidth: integer;

function TMouse.GetPos: integer;
begin
  GetMousePos(X, Y, ButtonA, ButtonB);
  GetPos:= X;
end;

procedure TMouse.GetMousePos;
var regs : registers;
begin
  regs.ax := 3;
  Intr(MOUSEINTR, regs);
  x := regs.cx;
  y := regs.dx;
  button1 := (regs.bx and 1) <> 0;
  button2 := (regs.bx and 2) <> 0;
end;

procedure TBall.Init;
begin
  MaxMoveDist:= 1;
  Speed:=140000 div MaxY;
  X:= Random(Right - Left) + Left;
  Y:= Random(Bottom - Top) + Top;
  XDir:= 1;
  YDir:= 1;
  Create;
  Draw;
end;

procedure TBall.Create;
begin
  SetColor(Red);
  Circle(X, Y, 3);
  Circle(X, Y, 2);
  SetColor(LightRed);
  Circle(X, Y, 1);
  PutPixel(X, Y, Yellow);
  Size:= ImageSize(X - 3, Y - 3, X + 3, Y + 3);
  GetMem(Image, Size);
  GetImage(X - 3, Y - 3, X + 3, Y + 3, Image^);
end;

procedure TBall.Move;
begin
  Erase;
  TestThePosition;
  Inc(X, XDir);
  Inc(Y, YDir);
  Draw;
end;

procedure TBall.TestThePosition;
var
  PaddlePos: integer;
begin
  PaddlePos:= Paddle.GetPos + PaddleWidth div 2;
  if (Y > Bottom - 2) then
     if (X > PaddlePos - PaddleWidth) and
        (X < PaddlePos) then
          ChangeDir(False)
     else
     begin
       Sound(100);
       Delay(100);
       NoSound;
     end;
  if (X < Left) or (X > Right) then ChangeDir(True);
  if (Y < Top) or (Y > Bottom) then ChangeDir(False);
end;

procedure TBall.Draw;
begin
  PutImage(X - 3, Y - 3, Image^, NormalPut);
end;

procedure TBall.Erase;
begin
  PutImage(X - 3, Y - 3, Image^, XORPut);
end;

procedure TBall.ChangeDir;
var
  NewXDir, NewYDir: shortint;
begin
  Sound(1000);
  Delay(5);
  NoSound;
  if Y > Bottom + 5 then Y:= Bottom - 5;
  if XDir > 0 then NewXDir:= (Random(Ball.MaxMoveDist) + 1) else
    NewXDir:= (Random(Ball.MaxMoveDist) + 1) * -1;
  if YDir > 0 then NewYDir:= (Random(Ball.MaxMoveDist) + 1) else
      NewYDir:= (Random(Ball.MaxMoveDist) + 1) * -1;
  if Which then
  begin
    XDir:= XDir * -1;
    YDir:= NewYDir;
  end
    else
    begin
      YDir:= YDir * -1;
      XDir:= NewXDir;
    end
end;

procedure TPaddle.Init;
begin
  Y:= DivX;
  OldY:= Y;
  Create;
  Erase;
  Y:= Mouse.GetPos;
  OldY:= Y;
  Draw;
end;

procedure TPaddle.Create;
begin
  SetColor(Magenta);
  Line((Y - PaddleWidth div 2) + 2, Bottom, (Y + PaddleWidth div 2) - 2, Bottom);
  SetColor(LightRed);
  Line((Y - PaddleWidth div 2) + 1, Bottom + 1, (Y + PaddleWidth div 2) - 1, Bottom + 1);
  Line(Y - PaddleWidth div 2, Bottom + 2, Y + PaddleWidth div 2, Bottom + 2);
  Line(Y - PaddleWidth div 2 - 1, Bottom + 3, Y + PaddleWidth div 2 + 1, Bottom + 3);
  SetColor(Red);
  Line(Y - PaddleWidth div 2 - 1, Bottom + 4, Y + PaddleWidth div 2 + 1, Bottom + 4);
  Line(Y - PaddleWidth div 2 - 1, Bottom + 5, Y + PaddleWidth div 2 + 1, Bottom + 5);
  SetColor(Yellow);
  PutPixel(Y - PaddleWidth div 3, Bottom + 4, Yellow);
  Circle(Y - PaddleWidth div 3, Bottom + 4, 2);
  PutPixel(Y + PaddleWidth div 3, Bottom + 4, Yellow);
  Circle(Y + PaddleWidth div 3, Bottom + 4, 2);
  Size:= ImageSize(Y - PaddleWidth div 2 - 1, Bottom, Y + PaddleWidth div 2 + 1, Bottom + 6);
  GetMem(Image, Size);
  GetImage(Y - PaddleWidth div 2 - 1, Bottom, Y + PaddleWidth div 2 + 1, Bottom + 6, Image^);
end;

procedure TPaddle.Draw;
begin
  PutImage(Y - PaddleWidth div 2, Bottom, Image^, NormalPut);
end;

procedure TPaddle.Erase;
begin
  PutImage(OldY - PaddleWidth div 2, Bottom, Image^, XORPut);
end;

procedure TPaddle.Move;
begin
  OldY:= Y;
  Y:= Mouse.GetPos;
  if (Y - PaddleWidth div 2 <= Left - 7) then
    Y:= Left + PaddleWidth div 2;
  if (Y + PaddleWidth div 2 >= Right + 7) then
    Y:= Right - PaddleWidth div 2;
  if Y <> OldY then
  begin
    Erase;
    Draw;
  end;
end;

function TPaddle.GetPos;
begin
  GetPos:= Y;
end;

procedure Init;
begin
  GraphicsScreen;
  Randomize;
  Left:= MaxX div 60;
  Top:= MaxY div 20;
  Right:= MaxX - Left;
  Bottom:= MaxY - Top;
  PaddleWidth:= MaxX div 10;
  SetColor(Red);
  Rectangle(Left - 7, Top - 7, Right + 7, Bottom + 7);
end;

procedure BounceBall;
begin
  While not KeyPressed do
  begin
    Ball.Move;
    Paddle.Move;
    Delay(Ball.Speed);
  end;
  ReadKey;
end;

begin
  Init;
  Ball.Init;
  Paddle.Init;
  BounceBall;
  CloseGraph;
end.

program Saver;
uses
  Crt, Graph, GrafBits,
  BGIFont, BGIDriv   ;
var
  P: pointer;
  Size: Word;
  X, Y, I: integer;
  Message: string;

procedure Abort(Msg : string);
begin
  Writeln(Msg, ': ', GraphErrorMsg(GraphResult));
  Halt(1);
end;

procedure Reg;
begin
  { Register all the drivers }
  if RegisterBGIdriver(@HercDriverProc) < 0 then
    Abort('Herc');
  if RegisterBGIdriver(@ATTDriverProc) < 0 then
    Abort('AT&T');
  if RegisterBGIdriver(@PC3270DriverProc) < 0 then
    Abort('PC 3270');
  if RegisterBGIdriver(@EGAVGADriverProc) < 0 then
    Abort('EGA/VGA');

  { Register all the fonts }
  if RegisterBGIfont(@GothicFontProc) < 0 then
    Abort('Gothic');
  if RegisterBGIfont(@SansSerifFontProc) < 0 then
    Abort('SansSerif');
  if RegisterBGIfont(@SmallFontProc) < 0 then
    Abort('Small');
  if RegisterBGIfont(@TriplexFontProc) < 0 then
    Abort('Triplex');
end;

begin
  Reg;
  GraphicsScreen;
  if ParamCount > 0 then
  begin
    For I:= 1 to ParamCount do
      Message:= Message + ParamStr(I) + ' ';
  end
  else Message:= 'two words';
  SetFillStyle(1, Black);
  Randomize;
  SetColor(Random(15) + 1);
  SetTextStyle(Random(5) + 1, 0, Random(3) + 1);
  Y:= Random(MaxY - TextHeight(Message));
  X:= MaxX - TextWidth(Message);
  OutTextXY(X, Y, Message);
  Size:= ImageSize(X, Y, X + TextWidth(Message), Y + TextHeight(Message) * 2);
  GetMem(P, Size);
  GetImage(X, Y, X + TextWidth(Message), Y + TextHeight(Message) * 2, P^);
  While not KeyPressed do
  begin
    X:= MaxX - TextWidth(Message);
    While (not KeyPressed) and (X > 0) do
    begin
      Dec(X);
      PutImage(X, Y, P^, NormalPut);
    end;
    Bar(0, 0, TextWidth(Message), MaxY);
    Y:= Random(MaxY - TextHeight(Message));
  end;
  While KeyPressed do ReadKey;
  CloseGraph;
end.
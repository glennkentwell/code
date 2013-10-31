program Crap;
uses Crt, Cursor, Graph, GrafBits, BGIFont;

var
  Col, X: integer;
  S: string;

procedure Abort(Msg : string);
begin
  Writeln(Msg, ': ', GraphErrorMsg(GraphResult));
  Halt(1);
end;

begin
  if ParamCount <> 0 then S:= ParamStr(1)
    else S:= 'crap';
  if RegisterBGIfont(@GothicFontProc) < 0 then
    Abort('Gothic');
  if RegisterBGIfont(@SansSerifFontProc) < 0 then
    Abort('SansSerif');
  if RegisterBGIfont(@SmallFontProc) < 0 then
    Abort('Small');
  if RegisterBGIfont(@TriplexFontProc) < 0 then
    Abort('Triplex');
  GraphicsScreen;
  GradePalette(Bl);
  SetTextStyle(8, 0, 5);
  While not KeyPressed do
  begin
    Inc(Col);
    if Col > 15 then Col:= 1;
    SetColor(Col);
    SetFillStyle(1, Col);
    FillEllipse(X, Y, 60 - Col*4, 15 - Col);
    Delay(100);
  end;
  ReadKey;
  CloseGraph;
end.
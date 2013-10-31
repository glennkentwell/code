program tennis;
uses crt, graph, grafbits;
var
  Score, Count, GraphDRiver, GraphMode, Errorcode : integer;
  x1, y1, x2, y2, r1, r2, pix, diam, snd, pos, die : integer;
  Size, Size2, MaxX, MaxY : integer;
  Top, Bottom, Left, Right: integer;
  P, P2 : Pointer;
  YesOrNo, key : char;
  path, scorestr, Lives, Spd : string;
  viewport : viewporttype;

procedure write_scores;
begin
  settextstyle (0,0,1);
  Str (Score, ScoreStr);
  Str (3-Die, Lives);
  Str (Pix, Spd);
  setcolor (15);
  setviewport (0,0,getmaxx, 9,clipon);
  clearviewport;
  outtextxy (getmaxx div 2, 5, 'Speed :            Score :               Lives left :   ');
  outtextxy (getmaxx div 2 - 150,5,Spd);
  outtextxy (getmaxx div 2 - 5,5,scorestr);
  outtextxy (getmaxx div 2 + 215,5,lives);
  SetViewPort (2,22, MaxX - 2, MaxY - 52, ClipOn);
end;

procedure position;
begin
  if pos < 20 then pos := 20;
  if pos > Bottom - 25 then pos := Bottom - 25;
  setcolor (15);
  line (5,pos-25,5,pos+25);
  line (7,pos-25,7,pos+25);
  line (9,pos-25,9,pos+25);
end;

procedure keysort;
begin
  setcolor (0);
  if upcase(key) = 'A' then inc(pix);
  if upcase(key) = 'Z' then dec(pix);
  if key = #77 then inc(diam);
  if key = #75 then dec(diam);
  if key = #72 then
  begin
     line (5,pos-25,5,pos+25);
     line (7,pos-25,7,pos+25);
     line (9,pos-25,9,pos+25);
    dec(pos,25);
    position;
  end;
  if key = #80 then
  begin
     line (5,pos-25,5,pos+25);
     line (7,pos-25,7,pos+25);
     line (9,pos-25,9,pos+25);
     inc(pos,25);
     position;
  end;
  if key = ' ' then
    if snd = 0 then snd := 120
    else snd := 0;
  if upcase(key) = 'A' then write_scores;
  if upcase(key) = 'Z' then write_scores;
  if pix < 1 then pix := 1;
  if pix > 605 then pix := 605;
  if diam < 1 then diam := 1;
  if diam > 40 then diam := 40;
end;


procedure missed_it;
begin
  sound (Snd * 4);
  delay (100);
  sound (Snd * 2);
  delay (100);
  sound (Snd);
  delay (100);
  NOSOUND;
end;

function operate:integer;
begin
  if r1 = 0 then inc (x1,pix);
  if r1 = 1 then dec (x1,pix);
  if r2 = 0 then inc (y1,pix);
  if r2 = 1 then dec (y1,pix);
  if y1 > Bottom - 35 - Diam then
  begin
    r2 := 1;
    sound (snd);
  end;
  if y1 < 0 then
  begin
    r2 := 0;
    sound (snd);
  end;
  if x1 > Right - 20 - Diam then
  begin
    r1 := 1;
    sound (snd);
  end;
  if x1 < 20 then
  begin
    r1 := 0;
    score := pix + score;
    if y1 < pos - 25 then
    begin
      missed_it;
      inc (die);
      dec(score, pix);
    end;
    if y1 > pos + 25 then
    begin
      missed_it;
      inc (die);
      dec(score, pix);
    end;
  write_scores;
  end;
end;

procedure init_vars;
begin
  randomize;
  x1 := random(425)+25;
  y1 := random(200);
  r1 := 0;
  r2 := 0;
  pix := 1;
  diam := 2;
  snd := 120;
  pos := 30;
  die := 0;
  score := 0;
  Spd := '';
  count := 0;
  clearviewport;
end;

procedure DrawBall;
begin
  SetViewPort(5, 5, 25, 25, ClipOn);
  SetFillStyle (1,Yellow);
  SetColor (Yellow);
  FillEllipse (10, 10, 5, 5);
  SetColor (15);
  Ellipse (10, 10, 10, 70, 4, 4);
  Ellipse (10, 10, 85, 90, 4, 4);
  SetColor (0);
  Ellipse (10, 10, 180, 270, 4, 4);
  Ellipse (10, 10, 170, 280, 4, 4);
  Diam := 10;
  SetViewPort(0, 0, MaxX, MaxY, ClipOn);
end;

procedure GetImages;
begin
  MaxX := GetMaxX;
  MaxY := GetMaxY;
  DrawBall;
  Size := ImageSize (0, 0, 30, 30);
  GetMem (P, Size);
  GetImage (0, 0, 30, 30, P^);
end;

procedure init;
begin
  GraphDriver := VGA;
  GraphMode:= 2;
  Initgraph (graphdriver,graphmode, 'C:\TP\BGI');
  errorcode := graphresult;
  if errorcode <> grok then
    begin
      writeln ('Graphics error : ', grapherrormsg (errorcode));
      writeln (' Program aborted...');
      halt(1);
    end;
  GetImages;
  ClearDevice;
  SetColor (Blue);
  Top := 20;
  Bottom:= GetMaxY - 30;
  Left:= 1;
  Right:= GetMaxX - 1;
  Rectangle (Left, Top, Right, Bottom);
  SetColor (Green);
  settextjustify (1, 1);
  outtextxy (getmaxx div 2, getmaxy - 20,'Escape to Quit.                Space toggles sound. ');
  outtextxy (getmaxx div 2, getmaxy - 5,'"A" speeds up, "Z" slows down.');
  write_scores;
  SetViewPort (Left+1, Top+1, Right-1, Bottom-1, ClipOn);
end;

procedure game;
var
  XPos, YPos: integer;
begin
  XPos:= 0;
  YPos:= 0;
  operate;
  write_scores;
  line (5,pos-40,5,pos+40);
  line (7,pos-40,7,pos+40);
  line (9,pos-40,9,pos+40);
  GetMem(P2, Size);
  GetImage(X1, Y1, X1 + 30, Y1 + 30, P2^);
  PutImage (x1,y1,P^,NormalPut);
  repeat
    FreeMem(P2, Size);
    GetMem(P2, Size);
    GetImage(X1, Y1, X1 + 30, Y1 + 30, P2^);
    PutImage (x1,y1,P^,NormalPut);
    nosound;
    if (Abs(XPos - X1) >= 5) or (Abs(YPos - Y1) >= 5) then
    begin
      XPos:= X1;
      YPos:= Y1;
    operate;
    if keypressed then
    begin
      key := readkey;
      keysort;
    end;
    if die = 3 then
    begin
      missed_it;
      exit;
    end;
    PutImage (XPos,YPos,P2^,NormalPut);
  until key = #27;
end;

procedure ending;
begin
  if key <> #27 then
  begin
    ClearViewPort;
    SetColor (7);
    SetTextJustify (1,1);
    outtextxy (GetMaxX div 2,55,'Game Over!');
    outtextxy (GetMaxX div 2,115,'Do you want to play again? ');
    outtextxy (GetMaxX div 2,175,'Press "Y" to play again, "N" to quit.');
    while count <> 1 do
    begin
      YesOrNo := readkey;
      Case YesOrNo of
        'Y': Count := 1;
        'y': Count := 1;
        'N':
          begin
            Key := #27;
            Count := 1;
          end;
        'n':
          begin
            Key := #27;
            Count := 1;
          end;
        #27:
        begin
          Key := #27;
          Count := 1;
        end;
      end;
    end;
  end;
end;

begin
  init;
  getdir (0,path);
  while key <> #27 do
  begin
    init_vars;
    game;
    ending;
  end;
  closegraph;
  nosound;
end.

      i
      f YesOrNo = #27 then Key := #27;
      if
      if upcase(YesOrNo) <> 'N' then
        if upcase(YesOrNo) <> 'Y' then count := 0;
      begin
        if upcase(YesOrNo) = 'N' then
          begin
            key := #27;
            count := 1;
          end;
        if upcase(YesOrNo) = 'Y' then count := 1;
      end;
    end;
  end;

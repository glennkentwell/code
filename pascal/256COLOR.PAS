program trystuff;
Uses Crt, Graph;
Var
  Gd, Gm, I, N, Col: integer;
  F: File;
  S: Word;
  Pic: Pointer;

begin
  Gd:= InstallUserDriver('VGA256', nil);
  Gm:= 0;
  InitGraph(Gd, Gm, 'C:\Shoot');
(*  SetLineStyle(0,0,3);
    For I:= 16 to 208 do
    begin
      SetColor(I);
      Circle(GetMaxX div 2, GetMaxY div 2, (I-16));
    end;
  gD:= GetMaxX;
  Gm:= GetMaxY;
  SetLineStyle(0,0,1);
  SetWriteMode(XORPut);
While not KEyPRessed do
begin
  I:= Gd div 2;
  Col:= 15;
  Repeat
    SetColor(Col);
    Line(Gd div 2, Gm div 2, I, 0);
    Dec(I);
    Inc(Col);
    if Col > 128 then Col:= 15;
  Until I = 0;
  Repeat
    SetColor(Col);
    Line(Gd div 2, Gm div 2, 0, I);
    Inc(I);
    Inc(Col);
    if Col > 128 then Col:= 15;
  Until I = Gm;
  I:= 0;
  Repeat
    SetColor(Col);
    Line(Gd div 2, Gm div 2, I, Gm);
    Inc(I);
    Inc(Col);
    if Col > 128 then Col:= 15;
  Until I = Gd;
  I:= Gm;
  Repeat
    SetColor(Col);
    Line(Gd div 2, Gm div 2, Gd, I);
    Dec(I);
    Inc(Col);
    if Col > 128 then Col:= 15;
  Until I = 0;
  I:= Gd;
  Repeat
    SetColor(Col);
    Line(Gd div 2, Gm div 2, I, 0);
    Dec(I);
    Inc(Col);
    if Col > 128 then Col:= 15;
  Until I = Gd div 2;
end;
  ReadKey;
  CloseGraph;
  Write(Gd,', ',Gm);  *)
  Assign(F, '\shoot\shoot.pic');
  S:= ImageSize(0, 0, 150, 25);
  GetMem(Pic, S);
  Reset(F, S);
  BlockRead(F, Pic^, 2);
  Close(F);
  PutImage(0, 0, Pic^, NormalPut);
end.
program GraphicsDog;
Uses Graph, Crt, GrafBits, Animals;
Var
  Objects, Jh, I, X, Y, Yo : Integer;
  F : File;
  Result : Word;
  C : char;

procedure Noise;
begin
  if (Objects > DivX - 60) then
    if (Objects < DivX) then
      if Y > Yo-20 then
      begin
        Sound(100);
        Delay(100);
        Sound(80);
        Delay(100);
        Sound(60);
        Delay(100);
      end;
  Delay(10);
  NoSound;
end;

procedure CheckJumpingKeys;
begin
  C := ReadKey;
  Case C of
  #0:
  begin
    C := ReadKey;
    Case C of
      #75: Dec(I, 3);
      #77: Inc(I, 3);
      #72: Inc(Jh);
    end;
  end;
  end;
end;

procedure Jump;
begin
  Case C of
  #77: I := 12;
  #75: I := -12;
  #72: Inc(Jh);
  end;
  PutImage(X, Y, Dog^, XORPut);
  Repeat
    Dec(Y, 16);
    PutImage(Objects, Yo, Cat^, XORPut);
    Dec(Objects, I);
    Noise;
    if X > GetMaxX then X := 0;
    if X < 0 then X := GetMaxX - 10;
    PutImage(X, Y,MoveDog^, XORput);
    PutImage(Objects, Yo, Cat^, XORPut);
    Delay(00);
    PutImage (X, Y,MoveDog^, XORput);
    if KeyPressed then CheckJumpingKeys;
  Until Y <= 400 - Jh;
  Repeat
    Inc(Y, 16);
    PutImage(Objects, Yo, Cat^, XORPut);
    Dec(Objects, I);
    Noise;
    if X > GetMaxX then X := 0;
    if X < 0 then X := GetMaxX - 10;
    PutImage(X, Y,MoveDog^, XORput);
    PutImage(Objects, Yo, Cat^, XORPut);
    Delay(00);
    PutImage (X, Y,MoveDog^, XORput);
    if KeyPressed then CheckJumpingKeys;
  Until Y = 400;
  PutImage(X, Y, Dog^, XORput);
  I := 0;
end;

procedure MoveIt(M : Integer);
Var
  K : Char;
begin
  if KeyPressed then
  begin
  K := ReadKey;
  Case K of
  #0:
  begin
    K := ReadKey;
    Case K of
    #72: Jump;
    end;
  end;
  end;
  end;
    PutImage(X, Y,Dog^, copyput);
    PutImage(Objects, Yo, Cat^, XORPut);
    Dec(Objects, M);
    Noise;
    if X > GetMaxX then X := 0;
    if X < 0 then X := GetMaxX - 10;
    PutImage(X, Y,MoveDog^,copyput);
    PutImage (X, Y,MoveDog^,copyput);
    PutImage(Objects, Yo, Cat^, XORPut);
    if X > GetMaxX then X := 0;
    if X < 0 then X := GetMaxX - 10;
    PutImage(X, Y, Dog^,copyput);
end;

procedure CheckKeys;
begin
  Jh := 160;
  C := ReadKey;
  Case C of
  #0:
  begin
    C := ReadKey;
    Case C of
    #77: MoveIt(12);
    #75: MoveIt(-12);
    #72: Jump;
    end;
  end;
end;
end;

procedure InitializeAnimals;
begin
  GraphicsScreen('C:\TP\BGI');
  DrawStillDog;
  ClearDevice;
  DrawMovingDog;
  ClearDevice;
  DrawCat;
  ClearDevice;
end;

begin
{  Assign(f, 'C:\GLENNS\TEMP\DOG.PIC');
  Erase(F);
  ReWrite (f);
  BlockWrite(f, Dog^, Size, Result);
  Close(F);
  Assign(f, 'C:\GLENNS\TEMP\MOVEDOG.PIC');
  ReWrite (f);
  BlockWrite(f, MoveDog^, Size, Result);
  Close(F);}
  InitializeAnimals;
  Y := 400;
  Yo := 410;
  X := DivX - 35;
  Objects := GetMaxX - 50;
  PutImage(Objects, Yo, Cat^, XORPut);
  PutImage(X, Y,Dog^, xorput);
  While C <> #27 do
    if KeyPressed then CheckKeys;
  CloseGraph;
  Writeln (Size);
  Writeln(S);
end.
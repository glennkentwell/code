program Sounds;
uses Crt;

procedure Electricity;
begin
    For I:= 1 to 1000 do
      Sound(I * 10);
    Delay(5);
end;

procedure
uses Crt;
const SPEAKER_PORT = $61;
       PIT_CONTROL = $43;
     PIT_CHANNEL_2 = $42;
          PIT_FREQ = $1234DD;

     DELAY_LENGTH = 100;

procedure PlaySound(sound : PChar; length : word);
var count_values : array[0..255] of byte;
    i, loop : word;
begin

  { Set up the count table }
  for i := 0 to 255 do
    count_values[i] := i * 54 div 255;

  { Set up the PIT and connect the speaker to it }
  Port[PIT_CONTROL] := $90;
  Port[SPEAKER_PORT] := Port[SPEAKER_PORT] or 3;

  { Play the sound }

  asm cli end;
  for i := 0 to length - 1 do
    begin
      Port[pit_channel_2] := byte(sound^);
      for loop := 0 to DELAY_LENGTH do;
      Port[pit_channel_2] := byte(sound^);
      for loop := 0 to DELAY_LENGTH do;
      sound := sound + 1;
    end;
  asm sti end;

  { Reprogram the speaker for normal operation }
  Port[SPEAKER_PORT] := Port[SPEAKER_PORT] and $FC;
  Port[PIT_CONTROL] := $B6;
end;

var
  X: integer;
  Letter: Pchar;
begin
  New(Letter);
  letter^:= #0;
  while letter^ <> #27 do
  begin
  Letter^:= ReadKEy;
  For X:= 1100 to 1200 do
  PlaySound(Letter, X);
end;
  Dispose(Letter);
end.
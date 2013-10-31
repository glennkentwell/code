program Whatever;
uses Graph, Crt, GrafBits;
var
  F, Dimg13, Dimg25, Dimg, Dobj,
  Mag: real;

begin
  ClrScr;
  Write('Focal length : ');
  Readln(F);
  Write('Object distance : ');
  Readln(Dobj);
  Dimg:= (1 / F) - (1 / Dobj);
  Dimg:= 1 / Dimg;
  Dimg25:= (1 / 25) - (1 / Dimg);
  Dimg25:= 1 / Dimg25;
  Dimg13:= (1 / 13) - (1 / Dimg);
  Dimg13:= 1 / Dimg13;
  Mag:= Dimg / Dobj;
  Writeln('Image is ', Dimg:6:4, 'm from the mirror,');
  Writeln('25mm image is ', Dimg25:6:4, 'm from the eyepiece,');
  Writeln('13mm image is ', Dimg13:6:4, 'm from the eyepiece,');
  Write('magnified ', Abs(Mag):6:2,' times.');
  Readkey;
end.

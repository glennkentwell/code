program ShitFace;
Uses Dos;
Var
  F: File;
  Cool: String;

begin
  Assign(F, 'COM2');
  Reset(F);
  Read(F, Cool);
  Write(Cool);
end.



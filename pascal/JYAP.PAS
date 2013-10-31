program hello;
uses crt;
const
  h='hello entery your bloddy name';
  d=' you are a dickhead';
  ag ='please put in your age in years';
  day=365;
  yiyu='thhis is how old you are in days';

var
  name:string;
  age:longint;
  days:longint;

begin
  clrscr;
  writeln(h);
  readln(name);
  writeln(ag);
  readln(age);
  days:=age*day;
  writeln(days);
  writeln(yiyu);
  writeln;
  writeln(name,d);
  readln;
end.
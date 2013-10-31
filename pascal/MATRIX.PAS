program Matrix(Input, OutPut);
const
  MaxRows = 25;
  MaxCols = 25;
type
  CoordType = array[1..MaxRows, 1..MaxCols] of integer;
  MatrixType = Record
    Coord: CoordType;
    Rows, Cols: integer;
  end;

var
  Matrix1, Matrix2, Matrix3: MatrixType;
  X, Y: integer;
  Error: Boolean;
  Data: Text;
  Filename: string;

procedure ErrorMsg(Msg: string);
begin
  Writeln;
  Write('ERROR!  It is not possible to ', Msg, ' the matrices provided.');
  Error:= True;
end;

procedure ReadMatrix(var Matrix: MatrixType);
begin
  Read(Data, Matrix.Rows);
  Read(Data, Matrix.Cols);
  For Y:= 1 to Matrix.Rows do
    For X:= 1 to Matrix.Cols do
      Read(Data, Matrix.Coord[Y, X]);
end;

procedure DisplayMatrix(Labl: string; Matrix: MatrixType);
begin
  Writeln;
  Writeln(Labl);
  For Y:= 1 to Matrix.Rows do
    begin
      For X:= 1 to Matrix.Cols do
        Write(Matrix.Coord[Y, X]:5);
      Writeln;
    end;
end;

procedure AddMatrices;
begin
  If Matrix1.Rows = Matrix2.Rows then
  begin
    If Matrix1.Cols = Matrix2.Cols then
    begin
      Matrix3.Rows:= Matrix1.Rows;
      Matrix3.Cols:= Matrix1.Cols;
      For X:= 1 to Matrix1.Cols do
        For Y:= 1 to Matrix2.Cols do
          Matrix3.Coord[X, Y]:= Matrix1.Coord[X, Y] + Matrix2.Coord[X, Y];
    end
    else ErrorMsg('add');
  end
  else ErrorMsg('add');
end;

procedure SubtractMatrices;
begin
  If Matrix1.Rows = Matrix2.Rows then
  begin
    If Matrix1.Cols = Matrix2.Cols then
    begin
      Matrix3.Rows:= Matrix1.Rows;
      Matrix3.Cols:= Matrix1.Cols;
      For X:= 1 to Matrix1.Cols do
        For Y:= 1 to Matrix2.Cols do
          Matrix3.Coord[X, Y]:= Matrix2.Coord[X, Y] - Matrix1.Coord[X, Y];
    end
    else ErrorMsg('subtract');
  end
  else ErrorMsg('subtract');
end;

procedure MultiplyMatrices;
var
 Row, Col: integer;
begin
  If Matrix1.Cols = Matrix2.Rows then
  begin
    Matrix3.Rows:= Matrix1.Rows;
    Matrix3.Cols:= Matrix2.Cols;
    For Row:= 1 to Matrix1.Rows do
      For Col:= 1 to Matrix2.Cols do
        For X:= 1 to Matrix1.Rows do
          Matrix3.Coord[Row, Col]:= Matrix3.Coord[Row, Col] + (Matrix1.Coord[Row, X] * Matrix2.Coord[X, Col]);
  end
  else ErrorMsg('multiply');
end;

procedure GetFunction;
begin
  Writeln;
  Writeln('Select a function to perform : ');
  Writeln('[ 1 ] Add Matrix 1 to Matrix 2');
  Writeln('[ 2 ] Subtract Matrix 2 from Matrix 1');
  Writeln('[ 3 ] Multiply Matrix 1 by Matrix 2');
  Write('? ');
  Readln(X);
  Case X of
    1: AddMatrices;
    2: SubtractMatrices;
    3: MultiplyMatrices;
  end;
end;

begin
  Write('Filename? ');
  Readln(Filename);
  Assign(Data, Filename);
  Reset(Data);
  ReadMatrix(Matrix1);
  ReadMatrix(Matrix2);
  DisplayMatrix('Matrix 1', Matrix1);
  DisplayMatrix('Matrix 2', Matrix2);
  GetFunction;
  if not Error then
  begin
    DisplayMatrix('Matrix 1', Matrix1);
    DisplayMatrix('Matrix 2', Matrix2);
    DisplayMatrix('Result', Matrix3);
  end;
  Close(Data);
end.

{  Read(Data, Matrix2.Rows);
  Read(Data, Matrix2.Cols);
  For Y:= 1 to Matrix2.Rows do
    For X:= 1 to Matrix2.Cols do
      Read(Data, Matrix2.Coord[Y, X]);
  Writeln;}

{  For Y:= 1 to Matrix2.Rows do
    begin
      For X:= 1 to Matrix2.Cols do
        Write(Matrix2.Coord[Y, X]:3);
      Writeln;
    end;}
(*
  Write('How many columns does Matrix 1 have? ');
  Readln(Matrix1.Cols);
  Write('How many rows does Matrix 1 have? ');
  Readln(Matrix1.Rows);
  X:= 0;
  Y:= 0;
  Repeat
    Inc(Y);
    For X:= 1 to Matrix1.Cols do
      Read(Matrix1.Coord[Y, X]);
    Writeln;
  Until Y >= Matrix1.Rows;
  Writeln;
  For Y:= 1 to Matrix1.Rows do
    begin
      For X:= 1 to Matrix1.Cols do
        Write(Matrix1.Coord[Y, X]:3);
      Writeln;
    end;
end.*)
program AddToList;
uses Crt;
type
  User = record
    Login,
    Password: string[10];
  end;

var
  Users: file of User;
  UserList: array[1..20] of User;
  Login, Password: string[10];
  NewUser: User;
  X, NumUsers: integer;

procedure GetUserList;
var
  X: integer;
begin
  Assign(Users, 'C:\USERS.TXT');
  Reset(Users);
  X:= 1;
  While not Eof(Users) do
  begin
    Read(Users, UserList[X]);
    Inc(X);
  end;
  Close(Users);
  NumUsers:= X - 1;
end;

begin
  GetUserList;
  TextColor(LightGray);
  TextBackGround(Black);
  ClrScr;
  Assign(Users, 'C:\USERS.TXT');
  Rewrite(Users);
  Writeln('Enter New User');
  Writeln;
  Write('login : ');
  Readln(Login);
  Writeln;
  Write('password : ');
  Readln(Password);
  NewUser.Login:= Login;
  NewUser.Password:= Password;
  For X:= 1 to NumUsers do
    Write(Users, UserList[X]);
  Write(Users, NewUser);
  Close(Users);
end.
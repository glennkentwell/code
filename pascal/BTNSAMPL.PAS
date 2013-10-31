program Whatever;
uses
  Crt, Graph,
  GrafBits, Buttons;

var
  Button: TButton;

begin
  GraphicsScreen;
  While Key.KeyOne <> Esc[1] do
  begin
    Button.Draw(DivX, DivY, 'Hi there, I''m a button.', ButtonOut, Space);
    Key.GetKeys;
    Button.TestForPress;
  end;
  CloseGraph;
end.
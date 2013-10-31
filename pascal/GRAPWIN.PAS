program CrapWindows;
Uses Graph, Crt, GrafBits, Mary;
type
  TButton = object
    XPos, YPos,
    Height, Width,
    CaptionX, CaptionY: integer;
    Caption: string;
    CaptionColour,
    Colour,  BackColour,
    HighLightColour, ShadowColour: Word;
    ShortCutKey: string[2];
    Enabled: Boolean;
    procedure Init(X, Y, Wid, Ht: integer;
                   Col, BkCol, HltCol, ShadCol, TxtCol: Word;
                   Capt: string;
                   Enable: Boolean);
    procedure Draw;
    procedure PressedIn;
  end;

  TWindow = object
    FrameWidth,
    XPos, YPos,
    Height, Width,
    CaptionX, CaptionY: integer;
    TitleCaption: string;
    FrameFillColour, FrameColour,
    TitleColour, TitleCaptionColour,
    Colour, TextColour: Word;
    cmdButton: TButton;
    procedure Init(X, Y, Wid, Ht: integer;
                   FrmCol, TitleCol, TitleCapCol,
                   Col, TxtCol: Word;
                   Caption: string);
    procedure Draw;
  end;

Var
  winWindow: TWindow;
  cmdButton: TButton;
  Ch: Char;

procedure TButton.Init;
var
  Ca: integer;
begin
  XPos:= X;
  YPos:= Y;
  Height:= Ht;
  Width:= Wid;
  Caption:= Capt;
  Colour:= Col;
  BackColour:= BkCol;
  HighLightColour:= HltCol;
  ShadowColour:= ShadCol;
  CaptionColour:= TxtCol;
  Enabled:= Enable;
  ShortCutKey:= #0;
  For Ca:= 1 to Length(Caption) do
  if ShortCutKey <> #0 then
    if Caption[Ca] in ['A'..'Z'] then ShortCutKey:= Caption[Ca];
end;

procedure TButton.Draw;
begin
  SetFillStyle(1, Colour);
  Bar(XPos, YPos, XPos + Width, YPos + Height);
  SetColor(Black);
  Rectangle(XPos, YPos, XPos + Width, YPos + Height);
  PutPixel(XPos, YPos, Yellow);
  PutPixel(XPos + Width, YPos, BackColour);
  PutPixel(XPos + Width, YPos + Height, BackColour);
  PutPixel(XPos, YPos + Height, BackColour);
  SetColor(HighLightColour);
  {Left Highlight Edge}
  Line(XPos + 1, YPos + 1, XPos + 1, YPos + (Height - 1));
  Line(XPos + 2, YPos + 1, XPos + 2, YPos + (Height - 2));
  {Top Highlight Edge }
  Line(XPos + 1, YPos + 1, XPos + (Width - 1), YPos + 1);
  Line(XPos + 1, YPos + 1, XPos + (Width - 2), YPos + 1);
  SetColor(ShadowColour);
  { Right hand edge shadow }
  Line(XPos + (Width - 1), YPos + (Height - 1), XPos + (Width - 1), YPos + 1);
  Line(XPos + (Width - 2), YPos + (Height - 2), XPos + (Width - 2), YPos + 2);
  { Bottom edge shadow }
  Line(XPos + (Width - 1), YPos + (Height - 1), XPos + 1, YPos + (Height - 1));
  Line(XPos + (Width - 2), YPos + (Height - 2), XPos + 2, YPos + (Height - 2)); {Top Highlight Edge }
  SetTextStyle(0, 0, 1);
  SetTextJustify(1, 1);
  SetColor(CaptionColour);
  CaptionX:= XPos + (Width div 2);
  CaptionY:= YPos + (Height div 2);
  if TextWidth(Caption) < Width - 5 then OutTextXY(CaptionX, CaptionY, Caption);
end;

procedure TButton.PressedIn;
begin
end;

procedure TWindow.Init;
begin
  XPos:= X;
  YPos:= Y;
  Height:= Ht;
  Width:= Wid;
  TitleCaption:= Caption;
  TitleColour:= TitleCol;
  TitleCaptionColour:= TitleCapCol;
  FrameColour:= FrmCol;
  Colour:= Col;
  TextColour:= TxtCol;
  CaptionX:= (Width div 2) + XPos;
  CaptionY:= YPos + 10;
end;

procedure TWindow.Draw;
begin
  SetFillStyle(1, Colour);
  Bar(XPos, YPos, XPos + Width, YPos + Height);
  SetLineStyle(0, 0, 3);
  SetColor(FrameColour);
  Rectangle(XPos, YPos, XPos + Width, YPos + Height);
  SetFillStyle(1, TitleColour);
  Bar(XPos, YPos, XPos + Width, YPos + 20);
  SetLineStyle(0, 0, 1);
  Line(XPos, YPos + 20, XPos + Width, YPos + 20);
  SetColor(TitleCaptionColour);
  SetTextStyle(0, 0, 1);
  SetTextJustify(1, 1);
  if (Width - 10) > TextWidth(TitleCaption) then
    OutTextXY(CaptionX, CaptionY, TitleCaption);
  SetViewPort(XPos + 2, YPos + 22, XPos + (Width - 2), YPos + (Height - 2), ClipOn);
  cmdButton.Init(10, 10, 300, 20, LightGray, White, White, DarkGray, Black, 'eXit Now Man', True);
  cmdButton.Draw;
end;

begin
  GraphicsScreen;
  winWindow.Init(0, 0, MaxX, MaxY,
                 Yellow, Blue, White, White, Black,
                 'The Window.');
  winWindow.Draw;
  ReadKey;
  CloseGraph;
end.

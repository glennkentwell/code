unit Cursor;
interface
  procedure BigCursor;
  procedure NormCursor;
  procedure NoCursor;

implementation
procedure BigCursor;
begin
  asm
   mov ah,$1
   mov cx,$10c
   int $10
   int 20
  end;
end;

procedure NormCursor;
begin
  asm
    mov ah,$0f
    int $10
    cmp al,$7
    mov cx,$607
    mov cx,$0b0c
    mov ah,$1
    int $10
    int 20
  end;
end;

procedure NoCursor;
begin
  asm
    mov ah,$1
    mov ch,$20
    int $10
    int 20
  end;
end;
end.

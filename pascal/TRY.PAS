program Hi;
uses Crt;


procedure Dot;
begin
  asm
    mov ah,$2
    inc dx
    inc al
    int $10
    mov ah,$a
    int $10
    dec al
 end;
end;

begin
  asm
    mov dx,$0
    mov al,$0
    mov bh,$0
    mov cx,$7d0
  end;
  While not KEyPressed do
   Dot;
end.


org 0x7c00
bits 16
start:
  jmp boot

boot:
  cli   ; no interrupts
  cld   
  hlt 

times 510 - ($-$$) db 0

dw 0xaa55 ; boot signature

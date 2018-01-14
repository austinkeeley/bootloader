; org 0x7c00
bits 16
start:
  jmp boot

boot:
  cli   ; no interrupts
  cld
  push banner
  call _print
  hlt

; Get the current cursor position
; Returns dh = row, dl = column
_get_cursor:
  xor ax, ax
  mov ah, 0x03  ; Ah=0x3 is the function code to get cursor position
  xor bh, bh    ; set page to 0
  int 0x10
  ret
  
; Prints a string. Only in green. 
; Paramters:
;  cx - Address of the string
_print:
  ;set up the frame
  push bp
  mov bp, sp
  sub sp, 4

  call _get_cursor  ; Get the cursor's current position, then add 1 to the row
  add dh, 0x1
  mov bp, ax
  xor ax, ax
  mov  es, ax
  xor bh, bh
  ;mov bp, banner
  mov bp, banner

  mov ah, 0x13   ; we want to print a string
  mov bl, 0xa
  mov al, 0x1    ; write mode
  mov cx, [banner_len]    ; message length
  int 0x10
  
  mov sp, bp
  pop bp

  ret
   



  ;mov ah, 9  ; Write instruction for int 0x10
  ;mov al, 64 ; A
  ;mov bh, 0  ; Page number
  ;mov bl, 4  ; Red on black (00000100 - High 0000 is black, low 0100 is red)
  ;mov cx, 1  ; Writes one character
  ;int 0x10


banner:
  dw "Hello, Bootloader!"
banner_len:
  dw $-banner

times 510 - ($-$$) db 0
dw 0xaa55 ; boot signature

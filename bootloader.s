; org 0x7c00
bits 16
start:
  jmp boot

boot:
  cli   ; no interrupts
  cld
  mov  ax, banner
  call _print_str

  hlt

; Get the current cursor position
; Returns dh = row, dl = column
_get_cursor:
  xor ax, ax
  mov ah, 0x03  ; Ah=0x3 is the function code to get cursor position
  xor bh, bh    ; set page to 0
  int 0x10
  ret

; Advances the cursor one space
_advance_cursor:
  call _get_cursor
  add dl, 1
  mov ah, 0x2
  int 0x10
  ret

; Prints a single character and advances the cursor
; Params
;   al - Contains the value to print
_print_char:
  mov ah, 0x0A ; function to print a character
  mov bh, 0x0  ; page 0
  mov cx, 1    ; print one time
  int 0x10     ; print the character

  call _get_cursor
  add dl, 1    ; add 1 to the column 
  mov ah, 0x2  ; function to move cursor
  int 0x10     ; move the cursor
  ret
  
  
  
; Prints a string. Only in green. 
; Paramters:
;  ax - Address of the string
_print_str:

  mov si, ax     ; set up our index
 
  _iteration: 
    mov bx, [si]
    cmp bx, 0x0  ; are we at the end?
    jz _loop_done

    mov ax, bx
    call _print_char
    add si, 1
  jmp  _iteration

  _loop_done:
  ret
  
banner:
  dw "Hello, Bootloader!", 0

times 510 - ($-$$) db 0
dw 0xaa55 ; boot signature

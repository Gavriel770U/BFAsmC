IDEAL
MODEL SMALL
STACK 100h

DATASEG
    MEMORY_SIZE equ 100
    INITIAL_MEMORY_VALUE equ 0

    file_name db 'code.bf', 0
    file_handle dw ?
    error_message db 'Error', 10, 13, '$'

    memory db MEMORY_SIZE dup(INITIAL_MEMORY_VALUE)

CODESEG

proc open_file
    ; [bp+4] offset file_name
    ; [bp+6] offset file_handle
    ; [bp+8] offset error_message

    push bp
    mov bp, sp
    push ax
    push bx
    push dx

    xor ax, ax
    xor bx, bx
    xor dx, dx

    mov ah, 3Dh
    xor al, al ; set read-only mode
    mov dx, [bp+4]
    int 21h
    jc open_error
    mov bx, [bp+6]
    mov [bx], ax

    pop dx
    pop bx
    pop ax
    pop bp
    ret 6

open_error:
    mov dx, [bp+8]
    mov ah, 9h
    int 21h

    pop dx
    pop bx
    pop ax
    pop bp
    ret 6
endp open_file

main:
    mov ax, @data
    mov ds, ax
    xor ax, ax

    push offset error_message
    push offset file_handle
    push offset file_name
    call open_file

    jmp exit

exit:
    mov ax, 4c00h
    int 21h
END main
IDEAL
MODEL SMALL

DATASEG

CODESEG
main:
    xor ax, ax
    jmp exit

exit:
    mov ax, 4c00h
    int 21h
END main    
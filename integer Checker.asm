.MODEL SMALL
.STACK 100H
.DATA
    msg1 db 'Enter a number: $'
    posMsg db 0Dh, 0Ah, 'Positive$'
    negMsg db 0Dh, 0Ah, 'Negative$'
.CODE
MAIN PROC
    ; Set up data segment
    mov ax, @data
    mov ds, ax
    ; Show input message
    mov ah, 09h
    lea dx, msg1
    int 21h
    ; Read input character
    mov ah, 01h
    int 21h
    mov bl, al         ; Store character in BL
    ; Check for minus sign
    cmp bl, '-'
    jne get_number     ; If not '-', go to get_number
    ; If minus, read the next digit
    mov ah, 01h
    int 21h
    sub al, '0'
    neg al             ; Make it negative
    jmp check_sign
get_number:
    sub bl, '0'
    mov al, bl

check_sign:
    ; Now AL contains the number (signed)
    ; Use signed conditional jump
    test al, al        ; Set flags based on AL
    js is_negative     ; Jump if sign flag is set

    ; If not negative
    mov ah, 09h
    lea dx, posMsg
    int 21h
    jmp exit

is_negative:
    mov ah, 09h
    lea dx, negMsg
    int 21h

exit:
    mov ah, 4Ch
    int 21h

MAIN ENDP
END MAIN

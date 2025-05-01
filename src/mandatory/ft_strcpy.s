        BITS 64

        global ft_strcpy

        section .text

ft_strcpy:
        mov rax,rdi
        xor rcx, rcx

.loop:

        mov r8b, [rsi + rcx] 
        mov [rdi + rcx], r8b
        cmp r8b, 0
        je .return
        inc rcx
        jmp .loop

.return:
        ret
        

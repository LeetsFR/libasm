        BITS 64

        global ft_strcmp

        section .text

ft_strcmp:
        xor rcx, rcx

.loop:
        mov al, byte[rdi + rcx]
        cmp byte[rsi + rcx], al
        jne .return
        cmp al, 0
        je .return
        inc rcx
        jmp .loop

.return:
        movzx rax, byte[rdi + rcx]
        movzx rcx, byte[rsi + rcx]
        sub rax, rcx
        ret


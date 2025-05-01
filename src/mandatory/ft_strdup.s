        BITS 64

        global ft_strdup

        extern ft_strlen
        extern ft_strcpy
        extern malloc

        section .text

ft_strdup:
        push rdi
        call ft_strlen
        mov rdi, rax
        inc rdi
        call malloc wrt ..plt
        cmp rax, 0
        je .error
        mov rdi, rax
        pop rsi
        call ft_strcpy
        ret

.error:
        ret


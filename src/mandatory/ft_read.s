        BITS 64

        global ft_read

        extern __errno_location

        section .text

ft_read:
        mov rax, 0
        syscall
        cmp rax, 0
        jl .error
        ret

.error:
        mov rdi, rax
        neg rdi
        call __errno_location wrt ..plt
        mov [rax], rdi
        mov rax, -1
        ret

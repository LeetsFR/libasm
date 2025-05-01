        BITS 64

        global ft_write

        extern __errno_location

        section .text


ft_write:
        mov rax, 1
        syscall
        cmp rax, 0
        jl .error
        ret

.error:
        mov rdi, rax
        call __errno_location wrt ..plt
        neg rdi
        mov [rax], rdi
        mov rax, -1
        ret

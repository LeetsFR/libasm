        BITS 64

        global ft_list_size

        extern malloc 

        section .bss
                struc s_list
                .data: resq 1
                .next: resq 1
                endstruc

        section .text

ft_list_size:
        xor rax, rax ; i = 0

.loop:
        cmp rdi, 0 ; if(list == NULL)
        je .return
        inc rax 
        mov rdi, [rdi + s_list.next] ; rdi = rdi->next
        jmp .loop

.return:
        ret


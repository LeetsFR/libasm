        BITS 64

        global ft_list_push_front

        extern malloc 

        section .bss
                struc t_list
                .data: resq 1
                .next: resq 1
                endstruc

        section .text

ft_list_push_front:
        ; Push parameters onto the stack
        push rbp
        mov rbp, rsp
        sub rsp, 16 ; t_list **begin 8 / void * data 16
        mov [rbp - 8], rdi 
        mov [rbp - 16], rsi

        mov rdi, t_list_size ; rdi = sizeof(t_list)
        call malloc wrt ..plt
        mov rdi, [rbp - 8]
        mov rsi, [rbp - 16]
        cmp rax, 0
        je .return
        mov rcx, [rdi] ; rcx = t_list *begin (We take the first t_list of begin)
        mov [rax + t_list.data], rsi ; rcx->data = rsi (void * data)
        mov [rax + t_list.next], rcx ; rcx->next = rcx (t_list *begin)
        mov [rdi], rax ; t_list *begin = rax

.return:
        leave
        ret



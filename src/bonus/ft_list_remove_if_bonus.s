        BITS 64

        global ft_list_remove_if

        extern free

        section .bss
                struc t_list
                .data: resq 1
                .next: resq 1
                endstruc

        section .text

ft_list_remove_if:
        cmp rdi, 0 ; if(t_begin **begin_list == NULL)
        je .error
        cmp rdx, 0 ; if(int(*cmp)() == NULL)
        je .error
        cmp rcx, 0 ; if(void (*free_fct)(void *) == NULL)
        
        ; Push parameters onto the stack
        push rbp
        mov rbp, rsp
        sub rsp, 56; t_list **begin_list 8 / void *data_ref 16 / int (*cmp)() 24 / void (*free_fct)(void *) 32
        mov [rbp - 8], rdi
        mov [rbp - 16], rsi
        mov [rbp - 24], rdx
        mov [rbp - 32], rcx

        mov rcx, [rbp - 8] ; rcx = t_list **begin_list        

.loop:
        mov rdi, [rcx] ; current = *begin_list
        cmp rdi, 0 
        je .return

        ; Save my caller-saved register
        mov [rbp - 40], rcx 
        mov [rbp - 48], rdi

        mov rdi, [rdi + t_list.data] ; rdi = rdi->data
        mov rsi, [rbp - 16] ; rsi = void *data_href
        call qword [rbp - 24] 

        ; Restore my caller-saved register
        mov rcx, [rbp - 40]
        mov rdi, [rbp - 48] ; rdi = [rcx] = *begin_list

        cmp eax, 0; if(int *(cmp)() == 0)
        je .remove

        lea rcx, [rdi + t_list.next] ; rcx = &(current->next)
        jmp .loop
        
.remove:
        mov rdx, [rdi + t_list.next]

        mov [rcx], rdx ; *begin_list->next

        ; Save my caller-saved register
        mov [rbp - 56], rcx

        mov rdi, [rdi + t_list.data]
        call qword [rbp - 32] ; free(rdi->data)

        mov rdi, [rbp - 48] 
        call free wrt ..plt ; free(rdi)
        
        ; Restore my caller-saved register
        mov rcx, [rbp - 56]

        jmp .loop

.return:
        leave

.error:
        ret

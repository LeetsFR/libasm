	BITS 64

        global ft_list_sort

        section .bss
                struc t_list
                .data: resq 1
                .next: resq 1
                endstruc

        section .text

ft_list_sort:
        cmp rdi, 0 ; if(t_list **begin_list == NULL)
        je .error
        cmp rsi, 0 ; if(int (*cmp)() == NULL)
        je .error
        mov rax, [rdi] ; if(t_list *begin_list == NULL)
        cmp rax, 0
        je .error

        ; Push parameters onto the stack
        push rbp
        mov rbp, rsp
        sub rsp, 56 ; t_list **begin_list 8 / int(*cmp)() 16
        mov [rbp - 8], rdi
        mov [rbp - 16], rsi
        mov rcx, 1 ; bool swap = true

; Check if a swap has taken place, if yes we loop back, if not we stop
.update:
        cmp rcx, 0 ; if(swap == false)
        je .return
        xor rcx, rcx ; swap = false
        mov rdx, [rbp - 8] 
        mov rdx, [rdx] ; rdx = *begin_list

.loop:
        mov rdi, [rdx + t_list.data] 
        mov rsi, [rdx + t_list.next] 
        cmp rsi, 0 
        je .update
        mov rsi, [rsi + t_list.data] 
        ; Save my caller-saved register
        mov [rbp - 24], rdx 
        mov [rbp - 32], rcx
        mov [rbp - 40], rdi
        mov [rbp - 48], rsi

        call qword [rbp - 16] ; call int(*cmp)(rdi, rsi)

        ; Restore my caller-saved register
        mov rdx, [rbp - 24] 
        mov rcx, [rbp - 32]
        mov rdi, [rbp - 40]
        mov rsi, [rbp - 48]

        cmp eax, 0 ; if(strcmp(rdi, rsi) > 0)
        jg .swap
        mov rdx, [rdx + t_list.next] ; rdx = rdx->next
        jmp .loop

.swap:
        mov [rdx + t_list.data], rsi ; current->data = rdi
        mov rdx, [rdx + t_list.next] ; current = current->next
        mov [rdx + t_list.data], rdi ; current->data = rsi
        inc rcx ; bool swap = true
        jmp .loop

.return:
        leave
	ret

.error:
	ret

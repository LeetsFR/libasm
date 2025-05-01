        BITS 64

        global ft_atoi_base

        extern ft_strlen

        section .text

in_base:
        xor rcx, rcx

.loop:
        mov dl, [rsi + rcx]
        cmp dl, 0
        je .error
        cmp dl, dil
        je .equal
        inc rcx
        jmp .loop

.error:
        mov rax, -1
        ret

.equal:
        mov rax, rcx
        ret


check_base:
        call ft_strlen 
        cmp rax, 1
        je .error
        xor rcx, rcx 
.loop:
        mov dl, [rdi + rcx]
        cmp dl, 0
        je .return
        cmp dl, '+'
        je .error
        cmp dl, '-'
        je .error
        cmp dl, ' '
        je .error
        cmp dl, 9
        je .error
        cmp dl, 10
        je .error
        cmp dl, 11
        je .error
        cmp dl, 12
        je .error
        cmp dl, 13
        je .error
        inc rcx
        mov r8, rcx
.loop_double:
        mov r9b, [rdi + r8]
        cmp r9b, 0
        je .loop
        cmp r9b, dl
        je .error
        inc r8
        jmp .loop_double

.error:
        xor rax, rax
        ret

.return:
        mov rax, 1
        ret

ft_atoi_base:
        push rdi
        mov rdi, rsi
        call check_base
        pop rdi
        cmp rax, 0
        je .error
        xor rcx, rcx ; size_t i = 0

.loop_whitespace:
        mov dl, [rdi + rcx]
        cmp dl, 0
        je .error
        cmp dl, ' '
        je .whitespace
        cmp dl, 9
        je .whitespace
        cmp dl, 10
        je .whitespace
        cmp dl, 11
        je .whitespace
        cmp dl, 12
        je .whitespace
        cmp dl, 13
        je .whitespace
        mov r15, 1 ; sign = 1
        jmp .loop_sign

.whitespace:
        inc rcx
        jmp .loop_whitespace

.loop_sign:
        mov dl, [rdi + rcx]
        cmp dl, 0
        je .error
        cmp dl, '+'
        je .pos_sign
        cmp dl, '-'
        je .neg_sign
        jmp .convert

.pos_sign:
        inc rcx
        jmp .loop_sign
.neg_sign:
        neg r15
        inc rcx
        jmp .loop_sign


.convert:
        push rdi
        mov rdi, rsi
        call ft_strlen
        mov r14, rax ; size_t lenght = ft_strlen(base);
        pop rdi
        xor rax, rax ; size_t resutl = 0

.loop_convert:
        mov dl, [rdi + rcx]
        cmp dl, 0
        je .return
        push rax
        push rcx
        push rdi
        mov dil, dl
        call in_base
        mov r13, rax ; add
        pop rdi
        pop rcx
        pop rax
        cmp r13, -1
        je .error
        mul r14
        add rax, r13
        inc rcx
        jmp .loop_convert


.error:
        xor rax, rax
        ret

.return:
        mul r15
        ret



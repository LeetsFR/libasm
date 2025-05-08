        BITS 64

        global ft_atoi_base

        extern ft_strlen

        section .text


ft_atoi_base:
        ; Push parameters onto the stack
        push rbp
        mov rbp, rsp
        sub rsp, 40 ; char *str 8 / char * base 16 / int sign 24 / size_t length 32
        mov [rbp - 8], rdi
        mov [rbp - 16], rsi
        mov dword [rbp - 24], 1 ; sign = 1
        xor rax, rax

        ; Get the base size
        mov rdi, [rbp - 16] ; rdi = base
        call ft_strlen
        cmp rax, 1 ; if(ft_strlen(base) < 1)
        jbe .error
        mov [rbp - 32], rax

        ; Check if this is a valid base
        mov rdi, [rbp - 16] ; rdi  = base
        call valid_base
        cmp rax, 0
        je .error

        mov rdi, [rbp - 8] ; rdi = str
        xor rcx, rcx ; i = 0

; Loop while is whitespace
.loop_whitespace:
        mov dl, byte[rdi + rcx]
        cmp dl, 0
        je .error
        
        cmp dl, ' '
        je .inc_whitespace
        cmp dl, 9
        jb .loop_sign
        cmp dl, 13
        ja .loop_sign

.inc_whitespace:
        inc rcx ; i++
        jmp .loop_whitespace

; Loop while '-' | '+' and change sign if '-'
.loop_sign:
        mov dl, byte[rdi + rcx]
        cmp dl, 0
        je .error
        cmp dl, '-'
        je .neg
        cmp dl, '+'
        je .pos
        jmp .convert

.neg:
        neg dword [rbp - 24] ; sign *= -1
        inc rcx
        jmp .loop_sign

.pos:
        inc rcx
        jmp .loop_sign

; We convert the string to INT with the specified base
.convert:
        xor rax, rax ; result = 0
        mov rsi, [rbp - 16] ; rsi = base

.loop_convert:
        mov dl, byte[rdi + rcx] ;dl = str[i]
        cmp dl, 0
        je .return

        xor r8, r8 ; j = 0
.loop_in_base:
        mov r9b, byte[rsi + r8] ; r9b = base[j]
        cmp r9b, 0 
        je .return
        cmp r9b, dl ; str[i] == base[j]
        je .next
        inc r8 ; j++
        jmp .loop_in_base

.next:
        mul qword [rbp - 32] ; result *= base
        add rax, r8 ; result += r8
        inc rcx ; i++
        jmp .loop_convert

; Returns 0 if we encounter an error else we return (result * sign) 
.error:
        xor rax, rax

.return:
        mul dword [rbp - 24]
        leave
        ret


valid_base:
        xor rcx, rcx ; i = 0

; Check if str[i] == '+' | '-' | white space
.loop:
        mov dl, byte[rdi + rcx]
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
        inc rcx ; i++
        mov r8, rcx ; j = i

; Check if we have a duplicate
.double:
        mov sil, byte[rdi + r8]
        cmp sil, 0
        je .loop
        cmp sil, dl ; if(str[i] == str[j])
        je .error
        inc r8 
        jmp .double

; Returns 0 if we encounter an error and 1 if it is a valid base
.error: 
        xor rax, rax
        ret

.return:
        mov rax, 1
        ret





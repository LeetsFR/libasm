        BITS 64

        global ft_list_push_front

        section .bss
                struc s_list
                data: resq 1
                next: resq 1
                endstruc

        section .text

ft_list_push_front:


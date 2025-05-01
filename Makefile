NAME := libasm.a
FILE := ft_strlen ft_strcpy ft_strcmp ft_write ft_read ft_strdup
DIR  := obj/mandatory/
SRC  := src/mandatory/
OBJ  := $(addprefix $(DIR), $(addsuffix .o, $(FILE)))

FILE-B := ft_atoi_base_bonus
DIR-B  := obj/bonus/
SRC-B  := src/bonus/
OBJ-B  := $(addprefix $(DIR-B), $(addsuffix .o, $(FILE-B)))

all: $(NAME)

$(NAME): $(OBJ)
	ar rcs $@ $(OBJ)

$(DIR)%.o: $(SRC)%.s | $(DIR)
	nasm -f elf64 $< -o $@

$(DIR):
	mkdir -p $@

bonus: $(OBJ) $(OBJ-B)
	ar rcs $(NAME) $(OBJ) $(OBJ-B)

$(DIR-B)%.o: $(SRC-B)%.s | $(DIR-B)
	nasm -f elf64 $< -o $@

$(DIR-B):
		mkdir -p $@

test: all
	gcc -c src/mandatory/main.c -o obj/mandatory/main.o
	gcc obj/mandatory/main.o -L. -lasm -o test

test_bonus: bonus
	gcc -c src/bonus/main_bonus.c -o obj/bonus/main_bonus.o
	gcc obj/bonus/main_bonus.o -L. -lasm -o test_bonus

clean:
	rm -rf obj/
	rm -f test test_bonus

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: all test bonus test_bonus clean fclean re

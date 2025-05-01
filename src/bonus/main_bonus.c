#include <stdio.h>

typedef struct s_list {
    void *data;
    struct s_list *next;
} t_list;

int ft_atoi_base(char *str, char *base);
int main(int argc, char *argv[]) {

    printf("atoi = %d\n", ft_atoi_base("FF", "0123456789ABCDEFF"));
    return 0;
}

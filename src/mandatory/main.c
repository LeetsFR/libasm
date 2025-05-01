#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

size_t ft_strlen(const char *);
char *ft_strcpy(char *, const char *);
int ft_strcmp(const char *, const char *);
ssize_t ft_write(int, const void *, size_t);
ssize_t ft_read(int, void *, size_t);
char *ft_strdup(const char *);

int main(int argc, char *argv[]) {
    if (argc == 2) {
        char buffer[4];
        ft_strcpy(buffer, argv[1]);
        printf("ft_strlen: %ld\n", ft_strlen("Welcome in 42 School"));
        printf("%s\n", buffer);
        argv[1][1] = '2';
        printf("diff = %d\n", ft_strcmp(argv[1], buffer));
        ft_write(1, buffer, sizeof(buffer));
        printf("errno = %d\n", ECHILD);
        char *str = ft_strdup(buffer);
        printf("str = %s\n", str);
        free(str);
        write(1, NULL, 1);
        printf("errno = %d", errno);
    }

    return 0;
}

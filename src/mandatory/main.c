#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

size_t ft_strlen(const char *);
char *ft_strcpy(char *, const char *);
int ft_strcmp(const char *, const char *);
ssize_t ft_write(int, const void *, size_t);
ssize_t ft_read(int, void *, size_t);
char *ft_strdup(const char *);

int main(int argc, char *argv[]) {
    if (argc == 2) {
        char buffer[ft_strlen(argv[1])];
        printf("ft_strlen: %ld\n", ft_strlen(argv[1]));
        printf("ft_strcpy: %s\n", ft_strcpy(buffer, argv[1]));
        buffer[2] = 'L';
        printf("ft_strcmp: %d\n", ft_strcmp(buffer, argv[1]));
        printf("ft_strdup: %s\n", ft_strdup(argv[1]));
        printf("\nft_write: %ld\n", ft_write(1, argv[1], ft_strlen(argv[1])));
        {
            char buffer[10];
            ft_read(0, buffer, 10);
            ft_write(1, buffer, 10);
        }
    }

    return 0;
}

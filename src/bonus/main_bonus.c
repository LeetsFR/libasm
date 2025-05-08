#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct s_list {
    void *data;
    struct s_list *next;
} t_list;

int ft_atoi_base(char *str, char *base);
void ft_list_push_front(t_list **begin_list, void *data);
int ft_list_size(t_list *begin_list);
void ft_list_sort(t_list **begin_list, int (*cmp)(void *, void *));
void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(void *, void *), void (*free_fct)(void *));

void print_list(t_list *list) {
    if (!list) {
        printf("Liste vide\n");
        return;
    }

    while (list) {
        printf("%d", *(int *)list->data);
        list = list->next;
        if (list)
            printf(" -> ");
    }
    printf("\n");
}

int cmp_int(void *a, void *b) { return (*(int *)a - *(int *)b); }

void free_int(void *data) { free(data); }

int main() {
    {
        printf("\n----- Test ft_atoi_base -----\n");
        printf("123 en base décimale : %d\n", ft_atoi_base("123", "0123456789"));
        printf("1010 en base binaire : %d\n", ft_atoi_base("1010", "01"));
        printf("FF en base hexadécimale : %d\n", ft_atoi_base("FF", "0123456789ABCDEF"));
        printf("-42 en base décimale : %d\n", ft_atoi_base("-42", "0123456789"));
    }

    {
        printf("\n----- Test ft_list_push_front -----\n");
        t_list *list = NULL;

        printf("Liste initiale : ");
        print_list(list);

        for (int i = 1; i <= 5; i++) {
            int *num = malloc(sizeof(int));
            *num = i;
            ft_list_push_front(&list, num);

            printf("Après ajout de %d : ", i);
            print_list(list);
        }

        while (list) {
            t_list *temp = list;
            list = list->next;
            free(temp->data);
            free(temp);
        }
    }

    {
        printf("\n----- Test ft_list_size -----\n");
        t_list *list = NULL;

        printf("Taille liste vide : %d\n", ft_list_size(list));

        for (int i = 1; i <= 5; i++) {
            int *num = malloc(sizeof(int));
            *num = i;
            ft_list_push_front(&list, num);

            printf("Taille après ajout %d : %d\n", i, ft_list_size(list));
        }

        while (list) {
            t_list *temp = list;
            list = list->next;
            free(temp->data);
            free(temp);
        }
    }

    {
        printf("\n----- Test ft_list_sort -----\n");
        t_list *list = NULL;

        int values[] = {42, 3, 17, 8, 21};
        for (int i = 0; i < 5; i++) {
            int *num = malloc(sizeof(int));
            *num = values[i];
            ft_list_push_front(&list, num);
        }

        printf("Liste avant tri : ");
        print_list(list);

        ft_list_sort(&list, cmp_int);

        printf("Liste après tri : ");
        print_list(list);

        while (list) {
            t_list *temp = list;
            list = list->next;
            free(temp->data);
            free(temp);
        }
    }

    {
        printf("\n----- Test ft_list_remove_if -----\n");
        t_list *list = NULL;

        int values[] = {42, 3, 42, 17, 42, 8};
        for (int i = 5; i >= 0; i--) {
            int *num = malloc(sizeof(int));
            *num = values[i];
            ft_list_push_front(&list, num);
        }

        printf("Liste initiale : ");
        print_list(list);

        int to_remove = 42;
        ft_list_remove_if(&list, &to_remove, cmp_int, free_int);

        printf("Liste après suppression des 42 : ");
        print_list(list);

        while (list) {
            t_list *temp = list;
            list = list->next;
            free(temp->data);
            free(temp);
        }
    }

    return 0;
}

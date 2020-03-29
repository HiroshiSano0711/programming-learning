#include <stdio.h>

int main(){
    char *local_string = "local";
    char local_str[100];
    int local_int = 9;
    int *local_pint;
    long int local_longint = 9;
    unsigned long int local_unsignedlongint = 9;
    printf("%lu\n", sizeof local_int);
    printf("local_pint = %lu\n", sizeof local_pint);
    printf("local_string= %lu\n", sizeof local_string);
    printf("local_str = %lu\n", sizeof local_str);
    printf("%lu\n", sizeof local_longint);
    printf("%lu\n", sizeof local_unsignedlongint);
}

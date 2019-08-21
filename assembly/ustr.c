#include <stdio.h>
#include <ctype.h>

char *toustr(char *str) {
    int c;

    while ((c = *str) != 0){
        if (islower(c)){
            *str = (char)toupper(c);
            str++;
        }
    }

    return str;
}

int main() {
    char a[] = "Hello Good Night";
    printf("s=%s\n", toustr(a));
    return 0;
}

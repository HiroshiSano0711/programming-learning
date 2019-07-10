#include <stdio.h>

int func(int a);

int main(int argc, char const *argv[])
{
    int (*func_p)(int);

    func_p = func;
    printf("main %p", &func);
    printf("main %p", func_p);
    return 0;
}

int func(int a){
    printf("func %p", &a);
    return a;
}

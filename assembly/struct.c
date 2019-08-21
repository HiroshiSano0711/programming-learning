#include <stdio.h>

struct _PERSON {
    int age;
    char name[12];
};
typedef struct _PERSON Person;

int main(void){
    Person member[5] = { {1, "ken"}, {2, "ryu"}, {3, "gairu"} };
    int i;

    for (i = 0; i < 3; i++){
        printf("member[i].name= %s", member[i].name);
        printf("member[i].age= %d", member[i].age);
    }

    return 0;
}

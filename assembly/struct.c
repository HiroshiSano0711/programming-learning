#include <stdio.h>

struct _PERSON {
    int id;
    int age;
};
typedef struct _PERSON Person;

int main(void){
    Person member[5] = { {1, 100}, {2, 101}, {3, 102} };
    int i;

    for (i = 0; i < 3; i++){
        member[i].id = 10;
        member[i].age = 1000;
    }

    return 0;
}

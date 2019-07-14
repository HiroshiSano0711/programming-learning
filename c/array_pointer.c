#include <stdio.h>

void func(int *array, int size){
    int i;
    for (i = 0; i < size; i++){
        printf("array[%d]..%d", i, array[i]);
    }
    
}

int main(int argc, char const *argv[]){
    int array[] = {1, 2, 3, 4, 5};
    func(array, sizeof(array) / sizeof(int));
    return 0;
}

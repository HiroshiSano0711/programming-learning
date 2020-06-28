#include <stdio.h>

void bubble_sort(int array[], int length){
  int start, end, last_changed, tmp;
  last_changed = 0;
  end = length - 2;

  while(end > 0) {
    for (start = 0; start <= end; start++){
      if(array[start] < array[start + 1]){
        tmp = array[start];
        array[start] = array[start + 1];
        array[start + 1] = tmp;
        last_changed = start;
      }
    }
    end = last_changed;
    last_changed = 0;
  }

  for(start = 0; start < length; start++){
    printf("%d\n", array[start]);
  }
}

int main(){
  int a[] = { 109, 75, 200, 15, 38, 19, 150, 11, 20 };
  bubble_sort(a, 9);

  return 0;
}

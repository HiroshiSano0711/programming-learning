#include <stdio.h>
#include <math.h>

char buff[100];
int number; // 数
int max; // 最大の割る数
int r; // 余り

int main(){
    printf("素数判定。1以上の数字を入力してね。\n");
    fgets(buff, sizeof(buff), stdin);
    sscanf(buff, "%d", &number);

    if (number == 1 || number == 2 || number == 3){
        printf("素数です\n");
        return 0;
    }

    max = (int)floor(sqrt(number));

    // for(i = 2; i < max; i++) {
        // 同じ
    //}
    while (max > 1){
        r = number % max;
        if (r == 0)
            break;
        max--;
    }

    if (r == 0){
        printf("素数ではない\n");
    }else{
        printf("素数\n");
    }
    return 0;
}

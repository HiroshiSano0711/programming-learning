#include <stdio.h>

int print_number(int n, int r)
{
    // n段目はn個の要素をもつ。
    // n段目のr個目の要素はn個を超えたら終了
    if (r < 0 || r > n)
        return 0;
    else if(n == 0) // 端っこの処理。端っこも全段の2つの要素を足したものとみなす。1 + 0
        return 1;
    else {
        // n段目のrは、n-1段目のr-1番目の要素、n-1段目のr番目の要素を足した値になる。
        return print_number(n - 1, r - 1) + print_number(n - 1, r);
    }
}

void print_pascal(int d)
{
    // i 三角形のi段目
    // j 三角形のi段目のj番目の要素
    int i,j;

    for (i = 0; i < d; i++)
    {
        for (j = 0; j <= i; j++)
        {
            printf("%d", print_number(i, j));
        }
        printf("\n");
    }
}

int main()
{
    print_pascal(5);
    return 0;
}

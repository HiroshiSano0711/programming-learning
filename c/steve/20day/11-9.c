#include <stdio.h>
#define X_SIZE 40
#define Y_SIZE 60

char graphics[X_SIZE / 8][Y_SIZE];

#define SET_BIT(x, y) graphics[(x) / 8][y] |= (0x80 >> ((x) % 8))
#define CLEAR_BIT(x, y) graphics[(x) / 8][y] &= ~(0x80 >> ((x) % 8))
#define TEST_BIT(x, y) (graphics[(x) / 8][y] & (0x80 >> ((x) % 8))) > 0 ? 1 : 0

int main()
{
    // int loc;
    void print_graphics(void);
    int x, y;
    for (x = 0; x < X_SIZE; ++x)
        for (y  = 0; y < Y_SIZE; ++y)
            if ((x + y) % 2 == 0)
                SET_BIT(x, y);
            if ((x + y) % 2 != 0)
                CLEAR_BIT(x, y);
    print_graphics();
    return 0;
}

/*
課題を自分で設定する。
1. 動かす
2. Xを作ってみる
3. Xの一本を取る(clear_bit)
4. Xを引いて中央を出してみる(test_bit)
5. 市松模様を書いてみる
*/

void print_graphics()
{
    int x;
    int y;
    unsigned int bit;

    for (y = 0; y < Y_SIZE; ++y)
    {
        for (x = 0; x < X_SIZE / 8; ++x)
        {
            for (bit = 0x80; bit > 0; bit = (bit >> 1))
            {
                if ((graphics[x][y] & bit) != 0)
                    printf("X");
                else
                    printf(".");
            }
        }
        printf("\n");
    }
}

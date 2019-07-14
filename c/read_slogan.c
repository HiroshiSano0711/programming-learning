#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void read_slogan(FILE *fp, char **slogan){
    char buf[1024];
    int i;
    
    for (i = 0; i < 7; i++){
        fgets(buf, 1024, fp);

        // 改行文字を削除する
        buf[strlen(buf) - 1] = '\0';

        // 標語一つ分の領域を確保
        slogan[i] = malloc(sizeof(char) * (strlen(buf) + 1));

        // 標語の内容をコピー
        strcpy(slogan[i], buf);
    }
}

int main(void) {
    char *slogan[7];
    int i;

    read_slogan(stdin, slogan);

    for (i = 0; i < 7; i++){
        printf("%s\n", slogan[i]);
    }
    
    return 0;
}


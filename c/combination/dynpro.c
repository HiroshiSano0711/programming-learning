#include <stdio.h>
#include <stdlib.h>

typedef int *pint;
int n, *d, *getints();
pint *p;

int *getints(int n);
int *solution(int s);

int main(){
    int s, i, j, m, *row, *solution();

    printf("Enter the desired sum: ");
    scanf("%d", &s);
    printf("Enter n, followed by the n given  ");
    printf("intergers themselves:\n");
    scanf("%d", &n);

    d = getints(n);
    p = (pint *)malloc((s + 1)*sizeof(pint));

    if(p == NULL){
        printf("Not enough memory\n");
        exit(1);
    }

    for(i = 0; i < n; i++)
        scanf("%d", d + i);
    row = solution(s); // p[s]が返ってくる。NULLの場合は解なし。

    if(row == NULL)
        printf("\nNo solution");
    else {
        printf("\nSolution:\n\n  %d = ", s);
        m = row[0]; // p[s][0]は使ったコインの枚数

        // p[s][1]以降の経路の値を表示する。
        for(j = 1; j <= m; j++)
            printf("%d %s", row[j], j < m ? "+ " : "\n");
    }
  return 0;
}

int *getints(int n){
    int *q;
    q = (int *)malloc(n * sizeof(int));
    if(q == NULL){
        printf("Not enough memory\n"); exit(1);
    }
  return q;
}

#define BIG 30000

int *solution(int s){
    /*
     *  x:       現在両替しようとしている和（金額）
     *  u:       以前に計算したキャッシュのインデックス
     *  i:       コインの数だけループする変数
     *  j:       経路を保存するためのループで使う。使ったコインの枚数分だけ回すループ変数。
     *  min:     両替で使った最小のコイン数
     *  imin:    minの場合に使ったコインのインデックス
     *  *destin: どのコインを使ったか経路を保存する 例：6 + 6 + 6
     *  *source: 各経路で使ったコインの金額
     *  aux:     最小の場合に使ったキャッシュのインデックスを一時的に保存する。解で採用したu。
     */
    int x, u, i, j, min, imin, *destin, *source, aux;
    p[0] = getints(1); p[0][0] = 0;

    // ボトムからキャッシュしていくためにx=1からs(=42)まで順番に両替していく。
    for(x = 1; x <= s; x++){
        /*
         * BIGは解で出なさそうな大きな数にしておいて解があったら比較して最小なら上書きしていく。
         * -1とかnullだと「解なし」とか「まだ計算していない数」とかと見分けがつきづらいので大きな数を設定。
         * 単純に数の比較をすれば良くなるので、p[u][0] != -1 とかのチェックが毎回不要になる。
         */
        min = BIG;

        // コインの種類数だけ両替を繰り返す。
        for(i = 0; i < n; i++){
            // 使うコインの金額は引いていきすでにボトムで求めた解がないか探せるようにする。
            u = x - d[i];

            /*
             * u >= 0        → コインの金額を引いて差分がマイナスの場合はそのコインでは両替できない = 解がない
             * p[u] != NULL  → すでにボトムで求めた解があるかどうか。解なしはNULL。
             * p[u][0] < min → 求めていた解より今回の解の方が小さいかどうか。最小を求めたいため。
             */
            if(u >= 0 && p[u] != NULL && p[u][0] < min){
                // minにキャッシュしてあった最小の解（枚数）を入れる。後で使う。
                min = p[u][0];
                // imin = i; → 最小の場合に使ったコインの種類のインデックスを保存する。後で経路の保存で使う。
                imin = i;
            }
        }
        /*
         * BIGの値が初期値でminに入っているので、解があった場合は↑の
         * min = p[u][0];
         * の処理でBIGより小さい数が代入されているはず。
         */
        if(min < BIG){
            // 経路とキャッシュに解を保存するためにintの分だけメモリを確保する。
            // コイン数分、金額の経路がキャッシュp[x]に二次元配列で保存されている。
            // p[x][0]には枚数を保存していて、p[x][1]以降には経路の値がコインの金額で保存されている。
            // p[x][0]が1なら経路の値は1つだけなので（コインを1枚使ったので）p[x][1]にのみ値が入る。
            // p[x][0]が2なら経路の値が2つあるので（コインを2枚使ったので）p[x][1]とp[x][2]に値が入る。
            // そのため、minの分と自身を保存する分を確保する。
            // min(前のノードの経路の値をコピーする分) + 1(前のノードの枚数を保存する分) + 1（自身が使ったコインの枚数を保存する分）= min + 2
            p[x] = destin = getints(min + 2);
            aux = x - d[imin];         // 最小の解のコインの金額を引いた差分。
            source = p[aux];           // 自身を除くの最小の解（コイン数）。
            destin[0] = min + 1;       // 最小の解に自身のコインを1枚使ったので+1している。
            for(j = 1; j <= min; j++)  // 経路の保存（更新）。
                destin[j] = source[j]; // 経路で使ったコインの金額をコピーしてくる。
            destin[min + 1] = d[imin]; // 最小の経路に自身のコインを追加して経路を更新する。
        }else{
            p[x] = NULL; // 解がなかった場合はキャッシュにNULLをいれる。
        }
    }
    return p[s]; // 最終的にほしい最小の解はキャッシュの一番上にあるはずなのでそれを返す。
}

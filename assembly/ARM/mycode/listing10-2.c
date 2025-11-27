// Listing 10-2: GenerateSines
//
// sine関数の値のテーブルを生成するA C program
//
// 処理の流れ：
// sines.inc というファイルを作る
// ラベル名 Sines: を出力
// angle = 0..359 をループ
// 各角度について
//  sin() を計算
//  * 1000.0
//  整数に丸める
// .hword 形式でアセンブリ用のテーブルを書き出す

#include <stdlib.h>
#include <stdio.h>
#include <math.h>

int main(int argc, char **argv)
{
    FILE *outFile;
    int angle;
    int r;

    outFile = fopen("sines.inc", "w");

    fprintf
    (
        outFile,
        "Sines:"  // sin(0) = 0
    );


    for(angle = 0; angle <= 359; ++angle)
    {
        // 入力値はラジアンなので
        //  sin( angle × 2π / 360 )
        // で変換してる
        // 変換公式
        //  rad = deg × π / 180
        // rad = deg × 2π / 360
        // と同じ

        double theSine =
            sin
            (
                angle * 2.0 *
                3.14159265358979323846 /
                360.0
            );
        r = (int) (theSine * 1000.0);

        if((angle & 7) == 0)
        {
            fprintf(outFile, "\n\t.hword\t");
        }
        fprintf(outFile, "%5d", r);
        if ((angle & 7) != 7)
        {
            fprintf(outFile, ",");
        }

    } //endfor
    fprintf(outFile, "\n");

    fclose(outFile);
    return 0;

} // end main

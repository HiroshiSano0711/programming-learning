#include <stdio.h>

double power4(double x, int n);

int main(){
  double r = power4(2, 100);
  printf("%f", r);
  return 0;
}

double power4(double x, int n){
  // 例外パターン。a,b,cの式に該当するか？
  if(n < 2){
    //  　   b(n = 0)      c（n = 1）        a（負の指数）
    return (n == 0 ? 1.0 : n == 1 ? x : 1.0 / power4(x, -n));
  }else{
    // d,eの式に該当
    // ２乗で括っている。２乗ずつ順番に計算している
    double y = power4(x, (n >> 1)); // dの式
    // ２乗で括ったときの一番外側の２乗の計算
    y = y * y;
    //    e(nが奇数か？)
    return n & 1 ? y * x : y;
  }
}

double power1(double x, int n){
  return n > 0 ? x * power1(x, n - 1) : n < 0 ? 1.0 / power1(x, n - 1) : 1.0;

  // power(0) = 1.0
  // power(1) = x * power(0)
  // power(2) = x * power(1)
  // power(3) = x * power(2)
  // power(4) = x * power(3)
  // power(5) = x * power(4)
  // ↓
  // power(1) = x * (1.0)
  // power(2) = x * (x * 1.0)
  // power(3) = x * (x * (x * 1.0))
  // power(4) = x * (x * (x * (x * 1.0)))
  // power(5) = x * (x * (x * (x * (x * 1.0))))

  // nは指数、xはかけられる数
  if (n > 0){ // nが0より大きい場合
    return x * power1(x, n - 1); 
  } else {
    if (n < 0){
      return 1.0 / power1(x, -n);
    } 
    return 1.0;
  }
}

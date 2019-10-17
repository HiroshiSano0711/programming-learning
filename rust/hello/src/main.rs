// トレイトをスコープに取り込む。型が実装できるメソッドの集合。
use std::io::Write;
use std::str::FromStr;

fn main() {
    let mut numbers = Vec::new(); // 可変なローカル変数の宣言
    for arg in std::env::args().skip(1) {
        numbers.push(u64::from_str(&arg).expect("error parsing argument"));
    }

    if numbers.len() == 0 {
        writeln!(std::io::stderr(), "Usage: gcd NUMBER...").unwrap();
        std::process::exit(1);
    }

    let mut d = numbers[0];
    for m in &numbers[1..] {
        d = gcd(d, *m);
    }
    println!("The greatest common divisor of {:?} id {}", numbers, d);
}

fn gcd(mut n: u64, mut m: u64) -> u64 {
    assert!(n != 0 && m != 0);
    let mut r;
    while m != 0 {
        r = n % m;
        n = m;
        m = r;
    }
    n
}

#[test]
fn test_gcd(){
    assert_eq!(gcd(14, 15), 1);
    assert_eq!(gcd(2 * 4 * 5 * 11 * 17, 3 * 7 * 11 * 13 * 19), 11);
}

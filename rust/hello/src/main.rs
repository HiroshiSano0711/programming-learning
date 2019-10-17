fn main() {
    let a = gcd(1000, 100);
    println!("{}", a);
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

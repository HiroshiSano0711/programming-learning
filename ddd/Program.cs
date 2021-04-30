using System;

namespace _01
{
    class Program1
    {
        static void Main(string[] args)
        {
            var fullName = "yamada taro"; // プリミティブ値である文字列で氏名を表現する
            Console.WriteLine(fullName); // yamada taro が表示される
        }
    }

    class Program2
    {
        static void Main(string[] args)
        {
            var fullName = "yamada taro";
            // ["yamada", "taro"] という配列になり、姓と名で分けられる
            var tokens = fullName.Split(' ');
            var lastName = tokens[0];
            Console.WriteLine(lastName); // yamada が表示される
        }
    }

    /*
        氏名を値オブジェクトで表現する。
        データを文字列ではなく抽象化して扱えるようになるとも言えそう。
        ↓のような感じで、抽象化した概念を1つの値として扱えるようになる。
        var fullName = new FullName("yamada", "taro");
        Console.WriteLine(fullName.LastName);
    */
    class FullName1
    {
        public FullName(string firstName, string lastName)
        {
            FirstName = firstName;
            LastName = lastName;
        }

        public string FirstName { get; }
        public string LastName { get; }
    }

    /*
        ChangeLastNameは値を変更している。
        値オブジェクトはシステム固有の値を表しているので、不変にすべき。
        ChangeLastNameメソッドはこのクラスに定義されるべきではないと考える。
    */
    class FullName2
    {
        public FullName(string firstName, string lastName)
        {
            FirstName = firstName;
            LastName = lastName;
        }

        public string FirstName { get; }
        public string LastName { get; private set; }

        public void ChangeLastName(string name)
        {
            LastName = name;
        }
    }

    /*
        比較するメソッドを実装している。
        オブジェクトの比較にあると属性を取り出して直接比較を行ってしまうことがある。
        しかしそれは値オブジェクトであることを考えると不自然。
        値と同じように値オブジェクト同士が比較できるようにする方が自然な記述になる。
    */
    class FullName3 : IEquatable<FullName>
    {
        public FullName(string firstName, string lastName)
        {
            FirstName = firstName;
            LastName = lastName;
        }

        public string FirstName { get; }
        public string LastName { get; }

        public static bool operator ==(FullName left, FullName right)
        {
            return Equals(left, right);
        }

        public static bool operator !=(FullName left, FullName right)
        {
            return !Equals(left, right);
        }

        public bool Equals(FullName other)
        {
            if (ReferenceEquals(null, other)) return false;
            if (ReferenceEquals(this, other)) return true;
            return FirstName == other.FirstName && LastName == other.LastName;
        }

        public override bool Equals(object obj)
        {
            if (ReferenceEquals(null, obj)) return false;
            if (ReferenceEquals(this, obj)) return true;
            if (obj.GetType() != this.GetType()) return false;
            return Equals((FullName) obj);
        }

        public override int GetHashCode()
        {
            return HashCode.Combine(FirstName, LastName);
        }
    }
}

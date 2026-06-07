# Clean Code
## 第1章：クリーンコード

### コードは消えない

AIや抽象化が進んでも、最終的には「機械が実行できるほど正確な記述」が必要になる。

それがコード。

つまり：

- コード = 要求の最終表現
- コード品質 = システム品質


### 悪いコードは技術問題ではなく経営問題

悪いコードが増えると：

- 修正が怖くなる
- 変更で別箇所が壊れる
- 開発速度が落ちる
- チーム全体が疲弊する
- 新規メンバーがさらに混乱を増やす
- 最終的に全面リプレイスが始まる

そして新システムもまた腐る。


最重要ポイント

悪いコードは：

- 生産性を下げる
- 品質を下げる
- チームを壊す
- 会社を壊す


### 「後で綺麗にする」はほぼ起こらない

開発者はよく：

- 急いでいる
- 疲れている
- 締切が近い

という理由で汚いコードを書く。

そして：

後で直そう

と思う。

しかし：

Later equals never.

後ではほぼ永遠に来ない。


### 速く進む唯一の方法は、綺麗に保つこと

これは本書最大級の核心。

多くの開発者は：

- 締切のために雑に書く
- とりあえず動かす

を選ぶ。

しかし現実には：

- 汚いコード → 即座に速度低下
- 修正コスト増大
- 認知負荷増大

を引き起こす。


結論

速く進む唯一の方法は、
常にコードをクリーンに保つこと。


### Clean Codeはプロフェッショナリズム

Uncle Bob がかなり強く言っている部分。


重要な主張

悪いコードの責任を：

- 要件
- スケジュール
- 上司
- 顧客

だけに押し付けるな。


なぜか

プログラマーは：

- 技術的リスク
- 設計上の問題
- 将来の保守コスト

を最も理解している側だから。


医者の例

患者が：

「手洗い省略して早く手術して」

と言っても、
医者は従わない。

なぜなら：

- 感染リスクを理解しているから。

同じように：

プログラマーも、
「技術的負債の危険性」を理解している。

だから、
無秩序を受け入れるのはプロとして不適切。


### Clean Codeは“読む人”のために書く

超重要。

コードは：

- 書く時間より
- 読む時間の方が圧倒的に長い


比率

読む : 書く = 10 : 1以上


つまり

コードは：

- コンピュータのためではなく
- 人間の理解のために書く

べき。


### 読みやすさは開発速度そのもの

今日書くコードの難しさは、
周囲コードの読みやすさに依存する。

つまり：

- 読みやすいコード → 開発高速化
- 読みにくいコード → 開発低速化


結論

書きやすくしたいなら、
まず読みやすくせよ。


### Clean Codeとは何か

著名プログラマーたちの共通点をまとめると：


共通する特徴

① 一つのことだけをする

- 関数
- クラス
- モジュール

が単一責任に集中している。


② 意図が明確

読んだ瞬間：

- 何をしているか
- なぜ存在するか

が分かる。


③ 驚きがない

Ward Cunningham の重要概念。

Clean Codeは：

「思った通りに動く」


④ 小さい

- 小さい関数
- 小さいクラス
- 小さい責務


⑤ 重複が少ない

重複は：

- 隠れた概念
- 抽象不足

のサイン。


⑥ テストがある

Dave Thomas：

テストのないコードはCleanではない。


⑦ 他人が変更できる

「読める」と「変更できる」は違う。

Clean Codeは：

- 他人が安全に変更できる
- 拡張できる
- 理解できる


⑧ 細部が丁寧

- 命名
- エラー処理
- 一貫性
- 整理

などに“care”がある。


### Clean Codeは芸術に近い

良いコードを書くには：

- 小さな技術
- 習慣
- 感覚
- 美意識

が必要。


コードセンス

著者はこれを：

code-sense

と呼ぶ。


コードセンスがある人は：

- 混乱を見る
- 問題構造を見抜く
- 改善ルートを設計する
- 少しずつ綺麗に変形する


### ボーイスカウト・ルール

本書で最重要級に実践的な原則。


原則

来た時より少し綺麗にして帰る


小さな改善でいい

- 変数名を改善
- 関数分割
- 小さな重複削除
- if整理

これを継続する。


結果

コードは：

- 腐らない
- 徐々に改善する
- 長期的に速度が上がる


### この本は「唯一絶対の正解」ではない

Uncle Bobは：

- 自分たちの思想を強く主張する
- でも絶対真理とは言わない


武道の流派の比喩

Clean Codeにも：

- 流派
- 思想
- 美学

がある。


重要なのは

全部盲信することではなく：

- なぜそう考えるのか
- どんな経験から来ているのか

を理解すること。


### 第1章の本質

この章は技術書というより：

- プロ論
- 職業倫理
- ソフトウェア哲学

に近い。


最終メッセージ

Clean Codeとは：

- 美しさ
- 読みやすさ
- 意図の明確さ
- 継続改善
- 他人への配慮
- 将来への配慮

の総合体。


一番重要な一文を要約すると

コードは動けばいいのではない。人間が理解し、安全に変更できなければならない。


2章：意味のある名前（Meaningful Names）

名前は「人間の理解」を助けるために存在する

命名の目的は、コンパイラを通すことではない。

人間が：

- 読みやすい
- 理解しやすい
- 検索しやすい
- 会話しやすい
- 誤解しにくい

コードを書くためにある。

良い名前を付けるには時間がかかる。
しかし、そのコストは後で何倍にもなって返ってくる。

だから：

- 名前には真剣に時間を使う
- より良い名前が見つかったらリネームする
- コメントで補う前に命名を改善する

ことが重要。


意図を表す名前を使う

変数・関数・クラスの名前は：

- なぜ存在するのか
- 何をするのか
- どう使うのか

を伝えるべき。

悪い例：

int d; // 日数

何の d なのか分からない。

改善：

int elapsedTimeInDays;
int daysSinceCreation;
int daysSinceModification;
int fileAgeInDays;

名前だけで意味が伝わる。


暗黙性を減らす

問題はコードの複雑さではなく、
「前提知識が必要すぎること」。

悪い例：

public List<int[]> getThem() {
  List<int[]> list1 = new ArrayList<int[]>();

  for (int[] x : theList)
    if (x[0] == 4)
      list1.add(x);
  return list1;
}

分からないこと：

- theList は何か
- x[0] は何か
- 4 は何か
- 戻り値は何か


名前で意味を明示する

改善版：

public List<int[]> getFlaggedCells() {
  List<int[]> flaggedCells = new ArrayList<int[]>();

  for (int[] cell : gameBoard)
    if (cell[STATUS_VALUE] == FLAGGED)
        flaggedCells.add(cell);
  return flaggedCells;
}


さらに改善：

public List getFlaggedCells() {
List flaggedCells = new ArrayList();
for (Cell cell : gameBoard)
if (cell.isFlagged())
flaggedCells.add(cell);
return flaggedCells;
}

コード構造はほぼ同じなのに、
意味が圧倒的に読みやすくなる。


誤解を生む名前を避ける

名前は「誤解の種」を残してはいけない。

例えば：

accountList

実際に List 型ではないなら危険。

改善：

- accounts
- accountGroup
- accountSet


似すぎた名前は危険

悪い例：

XYZControllerForEfficientHandlingOfStrings
XYZControllerForEfficientStorageOfStrings

見分けづらい。

IDE補完時に事故を起こしやすい。


1文字変数は危険

特に：

l
O

は危険。

int a = l;
if ( O == l )
a = O1;
else
l = 01;

1 と 0 にしか見えない。

問題はフォントではなく命名。


意味のある区別をする

悪い例：

a1
a2
a3

意味がない。

悪いコード：

public static void copyChars(char a1[], char a2[]) {
for (int i = 0; i < a1.length; i++) {
a2[i] = a1[i];
}
}

改善：

source
destination

名前だけで役割が分かる。


ノイズワードを避ける

悪い例：

Product
ProductInfo
ProductData

Info や Data は意味を増やしていない。

同様に：

- object
- table
- variable
- data

もノイズになりやすい。


微妙な違いは混乱を生む

危険な例：

getActiveAccount()
getActiveAccounts()
getActiveAccountInfo()

直感的に違いが分からない。

名前の違いは、
「概念の違い」として読まれる。


発音できる名前を使う

人間は言葉で思考する。

だから名前は発音可能であるべき。

悪い例：

class DtaRcrd102 {
private Date genymdhms;
private Date modymdhms;
private final String pszqint = “102”;
}

読みにくい。

改善：

class Customer {
private Date generationTimestamp;
private Date modificationTimestamp;
private final String recordId = “102”;
}

自然に会話できる。


検索しやすい名前を使う

悪い例：

- e
- i
- j
- 7

検索しづらい。

改善：

MAX_CLASSES_PER_STUDENT

のように意味ある定数名にする。


長い名前は悪ではない

重要なのは短さではなく、
理解しやすさ。

悪い例：

for (int j=0; j<34; j++) {
s += (t[j]*4)/5;
}

何も分からない。

改善：

int realDaysPerIdealDay = 4;
const int WORK_DAYS_PER_WEEK = 5;
int sum = 0;

for (int j=0; j < NUMBER_OF_TASKS; j++) {
int realTaskDays = taskEstimate[j] - realDaysPerIdealDay;
int realTaskWeeks = (realTaskDays / WORK_DAYS_PER_WEEK);
sum += realTaskWeeks;
}

長いが圧倒的に理解しやすい。


エンコーディングを避ける

型情報などを名前へ埋め込まない。

悪い例：

strName
iCount
lpBuffer

現代IDEでは不要。

さらに：

PhoneNumber phoneString;

のように、
型変更後に名前だけ古い状態が残る。

名前が嘘をつく。


メンバプレフィックスは不要

悪い例：

public class Part {
  private String m_dsc;
  void setName(String name) {
    m_dsc = name;
  }
}

改善：

public class Part {
  String description;

  void setDescription(String description) {
    this.description = description;
  }
}

m_ はノイズになりやすい。


インターフェース名を汚さない

悪い例：

IShapeFactory

改善：

ShapeFactory

実装側で：

ShapeFactoryImpl

のように区別する方が自然。


メンタルマッピングを避ける

読者に：

c = customer?
config?
category?

のような変換を強制してはいけない。

悪い例：

「a と b が使われてたから c にした」

これは命名ではなく、
空き文字の消費。


賢さを見せるな

悪い例：

HolyHandGrenade()

改善：

DeleteItems()

ジョークより明確さを優先する。


クラス名

クラス名は名詞。

良い例：

- Customer
- Account
- WikiPage
- AddressParser

避けたい：

- Manager
- Processor
- Data
- Info

曖昧すぎる。


メソッド名

メソッド名は動詞。

良い例：

- save
- deletePage
- postPayment

getter/setter：

String name = employee.getName();
customer.setName(“mike”);

if (paycheck.isPosted()) …


静的ファクトリメソッド

悪い例：

Complex fulcrumPoint = new Complex(23.0);

改善：

Complex fulcrumPoint = Complex.FromRealNumber(23.0);

意味が明確。


1つの概念には1つの単語を使う

悪い例：

- fetch
- retrieve
- get

同じ意味なのに統一されていない。

良いコードは：

取得 = get
追加 = append
削除 = remove

のように統一される。

予測可能性が上がる。


ダジャレをするな

同じ単語を別意味で使うな。

例えば：

add()

が：

- 数値加算
- 文字列連結

には使われていた。

そこへ：

- コレクション挿入

の意味まで入れると混乱する。

その場合は：

- insert
- append

を使う。


コードは軽く読めるべき

コードは：

- 精読する論文

ではなく：

- 軽く読める文章

であるべき。

著者の責任は：

「読者が頑張ること」

ではなく：

「自然に理解できるように書くこと」


解決領域の名前を使う

プログラマ向けコードなら：

- アルゴリズム名
- デザインパターン名
- CS用語

を使ってよい。

例：

AccountVisitor

VISITORパターン経験者なら即理解できる。


問題領域の名前を使う

技術用語より業務用語が適切なら、
ドメイン用語を使う。

良い設計者は：

- 技術領域
- 業務領域

を分離する。


文脈を追加する

単体で意味を持つ名前は少ない。

悪い例：

state

これだけでは：

- 州
- 状態
- ステータス

か分からない。

改善：

addrState

さらに良い：

Address クラス化。

address.state

文脈が自然に生まれる。


文脈をオブジェクト化する

悪い例：

private void printGuessStatistics(char candidate, int count) {
  String number;
  String verb;
  String pluralModifier;

  if (count == 0) {
    number = “no”;
    verb = “are”;
    pluralModifier = “s”;
  } else if (count == 1) {
    number = “1”;
    verb = “is”;
    pluralModifier = “”;
  } else {
    number = Integer.toString(count);
    verb = “are”;
    pluralModifier = “s”;
  }

  String guessMessage = String.format(
    “There %s %s %s%s”, verb, number, candidate, pluralModifier
  );

  print(guessMessage);
}

number
verb
pluralModifier

の意味が分からない。

改善：

public class GuessStatisticsMessage {
  private String number;
  private String verb;
  private String pluralModifier;

  public String make(char candidate, int count) {
    createPluralDependentMessageParts(count);

    return String.format(
      “There %s %s %s%s”,
      verb, number, candidate, pluralModifier
    );
  }

  private void createPluralDependentMessageParts(int count) {
    if (count == 0) {
      thereAreNoLetters();
    } else if (count == 1) {
      thereIsOneLetter();
    } else {
      thereAreManyLetters(count);
    }
  }

  private void thereAreManyLetters(int count) {
    number = Integer.toString(count);
    verb = “are”;
    pluralModifier = “s”;
  }

  private void thereIsOneLetter() {
    number = “1”;
    verb = “is”;
    pluralModifier = “”;
  }

  private void thereAreNoLetters() {
    number = “no”;
    verb = “are”;
    pluralModifier = “s”;
  }
}

文脈整理は：

- 概念整理
- 責務整理
- 関数分割
- 可読性向上

につながる。


不要な文脈を追加しない

悪い例：

GSDAccountAddress
GSDCustomer
GSDPaymentManager

IDE補完がノイズだらけになる。

良い例：

Address
Customer
PaymentManager

必要最小限の文脈だけ付ける。


最後に

良い命名は技術力だけではない。

- 説明力
- 言語感覚
- 共有文化

が必要。

そして重要なのは：

名前は後から改善してよい

ということ。

リネームを恐れてはいけない。

現代では：

- IDE
- リファクタリングツール
- 検索機能

がある。

本当に重要なのは：

コードが自然に読めるか

である。

命名は、単なるラベル付けではない。

設計そのもの。


## 関数（Functions）

プログラミング初期の時代、システムは「ルーチン」や「サブルーチン」で構成されていた。

その後、Fortran や PL/1 の時代になると、
システムは「プログラム」「サブプログラム」「関数」によって構成されるようになった。

そして現在、当時から生き残っている中心的な概念が「関数（function）」である。

関数は、あらゆるプログラムにおける最初の整理単位だ。

この章では、「良い関数を書くこと」を扱う。


次のコードを見てほしい。

Listing 3-1

```HtmlUtil.java (FitNesse 20070619)

public static String testableHtml(PageData pageData, boolean includeSuiteSetup) throws Exception {
  WikiPage wikiPage = pageData.getWikiPage();
  StringBuffer buffer = new StringBuffer();

  if (pageData.hasAttribute("Test")) {

    if (includeSuiteSetup) {
        WikiPage suiteSetup =
            PageCrawlerImpl.getInheritedPage(
                SuiteResponder.SUITE_SETUP_NAME, wikiPage
            );

        if (suiteSetup != null) {
            WikiPagePath pagePath =
                suiteSetup.getPageCrawler().getFullPath(suiteSetup);

            String pagePathName = PathParser.render(pagePath);

            buffer.append("!include -setup .")
                  .append(pagePathName)
                  .append("\n");
        }
    }

    WikiPage setup = PageCrawlerImpl.getInheritedPage("SetUp", wikiPage);

    if (setup != null) {
        WikiPagePath setupPath = wikiPage.getPageCrawler().getFullPath(setup);
        String setupPathName = PathParser.render(setupPath);

        buffer.append("!include -setup .")
              .append(setupPathName)
              .append("\n");
    }
  }

  buffer.append(pageData.getContent());

  if (pageData.hasAttribute("Test")) {

      WikiPage teardown = PageCrawlerImpl.getInheritedPage("TearDown", wikiPage);

      if (teardown != null) {
          WikiPagePath tearDownPath =
              wikiPage.getPageCrawler().getFullPath(teardown);

          String tearDownPathName =
              PathParser.render(tearDownPath);

          buffer.append("\n")
              .append("!include -teardown .")
              .append(tearDownPathName)
              .append("\n");
      }

      if (includeSuiteSetup) {
          WikiPage suiteTeardown =
              PageCrawlerImpl.getInheritedPage(
                  SuiteResponder.SUITE_TEARDOWN_NAME,
                  wikiPage
              );

          if (suiteTeardown != null) {
              WikiPagePath pagePath =　suiteTeardown.getPageCrawler().getFullPath(suiteTeardown);
              String pagePathName =　PathParser.render(pagePath);

              buffer.append("!include -teardown .")
             　     .append(pagePathName)
           　       .append("\n");
          }
      }
  }
  pageData.setContent(buffer.toString());
  return pageData.getHtml();
}
```

この関数を3分見て、
内容を理解できただろうか？

おそらく難しい。

なぜなら：

- 長い
- 重複コードが多い
- 奇妙な文字列が散らばっている
- 分かりにくいAPI呼び出しが多い
- ネストした if が複雑
- 抽象レベルが混在している

からだ。

つまり：

「何をしたいコードなのか」

が埋もれている。


しかし著者は、

- メソッド抽出
- リネーム
- 少しの構造整理

だけで、次のように改善できたと言う。

Listing 3-2

```HtmlUtil.java (refactored)

public static String renderPageWithSetupsAndTeardowns(PageData pageData,　boolean isSuite) throws Exception {
  boolean isTestPage = pageData.hasAttribute("Test");

  if (isTestPage) {

      WikiPage testPage = pageData.getWikiPage();
      StringBuffer newPageContent = new StringBuffer();

      includeSetupPages(
          testPage,
          newPageContent,
          isSuite
      );

      newPageContent.append(pageData.getContent());

      includeTeardownPages(
          testPage,
          newPageContent,
          isSuite
      );

      pageData.setContent(newPageContent.toString());

  }

  return pageData.getHtml();
}
```

FitNesse を知らない人でも、こちらはかなり理解しやすい。

完全な詳細までは分からなくても、

「setup ページと teardown ページを test ページへ組み込み、HTMLとして出力している」

という意図はかなり自然に読める。

さらに：

- JUnit を知っている人なら
- Webベースのテストフレームワーク

だということまで推測できる。

つまり、Listing 3-1 では埋もれていた“意図”が、Listing 3-2 では表面へ出てきている。


では、なぜ Listing 3-2 は読みやすいのか？

なぜ意図が伝わるのか？

どうすれば関数は：

- 意図を伝え
- 読者に構造を理解させ
- システム全体を推測させられる

のか？

この章では、そのための「良い関数の条件」を扱っていく。



小さくせよ（Small!）

関数における第一のルール：

「関数は小さくあるべき」

第二のルール：

「もっと小さくあるべき」

著者は、
これを論文や研究結果で証明できるわけではないと言う。

しかし、40年近くにわたり、

- 3000行の巨大関数
- 100〜300行の関数
- 20〜30行の関数

など、あらゆるサイズの関数を書いてきた経験から、
強く確信している。

その結論が：

「関数は非常に小さくあるべき」

ということ。


1980年代には、

「関数は1画面に収まるべき」

と言われていた。

当時の VT100 端末は：

- 24行
- 80文字幅

程度しかなかった。

しかもエディタUIで数行使うため、
実際にコードを書けるのはもっと少なかった。


現在は：

- 大型モニタ
- 小さいフォント

によって、

- 100行以上
- 150文字幅

でも1画面に収まる。

しかし著者は言う。

だからといって：

- 1行150文字
- 100行関数

を書いていいわけではない。

関数は、
ほとんどの場合20行未満であるべきだ。


では、
どれくらい短いべきなのか？

著者は1999年、
Kent Beck の家を訪れ、
一緒にプログラミングしたという。

そのとき Kent は、
「Sparkle」という小さな Java/Swing プログラムを見せた。

これは：

- マウスカーソルからキラキラが落ちる
- シンデレラの魔法の杖のような演出
- 重力で下へ落下する

という視覚エフェクトだった。


著者が驚いたのは、
エフェクトではなく「関数の短さ」。

Swing プログラムといえば、
縦に長大な関数だらけという印象だった。

しかし Sparkle の関数は：

- 2行
- 3行
- 4行

程度しかなかった。

しかも：

- 完全に明快
- 何をしているか即分かる
- 物語のようにつながる
- 次の関数を自然に読みたくなる

という構造だった。

著者は言う。

「関数は、あれくらい短くあるべきだ」


先ほどの Listing 3-2 ですら、
まだ長い。

本当は、
次の Listing 3-3 くらいまで削れるべきだという。

Listing 3-3

```HtmlUtil.java (re-refactored)

public static String renderPageWithSetupsAndTeardowns(PageData pageData, boolean isSuite) throws Exception {
  if (isTestPage(pageData))
    includeSetupAndTeardownPages(
        pageData,
        isSuite
    );

  return pageData.getHtml();
}
```

ここでは：

- 「テストページか判定」
- 「setup / teardown を追加」

という詳細が、
意味を持つ関数名へ抽出されている。

つまり、
関数本体には：

「何をしたいか」

だけが残っている。


ブロックとインデント（Blocks and Indenting）

この考え方から導かれる重要な原則がある。

if / else / while などのブロック内は、基本的に1行であるべき。

そしてその1行は、たいてい関数呼び出しになる。

例えば：

if (isTestPage(pageData))
  includeSetupAndTeardownPages(pageData, isSuite);

のように。


なぜこれが良いのか？

理由は2つある。

1. 関数が小さく保てる

ネスト内部へ大量の処理を書き始めると、関数はすぐ巨大化する。

関数呼び出しへ抽出すれば、トップレベルは非常に簡潔になる。


2. 「説明文」として機能する

重要なのはここ。

関数名そのものが、ドキュメントになる。

つまり：

includeSetupAndTeardownPages()

という名前を見るだけで、

「setup と teardown を追加する処理なんだな」

と理解できる。

コードの詳細を読む必要がない。


さらに著者は言う。

関数は、ネスト構造を大量に抱え込むほど大きくなるべきではない。

つまり：

- if の中に while
- while の中に if
- if の中に switch

のような深い構造を避ける。


理想的には、
インデントレベルは：

- 1段
- 多くても2段

まで。

これによって：

- 読みやすさ
- 理解速度
- 見通し

が大きく改善される。


この節の本質はかなり重要。

著者が言いたいのは：

「処理を書くな」

ではない。

「詳細を適切な抽象へ隠せ」ということ。


良い関数は：

- 小さい
- 1つの意図だけを語る
- 名前だけで流れが読める
- ネストが浅い
- 上から読むだけで物語になる

つまり：

コードを“読む体験”そのものを設計しろ

という思想。

1つのことだけをせよ（Do One Thing）

Listing 3-1 が、
大量のことをしているのは明らかだ。

例えば：

- バッファ生成
- ページ取得
- 継承ページ探索
- パス描画
- 謎の文字列追加
- HTML生成

など。

つまり、
さまざまな責務が混在している。


一方、
Listing 3-3 はかなりシンプルだ。

public static String renderPageWithSetupsAndTeardowns(
    PageData pageData,
    boolean isSuite
) throws Exception {

    if (isTestPage(pageData))
        includeSetupAndTeardownPages(
            pageData,
            isSuite
        );

    return pageData.getHtml();
}

この関数は：

「テストページへ setup / teardown を含める」

という、
1つのことだけをしているように見える。


ここで著者は、
30年以上語られ続けてきた原則を出す。

FUNCTIONS SHOULD DO ONE THING.
THEY SHOULD DO IT WELL.
THEY SHOULD DO IT ONLY.

関数は1つのことをすべきだ。
それをうまくやるべきだ。
そして、それだけをやるべきだ。


しかし問題は：

「1つのこと」

とは何か？

これがかなり難しい。


例えば Listing 3-3 は、
本当に1つのことだけをしているのか？

見方によっては：

1. テストページか判定
2. setup / teardown を追加
3. HTMLへ変換

という3つのことをしているようにも見える。


では、
なぜ著者は「1つのこと」だと言うのか？

ここがかなり重要。


著者は、
関数を「TO 段落」で説明できるかを見る。

つまり：

「○○するために、
まず△△して、
次に□□して、
最後に〜する」

という自然言語の説明。


Listing 3-3 はこう説明できる。

TO RenderPageWithSetupsAndTeardowns,
we check to see whether the page is a test page
and if so,
we include the setups and teardowns.
In either case
we render the page in HTML.

つまり：

「RenderPageWithSetupsAndTeardowns を行うために、
テストページか確認し、
必要なら setup / teardown を追加し、
HTMLとして描画する」


ここで重要なのは：

これらの処理が、
関数名の“1段下の抽象レベル”に揃っている

という点。


つまり著者の定義では：

関数が、
“同じ抽象レベルのステップだけ”
で構成されているなら、

それは「1つのこと」をしている。


逆に悪い関数は：

- 高レベル処理
- 低レベル詳細
- 実装細部
- 業務フロー

が混在する。

例えば：

processPayment();
PreparedStatement stmt = ...

みたいに。

これは：

- 「支払い処理」
- 「SQL構築」

という異なる抽象レベルが混ざっている。

脳がズームイン・ズームアウトを繰り返す。


だから「1つのこと」とは、
処理数ではなく：

抽象レベルの一貫性

に近い。

ここかなり重要。


著者はさらに、関数が「複数のこと」をしている見分け方も示す。

それは：

意味のある別名で関数抽出できるか

ということ。


例えば：

if (isTestPage(pageData))

    includeSetupAndTeardownPages(

        pageData,

        isSuite

    );
を

includeSetupsAndTeardownsIfTestPage();


へ抽出しても、ほぼ同じことを言い換えているだけ。

抽象度は変わっていない。

だから価値が薄い。


一方で：

PreparedStatement stmt = ...
ResultSet result = ...

を：

fetchUserFromDatabase();


へ抽出するなら、抽象レベルが変わる。

これは意味がある。


つまり、「実装の言い換え」しかできないなら、その関数は十分小さい可能性が高い。

逆に別抽象の名前で切り出せるなら、まだ複数責務が混ざっている。


関数内セクション（Sections within Functions）

著者はさらに、関数内の「セクション分け」自体が危険信号だと言う。

例えば：

// declarations

// initializations

// validations

// rendering

みたいな構造。

これはつまり：

「関数の中に複数フェーズが存在している」

ということ。


本当に1つのことだけをする関数は、自然にセクション分割できない。

なぜなら：

全体が1つの流れだから。


ここ、かなり Clean Code の核心。

著者は：

「関数は処理の箱ではない」

と思ってる。

関数は：

“1つの抽象概念を表現する文章”

だと思ってる。

だから：

- 抽象レベルを揃え
- 詳細を隠し
- 上から読める物語にし
- 1つの意図だけ語らせる

という方向へ徹底的に寄せていく。


関数引数（Function Arguments）

関数の理想的な引数の数は：

- 0個（niladic）
- 次に1個（monadic）
- 次に2個（dyadic）

3個（triadic）は可能なら避けるべき。

4個以上（polyadic）は、
特別な正当化が必要であり、
それでも使うべきではない。


引数は難しい。

引数は、
読者の「認知負荷」を大きく増やす。

だから著者は、
サンプルコードからほとんどの引数を取り除いた。


例えばサンプル中の：

StringBuffer

本来なら引数として渡すこともできた。

しかしそうすると、
読者はそのたびに：

- これは何か
- なぜ必要か
- どのレベルの概念か

を解釈しなければならなくなる。


例えば：

includeSetupPage()

は理解しやすい。

しかし：

includeSetupPageInto(newPageContent)

は読みにくい。


理由は：

関数名と引数が、
異なる抽象レベルにあるから。


関数名は：

「setupページを追加する」

という高レベル概念。

しかし：

StringBuffer

という詳細実装を、
読者へ強制的に意識させている。

その時点では、
その詳細は重要ではない。


テスト観点でも引数は難しい

引数が増えると、
テストケースが爆発する。


- 引数0個 → 非常に簡単
- 引数1個 → まだ manageable
- 引数2個 → 少し難しい
- 引数3個以上 → 組み合わせが急増


適切な値の全組み合わせをテストするのは、
かなり大変になる。


Output Argument はさらに悪い

出力引数は、入力引数より理解しづらい。


通常、人は関数を読むとき：

入力 → 引数

出力 → return値

を期待している。


しかし出力引数は：引数から値が出ていく

という逆方向。

だから読者は：

え？
この引数って入力じゃなくて出力？

と二度見することになる。


単一引数はかなり良い

引数1個は、
引数なしの次に良い。

例えば：

SetupTeardownIncluder.render(pageData)

これはかなり自然。

pageData を render するんだな

とすぐ理解できる。


単一引数関数の典型形（Common Monadic Forms）

単一引数関数には、
主に2つの典型形がある。


1. 質問する関数

boolean fileExists("MyFile")

引数について質問している。


2. 変換する関数

InputStream fileOpen("MyFile")


文字列を
InputStream に変換して返している。


読者は、
この2種類を自然に期待している。

だから関数名も：

- 質問
- 変換

が分かるように命名すべき。


イベント型関数

もう1つ、
少し特殊だが有用な形がある。

それが「イベント」。


例：

void passwordAttemptFailedNtimes(int attempts)


これは：

- return値なし
- システム状態変更

を表す。


読者に、これはイベントだ

と分かる必要がある。

だから：

- 名前
- 文脈

を慎重に選ぶべき。


避けるべき単一引数関数

例えば：

void includeSetupPageInto(StringBuffer pageText)

これは良くない。

理由：

変換なのか、
イベントなのか、
副作用なのか、
意図が曖昧。


もし変換なら：

StringBuffer transform(StringBuffer in)

の方が良い。


たとえ内部的に
同じオブジェクトを返していたとしても、
「変換」という形を守っている。


Flag Argument（フラグ引数）

著者は boolean 引数をかなり嫌う。

例：

render(true)

これは最悪に近い。


理由：

true の時はAをする

false の時はBをする

つまり：

関数が複数のことをしている

と宣言しているから。


著者は：

renderForSuite()
renderForSingleTest()


のように、
関数を分けるべきだと言う。


これはかなり重要。

boolean 引数は：

「分岐責務が関数に混入している」

サインになりやすい。


2引数関数（Dyadic Functions）

2引数関数は、
単一引数より理解が難しい。


例えば：

writeField(name)

は自然。

しかし：

writeField(outputStream, name)

は少し読む負荷がある。


読者は最初の引数を：

まあ無視していいかな…

と読み飛ばし始める。

しかし：

「無視されるコード」
にはバグが潜む。


2引数が自然なケース

例えば：

new Point(0,0)

これは自然。

x,y は：

- 同一概念
- 順序あり
- 強い結びつき

を持つから。


一方：

outputStream, name

には自然な結びつきがない。

assertEquals 問題

assertEquals(expected, actual)


これ、
順番ミスる。

かなりよくある。


理由：

引数順序が自然ではなく、
「慣習」に依存しているから。


Dyad は悪ではない

2引数を完全禁止はできない。

しかし：

- コストがある
- できれば単一引数へ変換したい


例えば：
outputStream.writeField(name)

に変える。


あるいは：

FieldWriter

みたいなクラスへ抽出する。


3引数関数（Triads）

3引数はさらに難しい。


- 順序問題
- 読み飛ばし問題
- 認知負荷

が一気に増える。


例：

assertEquals(message, expected, actual)

message を expected と見間違える

と言っている。

かなり実感ある。


一方：

assertEquals(1.0, amount, .001)

はまだマシ。


浮動小数点比較には誤差が必要、
という重要概念を表しているから。


Argument Object（引数オブジェクト）

引数が多いなら、
概念としてまとめるべき。


悪い例：

makeCircle(double x, double y, double radius)

良い例：

makeCircle(Point center, double radius)


これはズルではない。

x,y が：

1つの概念

だから。


つまり：

一緒に渡される変数群　=　新しい概念候補


可変長引数（Argument Lists）

例えば：

String.format("%s worked %.2f hours.", name, hours)

これは内部的には：

Object... args

つまり List 的。


著者の考えでは、
これは実質：

2引数関数。

format(String format, Object... args)


だから：

- monad
- dyad
- triad

ルールはそのまま適用される。


動詞とキーワード（Verbs and Keywords）

良い名前は：

- 意図
- 引数順序
- 引数意味

まで説明できる。


例えば：

write(name)

より

writeField(name)

の方が良い

さらに：

assertExpectedEqualsActual(expected, actual)

なら、引数順序ミスを減らせる。

つまり：

関数名へ、引数意味を埋め込む。

これをKeyword Formと呼んでいる。


副作用を持つな（Have No Side Effects）

副作用は「嘘」だ。

関数は「1つのことをする」と約束しているのに、
実際には裏で別のことまでしている。

例えば：

- クラス内部の変数を書き換える
- 引数を書き換える
- グローバル状態を変更する

など。

こうした隠れた変更は、
時間的依存（temporal coupling）や、
呼び出し順依存を生み、
バグの原因になる。

例えば次のコード：

public class UserValidator {
  private Cryptographer cryptographer;

  public boolean checkPassword(String userName, String password) {

    User user = UserGateway.findByName(userName);

    if (user != User.NULL) {

        String codedPhrase = user.getPhraseEncodedByPassword();

        String phrase = cryptographer.decrypt(codedPhrase, password);

        if ("Valid Password".equals(phrase)) {

            Session.initialize(); // ここが副作用
            return true;

        }

    }

    return false;
  }
}


一見すると：

「パスワードを検証する関数」

に見える。

しかし実際には：

Session.initialize();

を呼んでいる。

つまり：

- パスワード検証
- セッション初期化

の2つをやっている。

問題は、
関数名からセッション初期化が読み取れないこと。

呼び出し側は：

checkPassword(…)

という名前を見て、

「パスワード確認だけ」

だと思ってしまう。

結果として、
既存セッションが消える可能性がある。

これは「時間的結合（Temporal Coupling）」を生む。

つまり：

「この関数は特定タイミングでしか呼べない」

状態になる。

もし時間依存があるなら、
少なくとも名前に表現すべき。

例えば：

checkPasswordAndInitializeSession()

しかしこれは：

- 名前が長い
- そもそも1つのことをしていない

という問題がある。


出力引数（Output Arguments）

引数は普通、

「入力」

として読まれる。

だから「出力引数」は混乱を生む。

例えば：

appendFooter(s);

これを見たとき、

- s を footer として追加するのか
- footer を s に追加するのか

分からない。

シグネチャを見ると：

public void appendFooter(StringBuffer report)

つまり：

report

が書き換えられている。

これは「出力引数」。

読む側は：

- 呼び出し
- 定義ジャンプ
- シグネチャ確認

を強いられる。

これは認知負荷になる。

昔の手続き型言語では、
出力引数は必要だった。

しかしOOでは、
多くの場合不要。

例えば：

report.appendFooter();

の方が自然。

「report自身を変更する」

と直感的に分かる。

基本ルール：

- 出力引数は避ける
- 状態変更するなら owning object にさせる


Command Query Separation（CQS）

関数は：

- 「何かする（Command）」
- 「何か返す（Query）」

のどちらかだけにするべき。

両方を同時にやると混乱する。

例えば：

public boolean set(String attribute, String value);

この関数は：

- 属性を書き換える
- 成功したか返す

の両方をやっている。

すると：

if (set(“username”, “unclebob”))

が曖昧になる。

読む側は：

- username が unclebob だったか？
- username を unclebob に設定できたか？

どちらなのか一瞬迷う。

問題は：

set

が：

- 動詞
- 状態

の両方に読めること。

作者は：

「設定する」

の意味で使った。

しかし if 文では：

「設定済みである」

にも読める。

例えば：

setAndCheckIfExists()

みたいにしても、根本解決にはならない。

本当の解決策は：

Command と Query を分離すること。

つまり：

if (attributeExists(“username”)) {
  setAttribute(“username”, “unclebob”);
}

にする。

これなら：

- 確認
- 更新

が完全に分離される。

意図も明確。


この節の本質

関数名は「契約」

関数名を見た人は：

「この関数はこれをする」

と信じる。

副作用は、その契約を破る。


隠れた状態変更は危険

特に危険なのは：

- セッション変更
- グローバル変更
- 引数変更
- キャッシュ更新
- DB更新

など。

名前に出ていない変更。


関数は予測可能であるべき

理想は：

result = transform(input)

を見た瞬間に、

- input がどう扱われるか
- result が何か

が予測できること。


CQS の本質

関数を：

- Command（変更）
- Query（取得）

に分離する。

つまり：

- 状態変更する関数は値を返さない
- 値を返す関数は状態変更しない

これで認知負荷が激減する。


Clean Code 的な思想

読み手は：「この関数、裏で何かやってるかも…」と警戒しながら読みたくない。

理想は、名前を見た瞬間、挙動が自然に予測できるコード。



エラーコードを返すより例外を優先する

コマンド関数からエラーコードを返すことは、コマンド・クエリ分離（Command Query Separation）を微妙に破る行為です。
なぜなら、それによってコマンドが if 文の条件式の中で使われるようになるからです。

if (deletePage(page) == E_OK)


これは「動詞/形容詞の混乱（verb/adjective confusion）」は引き起こしませんが、その代わりに深くネストした構造を生み出します。
エラーコードを返す設計では、呼び出し側がその場で即座にエラー処理をしなければならなくなります。

if (deletePage(page) == E_OK) {
    if (registry.deleteReference(page.name) == E_OK) {
        if (configKeys.deleteKey(page.name.makeKey()) == E_OK){
            logger.log("page deleted");
        } else {
            logger.log("configKey not deleted");
        }
    } else {
        logger.log("deleteReference from registry failed");
    }
} else {
    logger.log("delete failed");
    return E_ERROR;
}


一方、エラーコードの代わりに例外を使えば、エラー処理コードを正常系（happy path）のコードから分離できます。
結果として、コードはかなりシンプルになります。

try {
    deletePage(page);
    registry.deleteReference(page.name);
    configKeys.deleteKey(page.name.makeKey());
}
catch (Exception e) {
    logger.log(e.getMessage());
}


Try/Catch ブロックを抽出する

try/catch ブロック自体も見た目が悪いものです。
コード構造を分かりづらくし、正常処理とエラー処理を混在させてしまいます。

そのため、try ブロックや catch ブロックの中身は、それぞれ別の関数へ抽出した方が良いです。


public void delete(Page page) {
    try {
        deletePageAndAllReferences(page);
    }
    catch (Exception e) {
        logError(e);
    }
}

private void deletePageAndAllReferences(Page page) throws Exception {
    deletePage(page);
    registry.deleteReference(page.name);
    configKeys.deleteKey(page.name.makeKey());
}

private void logError(Exception e) {
    logger.log(e.getMessage());
}

この例では、delete 関数はエラー処理だけに集中しています。
そのため理解しやすく、読み飛ばすのも簡単です。

一方 deletePageAndAllReferences 関数は、「ページを完全に削除する処理」だけに集中しています。
エラー処理を無視して読めるため、コードの理解と修正が容易になります。

⸻

エラー処理は“ひとつの責務”である

関数は「ひとつのこと」だけを行うべきです。
エラー処理もまた「ひとつのこと」です。

つまり、エラー処理を行う関数は、それ以外のことをしてはいけません。

これは、先ほどの例のように、関数内に try キーワードが存在するなら、それは関数の最初に現れるべきであり、catch / finally ブロックの後に処理を書いてはいけない、ということを意味します。

⸻

Error.java という“依存の磁石”

エラーコードを返す設計では、多くの場合、すべてのエラーコードを定義したクラスや enum が存在します。


public enum Error {
    OK,
    INVALID,
    NO_SUCH,
    LOCKED,
    OUT_OF_RESOURCES,
    WAITING_FOR_EVENT;
}

このようなクラスは「依存の磁石（dependency magnet）」になります。
多くのクラスがこれを import して使うためです。

その結果、Error enum が変更されるたびに、それを利用しているクラス群を再コンパイルし、再デプロイしなければなりません。

これは Error クラスに対して強い負荷を生みます。
プログラマは新しいエラーコードを追加したがらなくなります。
なぜなら、そのたびにシステム全体をビルド・再デプロイしなければならないからです。

そのため、新しいエラーを追加せず、既存のエラーコードを使い回すようになります。

一方、エラーコードではなく例外を使う場合、新しい例外は既存の例外クラスを継承して追加できます。
そのため、再コンパイルや再デプロイを強制することなく拡張できます。


同じことを繰り返すな（Don’t Repeat Yourself）¹³

Listing 3-1 をもう一度よく見てみると、
SetUp、SuiteSetUp、TearDown、SuiteTearDown の各ケースで、同じアルゴリズムが4回繰り返されていることに気づくはずです。

この重複は見つけにくいです。
なぜなら、4つの処理が別のコードに混ざっており、完全に同じ形で並んでいないからです。

それでも、この重複は問題です。
コード量を膨らませるだけでなく、アルゴリズム変更時に4箇所すべて修正しなければならなくなるからです。
さらに、「1箇所だけ修正を忘れる」というミスの機会も4倍になります。

この重複は、Listing 3-7 の include メソッドによって解消されました。
もう一度そのコードを読んでみると、重複が減ったことで、モジュール全体の可読性が向上していることが分かるはずです。

重複は、ソフトウェアにおける“あらゆる悪の根源”かもしれません。
多くの原則や設計手法は、重複を制御・排除するために生み出されました。

たとえば、Codd のデータベース正規形は、データの重複を排除するための仕組みです。
オブジェクト指向プログラミングも、本来重複していたコードを基底クラスへ集約するための考え方です。

構造化プログラミング、アスペクト指向プログラミング、コンポーネント指向プログラミングも、部分的には「重複を減らす戦略」です。

サブルーチン（関数）が発明されて以来、ソフトウェア開発における多くの革新は、「ソースコードから重複を取り除く試み」だったとも言えます。

⸻

構造化プログラミング

一部のプログラマは、エドガー・ダイクストラ（Edsger Dijkstra）の構造化プログラミング規則に従っています。¹⁴

ダイクストラは、

* すべての関数
* 関数内のすべてのブロック

は、「入口が1つ、出口が1つ」であるべきだと述べました。

このルールに従うと、

* 関数内の return は1つだけ
* ループ内で break や continue を使わない
* goto は絶対に使わない

という制約になります。

私たちは構造化プログラミングの目的や規律には共感しています。
ですが、関数が十分小さい場合、そのルールによる恩恵はあまり大きくありません。

これらのルールが本当に効果を発揮するのは、大きな関数に対してです。

だから関数を小さく保てるなら、

* 複数の return
* break
* continue

を適度に使っても問題ありません。
場合によっては、「単一入口・単一出口」のルールよりも、むしろ表現力が高くなることすらあります。

一方で、goto が意味を持つのは大きな関数だけです。
そのため、避けるべきです。

⸻

どうやってこんな関数を書くのか？

ソフトウェアを書くことは、文章を書くことに似ています。

論文や記事を書くとき、人はまず考えを書き出します。
そのあと、読みやすくなるまで何度も推敲します。

最初の草稿は、不格好で整理されていないかもしれません。
だから言葉を磨き、構造を変え、洗練させていきます。

関数を書くときも同じです。

私が最初に書く関数は、長くて複雑です。

* 深いインデント
* ネストしたループ
* 長い引数リスト
* 適当な名前
* 重複コード

そういうものが普通に含まれています。

ですが同時に、私はその不格好なコードをカバーするユニットテスト群も用意しています。

そこからコードを磨いていきます。

* 関数を分割する
* 名前を変える
* 重複を消す
* メソッドを短くする
* 順番を整理する
* 必要ならクラスごと分割する

そうしながらも、テストが通り続ける状態を維持します。

最終的に、この章で述べたルールに従った関数へたどり着きます。

最初からそう書けるわけではありません。
おそらく、誰にもできないでしょう。

⸻

結論

あらゆるシステムは、
そのシステムを記述するためにプログラマが設計した「ドメイン固有言語（DSL）」によって構成されています。

その言語において、

* 関数は「動詞」
* クラスは「名詞」

です。

これは、「要件定義書の名詞と動詞を抜き出してクラスと関数にする」という昔の乱暴な設計論を意味しているわけではありません。

もっと本質的で、昔から存在する真実です。

プログラミングとは、常に「言語設計の技術」なのです。

優れたプログラマは、システムを「書くプログラム」としてではなく、「語るべき物語」として捉えます。

彼らは、使用するプログラミング言語の機能を活用しながら、
その物語を表現するための、より豊かで表現力の高い言語を構築していきます。

そのドメイン固有言語の一部が、「システム内で起きるすべての動作」を表現する関数階層です。

そして再帰的な芸術性の中で、それらの関数自身もまた、自分たちが定義したその言語を使って、自分の役割を語ります。

この章は、「良い関数を書く技術」について説明してきました。

ここで述べたルールに従えば、

* 関数は短くなり
* 名前は分かりやすくなり
* 構造は整理されます

ですが、忘れてはいけません。

本当の目的は、「システムという物語を語ること」です。

そしてあなたの関数は、その物語を明確かつ正確に語るための“言語”として、自然につながっていなければならないのです。

Listing 3-7
```SetupTeardownIncluder.java

package fitnesse.html;
import fitnesse.responders.run.SuiteResponder;
import fitnesse.wiki.*;

public class SetupTeardownIncluder {
  private PageData pageData;
  private boolean isSuite;
  private WikiPage testPage;
  private StringBuffer newPageContent;
  private PageCrawler pageCrawler;

  public static String render(PageData pageData) throws Exception {
    return render(pageData, false);
  }

  public static String render(PageData pageData, boolean isSuite) throws Exception {
    return new SetupTeardownIncluder(pageData).render(isSuite);
  }

  private SetupTeardownIncluder(PageData pageData) {
    this.pageData = pageData;

    testPage = pageData.getWikiPage();
    pageCrawler = testPage.getPageCrawler();
    newPageContent = new StringBuffer();
  }

  private String render(boolean isSuite) throws Exception {
    this.isSuite = isSuite;

    if (isTestPage())
      includeSetupAndTeardownPages();
    return pageData.getHtml();
  }

  private boolean isTestPage() throws Exception {
    return pageData.hasAttribute("Test");
  }

  private void includeSetupAndTeardownPages() throws Exception {
    includeSetupPages();
    includePageContent();
    includeTeardownPages();
    updatePageContent();
  }

  private void includeSetupPages() throws Exception {
    if (isSuite)
      includeSuiteSetupPage();
    includeSetupPage();
  }

  private void includeSuiteSetupPage() throws Exception {
    include(SuiteResponder.SUITE_SETUP_NAME, "-setup");
  }

  private void includeSetupPage() throws Exception {
    include("SetUp", "-setup");
  }

  private void includePageContent() throws Exception {
    newPageContent.append(pageData.getContent());
  }

  private void includeTeardownPages() throws Exception {
    includeTeardownPage();
    if (isSuite)
      includeSuiteTeardownPage();
  }

  private void includeTeardownPage() throws Exception {
    include("TearDown", "-teardown");
  }

  private void includeSuiteTeardownPage() throws Exception {
    include(SuiteResponder.SUITE_TEARDOWN_NAME, "-teardown");
  }

  private void updatePageContent() throws Exception {
    pageData.setContent(newPageContent.toString());
  }

  private void include(String pageName, String arg) throws Exception {
    WikiPage inheritedPage = findInheritedPage(pageName);
    if (inheritedPage != null) {
      String pagePathName = getPathNameForPage(inheritedPage);
      buildIncludeDirective(pagePathName, arg);
    }
  }

  private WikiPage findInheritedPage(String pageName) throws Exception {
    return PageCrawlerImpl.getInheritedPage(pageName, testPage);
  }

  private String getPathNameForPage(WikiPage page) throws Exception {
    WikiPagePath pagePath = pageCrawler.getFullPath(page);

    return PathParser.render(pagePath);
  }

  private void buildIncludeDirective(String pagePathName, String arg) {
    newPageContent.append("\n!include ")
                  .append(arg)
                  .append(" .")
                  .append(pagePathName)
                  .append("\n");
  }
}
```

「ひどいコードにコメントを書くな。書き直せ。」

— Brian W. Kernighan & P. J. Plaugher

適切な場所に置かれたコメントほど役立つものはありません。
一方で、軽薄で独善的なコメントほどモジュールを散らかすものもありません。
さらに、古くなって腐敗したコメントほど、有害なものもありません。
それは嘘や誤情報を広めるからです。

コメントは『シンドラーのリスト』のような“純粋な善”ではありません。
むしろコメントとは、良くても「必要悪」です。

もしプログラミング言語が十分に表現力を持っていたなら。
あるいは、私たちにその言語を巧みに扱う才能があったなら。
コメントはほとんど不要だったでしょう。
もしかすると、完全に不要だったかもしれません。

コメントの本来の役割は、「コードだけでは意図を表現しきれなかった失敗」を補うことです。

ここで私は“失敗”という言葉を使いました。
意図的です。

コメントは常に失敗です。

もちろん、どうしても必要な場面はあります。
コードだけで意図を表現できないこともあります。
だからコメントを書くわけです。

ですが、それは誇るべきことではありません。

コメントを書こうとしている自分に気づいたら、一度立ち止まって考えるべきです。

「これ、本当にコメントでしか表現できないか？」
「コードそのものへ落とし込めないか？」

コードによって意図を表現できたなら、自分を褒めていい。
コメントを書いたなら、自分の表現力不足を少し恥じるべきだ。

⸻

なぜそこまでコメントに否定的なのか？

理由はシンプルです。

コメントは嘘をつくからです。

もちろん、常に嘘とは限りません。
悪意があるわけでもありません。

ですが、あまりにも頻繁に間違った状態になります。

コメントは古くなるほど、
そしてコードから離れるほど、
間違っている可能性が高くなります。

理由も単純です。

プログラマは現実的に、コメントを完全には保守できません。

コードは変化し、進化します。

* 別の場所へ移動される
* 分岐する
* 統合される
* 再構成される

ですがコメントは、それについていけません。

そして気づけば、

コードから切り離された、精度がどんどん低下していく孤児コメント

になります。

例えば次の例。


MockRequest request;

private final String HTTP_DATE_REGEXP =

"[SMTWF][a-z]{2}\\,\\s[0-9]{2}\\s[JFMASOND][a-z]{2}\\s"+

"[0-9]{4}\\s[0-9]{2}\\:[0-9]{2}\\:[0-9]{2}\\sGMT";

private Response response;

private FitNesseContext context;

private FileResponder responder;

private Locale saveLocale;

// Example: "Tue, 02 Apr 2003 22:18:49 GMT"

本来このコメントは HTTP_DATE_REGEXP の説明だったはずです。
ですが後から別のインスタンス変数が追加され、コメントと対象コードが離れてしまっています。

⸻

もちろん、

「プログラマが規律を持ってコメントを保守すべきだ」


という意見もあります。

私もそれ自体には同意します。

ですが私は、その労力を、

コメント不要なくらい明確で表現力の高いコードを書くこと


へ使いたい。

⸻

間違ったコメントは、コメントが無いより悪い

不正確なコメントは、人を惑わせます。

* 誤解を生む
* 満たされない期待を作る
* 古いルールを正しいものとして残す

真実は、コードの中にしかありません。

コードだけが、「実際に何をしているか」を正確に語れます。

コードだけが、本当に信頼できる情報源です。

だからコメントが必要な場面はあるとしても、
私たちはそれを最小限に抑える努力をすべきなのです。

⸻

コメントは悪いコードを補えない

コメントを書く最も一般的な理由の一つは、「コードが汚いから」です。

私たちはコードを書きながら気づいています。

「あ、これ分かりづらいな」
「ぐちゃぐちゃだな」

するとこう考える。

「よし、コメントを書いて説明しよう！」


違う。

掃除しろ。

コメントだらけの複雑コードより、コメントが少なくても、明確で読みやすいコード

の方が圧倒的に優れています。

自分が作った混乱を説明するためにコメントを書くくらいなら、その混乱自体を取り除くべきです。

⸻

コードで説明せよ

もちろん、コードだけでは説明しづらい場面もあります。

ですが多くのプログラマは、それを拡大解釈して、

「コードは説明手段として役に立たない」

と思い込んでいます。

これは明らかに間違いです。

例えば次のコード。


// Check to see if the employee is eligible for full benefits
if ((employee.flags & HOURLY_FLAG) &&(employee.age > 65))

それとも、こちらの方が良いでしょうか？

if (employee.isEligibleForFullBenefits())

ほとんどの場合、少し考えるだけで、コメントに書こうとしていた意図をコードへ埋め込めます。

多くの場合それは、コメント内容をそのまま表現する関数を作るだけです。


良いコメント

もちろん、必要で有益なコメントも存在します。

ここからは、「その存在価値がある」と私が考えるコメントを見ていきます。

とはいえ、忘れないでください。

本当に良いコメントとは、「書かずに済ませられたコメント」なのです。


法的コメント（Legal Comments）

企業のコーディング規約によって、法的理由からコメントが必要になることがあります。

例えば：

* 著作権表示
* 作者情報
* ライセンス表記

などです。

例えば FitNesse では、すべてのソースファイル先頭に次のようなコメントを書いています。

// Copyright (C) 2003,2004,2005 by Object Mentor, Inc. All rights reserved.
// Released under the terms of the GNU General Public License version 2 or later.


幸い、私たちのIDEはこのコメントを自動折りたたみしてくれるので、視覚的ノイズになっていません。

こうしたコメントは、契約書や法律文書のように長くすべきではありません。

可能なら、詳細は外部ドキュメントや標準ライセンスへ参照させるべきです。

⸻

情報提供コメント（Informative Comments）

コメントによって基本情報を補足することが有効な場合もあります。

例えば：

// Returns an instance of the Responder being tested.
protected abstract Responder responderInstance();


これは抽象メソッドの返り値を説明しています。

こういうコメントは有用な場合もあります。
ですが可能なら、関数名そのもので表現した方が良い。

例えば：

responderBeingTested()

のように名前を変えれば、コメントは不要になります。

次の例はもう少しマシです。

// format matched kk:mm:ss EEE, MMM dd, yyyy
Pattern timeMatcher = Pattern.compile("\\d*:\\d*:\\d* \\w*, \\w* \\d*, \\d*");

このコメントによって、この正規表現が

SimpleDateFormat.format

で指定フォーマットを使った日時文字列へマッチすることが分かります。

とはいえ、これも理想的には、日時フォーマット変換専用クラスへ切り出されていれば、コメント自体が不要だったかもしれません。


意図の説明（Explanation of Intent）

ときにはコメントが、単なる実装説明を超えて、「なぜその設計判断をしたのか」という意図を伝えることがあります。

次の例では、コメントによって興味深い設計判断が説明されています。

この作者は、オブジェクト比較時に、

「自分のクラスのオブジェクトを、他クラスより常に大きいものとして扱う」

という方針を選びました。

public int compareTo(Object o)
{
    if(o instanceof WikiPagePath)
    {
        WikiPagePath p = (WikiPagePath) o;
        String compressedName = StringUtil.join(names, "");
        String compressedArgumentName = StringUtil.join(p.names, "");
        return compressedName.compareTo(compressedArgumentName);
    }

    return 1; // we are greater because we are the right type.
}

「正しい型なので、こちらを“大きい”とみなす」という設計意図を説明しています。


さらに良い例はこちらです。

解決方法に賛成できないかもしれません。

ですが少なくとも、「この人が何を達成しようとしていたか」は分かります。


public void testConcurrentAddWidgets() throws Exception {
    WidgetBuilder widgetBuilder =
        new WidgetBuilder(new Class[]{BoldWidget.class});

    String text = "'''bold text'''";

    ParentWidget parent =
        new BoldWidget(new MockWidgetRoot(), "'''bold text'''");

    AtomicBoolean failFlag = new AtomicBoolean();
    failFlag.set(false);

    //This is our best attempt to get a race condition
    //by creating large number of threads.

    for (int i = 0; i < 25000; i++) {
        WidgetBuilderThread widgetBuilderThread =
            new WidgetBuilderThread(widgetBuilder, text, parent, failFlag);

        Thread thread = new Thread(widgetBuilderThread);
        thread.start();
    }

    assertEquals(false, failFlag.get());
}


「大量スレッドを生成して、レースコンディションを発生させようとしている」

という“テストの狙い”を説明しています。

コードだけでは、「なんで2万5000スレッド？」となりかねないので、意図説明として価値があります。


明確化（Clarification）

ときには、

* 分かりづらい引数
* 不明瞭な戻り値

の意味を、人間に読みやすい形へ翻訳するコメントが役立つことがあります。

理想的には、引数や戻り値そのものを分かりやすく設計すべきです。
ですが、

* 標準ライブラリ
* 自分で変更できないコード

の場合は、補足コメントが有効になることがあります。


public void testCompareTo() throws Exception
{
    WikiPagePath a = PathParser.parse("PageA");
    WikiPagePath ab = PathParser.parse("PageA.PageB");
    WikiPagePath b = PathParser.parse("PageB");
    WikiPagePath aa = PathParser.parse("PageA.PageA");
    WikiPagePath bb = PathParser.parse("PageB.PageB");
    WikiPagePath ba = PathParser.parse("PageB.PageA");

    assertTrue(a.compareTo(a) == 0); // a == a
    assertTrue(a.compareTo(b) != 0); // a != b
    assertTrue(ab.compareTo(ab) == 0); // ab == ab

    assertTrue(a.compareTo(b) == -1); // a < b
    assertTrue(aa.compareTo(ab) == -1); // aa < ab
    assertTrue(ba.compareTo(bb) == -1); // ba < bb

    assertTrue(b.compareTo(a) == 1); // b > a
    assertTrue(ab.compareTo(aa) == 1); // ab > aa
    assertTrue(bb.compareTo(ba) == 1); // bb > ba
}

ここでは、

// a < b


のようなコメントが、比較結果の意味を人間向けに説明しています。

⸻

もちろん、こうしたコメントには大きなリスクがあります。

コメント自体が間違っている可能性があるからです。

実際、上の例を見ても、

「このコメント本当に正しい？」

を確認するのは結構大変です。

これは、「だから補足コメントが必要」であると同時に、「だから危険」でもある、ということです。

なので、こういうコメントを書く前には、「もっと良い表現方法はないか？」をまず考えるべきです。

そして書くなら、正確性に細心の注意を払うべきです。


結果への警告（Warning of Consequences）

ときには、

「これをやるとどうなるか」


を他のプログラマへ警告するコメントが有用な場合があります。

例えば次の例。


// Don't run unless you
// have some time to kill.

public void _testWithReallyBigFile()
{
    writeLinesToFile(10000000);

    response.setBody(testFile);
    response.readyToSend(this);

    String responseString = output.toString();

    assertSubString("Content-Length: 1000000000", responseString);
    assertTrue(bytesSent > 1000000000);
}

「暇を持て余してる時以外は実行するな」という冗談混じりの警告です。

めちゃくちゃ時間がかかるという意味。

現代なら、おそらく：

@Ignore("Takes too long to run")

のように書くでしょう。

このコメントは軽口ではありますが、十分役割を果たしています。

⸻

もう少し深刻な例はこちら。


public static SimpleDateFormat makeStandardHttpDateFormat()
{
    //SimpleDateFormat is not thread safe,
    //so we need to create each instance independently.

    SimpleDateFormat df =
        new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss z");

    df.setTimeZone(TimeZone.getTimeZone("GMT"));

    return df;
}


SimpleDateFormat はスレッドセーフではないので、毎回インスタンス生成が必要

という重要な注意を伝えています。

もちろん、「もっと良い解決方法あるだろ」と言いたくなるかもしれません。

私も同意するかもしれません。

ですが、このコメント自体は十分に合理的です。

なぜなら、これによって、

「効率化のため static 化しよう！」

と考えた“やる気のあるプログラマ”が事故を起こすのを防げるからです。


TODO コメント（TODO Comments）

//TODO コメントという形で、「あとでやること」を残すのは、場合によっては合理的です。

次の例では、TODO コメントによって、

* なぜ関数が不完全実装なのか
* 将来的にどうなる予定なのか

が説明されています。

//TODO-MdM these are not needed
// We expect this to go away when we do the checkout model

protected VersionInfo makeVersion() throws Exception
{
    return null;
}


TODO は、「本来やるべきだと思っているが、今はできない作業」です。

例えば：

* 廃止予定機能の削除リマインダ
* 問題調査の依頼
* より良い命名案の検討
* 将来イベントに依存する修正

など。

ですが TODO は、「汚いコードを放置する言い訳」ではない。


最近のIDEは、TODO コメントを一覧化する機能を持っています。
だから TODO が完全に埋もれることは少ない。

それでも、TODOだらけのコードベースにはしたくありません。

定期的に見直して、消せるものは消すべきです。


強調（Amplification）

コメントは、ときに、一見すると些細に見える処理の重要性を強調するために使われます。


String listItemContent = match.group(3).trim();

// the trim is real important. It removes the starting
// spaces that could cause the item to be recognized
// as another list.

new ListItemWidget(this, listItemContent, this.level + 1);

return buildList(text.substring(match.end()));


ここでは trim() が非常に重要であることを説明しています。

もし先頭スペースを削除しなければ、別のリスト項目として誤認識される可能性がある。

コードだけ見ると、「なんで trim 必要なの？」となるので、このコメントには価値があります。


Public API の Javadocs

優れた Public API のドキュメントほど、ありがたいものはありません。

Java標準ライブラリの Javadocs はその代表例です。

正直、あれ無しで Java プログラムを書くのはかなり厳しい。

だから Public API を作るなら、良い Javadocs を書くべきです。

ですが、この章で述べた原則は忘れてはいけません。

Javadocs もまた、

* 誤解を生み
* コードから離れ
* 嘘をつく

可能性があります。

⸻

悪いコメント（Bad Comments）

大半のコメントは、このカテゴリに入ります。

それらは多くの場合、

* 汚いコードの松葉杖
* 不十分な設計判断の言い訳
* プログラマの独り言

に過ぎません。


ぶつぶつコメント（Mumbling）

「コメントを書かなきゃいけない気がしたから書く」

あるいは、「プロセス上必要だから」という理由だけでコメントを書くのは手抜きです。

コメントを書くなら、「できる限り良いコメントを書く」努力をすべきです。

⸻

例えば次のコード。

public void loadProperties()
{
    try
    {
        String propertiesPath =
            propertiesLocation + "/" + PROPERTIES_FILE;

        FileInputStream propertiesStream =
            new FileInputStream(propertiesPath);

        loadedProperties.load(propertiesStream);
    }
    catch(IOException e)
    {
        // No properties files means all defaults are loaded
    }
}

これ、何を意味しているのか？

作者には意味があったのでしょう。
ですが読者には伝わりません。

例えば：

* デフォルト値は誰がロードするのか？
* load の前にロード済み？
* load() 内部で例外処理してる？
* catch 空なのを自分に言い訳してる？
* 後で実装するつもりだった？

全部不明です。

結局、他モジュールを読みに行くしかない。

つまり、「別モジュールを読まないと意味が分からないコメント」は、コミュニケーションに失敗しています。


冗長コメント（Redundant Comments）

次のコード。

// Utility method that returns when this.closed is true.
// Throws an exception if the timeout is reached.

public synchronized void waitForClose(final long timeoutMillis)　throws Exception
{
    if(!closed)
    {
        wait(timeoutMillis);

        if(!closed)
            throw new Exception(
                "MockResponseSender could not be closed");
    }
}

このコメントに意味はあるでしょうか？

コードより分かりやすい？
正確？
意図説明してる？

何もしていません。

むしろ、曖昧な理解で満足させてしまう危険があります。

著者はこれを、「ボンネットを開けなくて大丈夫ですよ」と言う中古車営業に例えている。


誤解を招くコメント（Misleading Comments）

善意で書かれたコメントでも、不正確なら危険です。

先ほどの：
// Utility method that returns when this.closed is true.

このコメント、実は嘘です。

メソッドは：closed が true になった瞬間に return するわけではない

実際には：

* timeout まで wait
* まだ closed じゃなければ exception

です。

つまりコメントが微妙に間違ってる。

すると読者は：「closedになったら即返るんだな」と誤解する

その結果、なんでこんなに遅いの？というデバッグ地獄に入る。

強制コメント（Mandated Comments）

「全関数に Javadoc 必須」

みたいなルールは、ただ馬鹿げています。

そういうコメントは：

* ノイズを増やし
* 嘘を広め
* 混乱を増幅する

だけ。

例えば：

/**
 * @param title The title of the CD
 * @param author The author of the CD
 * @param tracks The number of tracks on the CD
 * @param durationInMinutes The duration of the CD in minutes
 */


 これ、見れば分かる。

価値ゼロ。

⸻

ジャーナルコメント（Journal Comments）

昔は、ファイル先頭に変更履歴を書く文化がありました。

2001-10-11 修正
2002-05-29 修正
...

みたいなやつ。

昔はバージョン管理システムが弱かったので意味がありました。

ですが今は Git がある。

だからこういう履歴コメントは、ただのノイズです。

削除すべき。


ノイズコメント（Noise Comments）

例えば：

/**
 * Default constructor.
 */
protected AnnualDateRule() {
}

いや、見れば分かる。

あるいは：

/** The day of the month. */
private int dayOfMonth;

とか。

さらに：

/**
 * Returns the day of the month.
 *
 * @return the day of the month.
 */
public int getDayOfMonth() {
    return dayOfMonth;
}

ここまで来ると、もはや冗長性の芸術。

こういうコメントはノイズが強すぎるので、私たちは次第に“読まなく”なります。

コードを読むとき、目が自然にスキップするようになる。

そして最終的には、周囲のコードが変化することで、コメントは嘘をつき始めます。


Listing 4-4 の最初のコメントは、まだ妥当です。

これは、「なぜ catch ブロックを無視しているのか」を説明している。

ですが2つ目のコメントは、完全なノイズです。

作者はおそらく、try/catch を何重にも書かされてイライラしていたのでしょう。
その感情をコメントにぶつけています。


Listing 4-4 startSending

private void startSending()
{
    try
    {
        doSending();
    }
    catch(SocketException e)
    {
        // normal. someone stopped the request.
    }
    catch(Exception e)
    {
        try
        {
            response.add(ErrorResponder.makeExceptionString(e));
            response.closeAll();
        }
        catch(Exception e1)
        {
            //Give me a break!
        }
    }
}

本来やるべきなのは「コード構造を改善する」こと。

Listing 4-5 startSending（改善後）

private void startSending()
{
    try
    {
        doSending();
    }
    catch(SocketException e)
    {
        // normal. someone stopped the request.
    }
    catch(Exception e)
    {
        addExceptionAndCloseResponse(e);
    }
}

private void addExceptionAndCloseResponse(Exception e)
{
    try
    {
        response.add(ErrorResponder.makeExceptionString(e));
        response.closeAll();
    }
    catch(Exception e1)
    {
    }
}


ノイズコメントを書きたくなったら、「コードを綺麗にする」方向へエネルギーを使え。

その方が、プログラマとして幸せになれる。


恐ろしいノイズ（Scary Noise）

Javadocs もまたノイズになります。

次の Javadocs（有名OSSライブラリより）は何の役に立つでしょう？

答え：何の役にも立たない。

これは、「ドキュメントを書かなきゃ」という誤った使命感から生まれた、冗長ノイズです。


/** The name. */
private String name;

/** The version. */
private String version;

/** The licenceName. */
private String licenceName;

/** The version. */
private String info;

もう一度よく見てください。

コピペミスがあります。

つまり作者自身が注意深く読んでいない。

なら、読者がそれを信用できる理由はどこにあるのか？

⸻

コメントの代わりに関数や変数を使え

次のコード。

// does the module from the global list <mod> depend on the
// subsystem we are part of?

if (smodule.getDependSubsystems().contains(subSysMod.getSubSystem()))

これはコメント無しで、もっと分かりやすく書けます。

ArrayList moduleDependees = smodule.getDependSubsystems();
String ourSubSystem = subSysMod.getSubSystem();

if (moduleDependees.contains(ourSubSystem))

元の作者は、先にコメントを書いてから実装したのかもしれません。

ですが、その後でリファクタリングして、コメント不要なコードへすべきでした。


位置マーカー（Position Markers）

プログラマは時々、ソースコード内にこんな区切りを書きます。

// Actions //////////////////////////////////

ごく稀には意味があります。

ですが通常は、ただの clutter（散らかし）です。

特に最後のスラッシュ列はノイズ。

バナーというのは滅多に無いから目立つのであって、多用すると背景ノイズになります。


閉じカッココメント（Closing Brace Comments）

次のように、閉じカッコへコメントを書く人がいます。

例えば：

} //while
} // try
} //catch
} //main

長大でネストが深い関数なら、多少意味があるかもしれません。

ですが私たちが目指す小さくカプセル化された関数ではただのノイズです。

もし閉じカッコへコメントを書きたくなったなら、関数が長すぎる可能性を疑うべきです。


作者署名コメント（Attributions and Bylines）

Git のようなソースコード管理システムは、

* 誰が
* いつ
* 何を

変更したか全部覚えている。

だからコードを汚す必要はありません。

「誰へ聞けばいいか分かるから便利」

と思うかもしれません。

ですが実際には古くなって不正確になるだけです。

この情報は、コードではなくVCSに置くべき。


コメントアウトされたコード（Commented-Out Code）

最悪級の習慣の一つ。

やるな。

// InputStream resultsStream = formatter.getResultStream();
// StreamReader reader = new StreamReader(resultsStream);
// response.setContent(reader.read(formatter.getByteCount()));

こういうコードを見ると、他の人は消せなくなる。

「理由があって残してるのかも…」

と思ってしまう。

結果として、腐ったワインの底の澱みたいに蓄積していく。

⸻

Apache Commons の例。

//hdrPos = bytePos;
//dataPos = bytePos;


なぜコメントアウトされてる？

* 重要？
* 後で戻す予定？
* 古いゴミ？

誰にも分からない。

1960年代なら、コメントアウトにも意味があったかもしれません。

ですが今は違う。

私たちは Git を持っています。

ソース管理システムが、過去コードを覚えていてくれる。

だから：

コメントアウトするな。
消せ。
失われないから。安心しろ。


HTML コメント

ソースコード内コメントに HTML を書くのは最悪です。

下のコードを読むと分かる通り、コメント自体が読みにくくなる。

/**
* Task to run fit tests.
* This task runs fitnesse tests and publishes the results.
* <p/>
* <pre>
* Usage:
* &lt;taskdef name=&quot;execute-fitnesse-tests&quot;
* classname=&quot;fitnesse.ant.ExecuteFitnesseTestsTask&quot;
* classpathref=&quot;classpath&quot; /&gt;
* OR
* &lt;taskdef classpathref=&quot;classpath&quot;
* resource=&quot;tasks.properties&quot; /&gt;
* <p/>
* &lt;execute-fitnesse-tests
* suitepage=&quot;FitNesse.SuiteAcceptanceTests&quot;
* fitnesseport=&quot;8082&quot;
* resultsdir=&quot;${results.dir}&quot;
* resultshtmlpage=&quot;fit-results.html&quot;
* classpathref=&quot;classpath&quot; /&gt;
* </pre>
*/

本来コメントは、エディタやIDE上で読みやすくするべきなのに。

もしコメントを Javadoc のようなツールで抽出して Web 表示したいなら、HTML装飾はツール側の責務であるべき。

プログラマが HTML を埋め込むべきではない。


非局所情報（Nonlocal Information）

コメントを書くなら、近くのコードを説明しろです。

ローカルコメントの中で、システム全体の情報を語るな。

例えば：

/**
 * Port on which fitnesse would run.
 * Defaults to 8082.
 */
public void setFitnessePort(int fitnessePort)
{
    this.fitnessePort = fitnessePort;
}

この関数は、デフォルト値 8082を決めていない。

なのにコメントでそれを説明している。

つまりこのコメントは、この関数ではなく、遠く離れた別システムの仕様を語っている。

当然、デフォルト値変更時にコメント更新される保証もない。


情報過多（Too Much Information）

コメントへ、

* 歴史談義
* 余計な詳細
* 不要な仕様説明

を書き込むな。

次は Base64 エンコードテストコードから抜粋されたコメント。

RFC の詳細が大量に貼られている。

ですがコード読む人に必要なのは、RFC番号ぐらい。

細かいビット列説明は不要。

コメントがコード理解を助けるのではなく、情報洪水になっている。

分かりにくい関連性（Inobvious Connection）

コメントとコードの関係は、見ればわかる状態であるべき。

例えば：

/*
 * start with an array that is big enough to hold all the pixels
 * (plus filter bytes), and an extra 200 bytes for header info
 */
this.pngBytes =
    new byte[((this.width + 1) * this.height * 3) + 200];


何が問題か？

* filter byte って何？
* +1 のこと？
* *3 のこと？
* pixel は1byte？
* なぜ200？

コメント自体が説明不足。

つまり、コメントを理解するためにさらに説明が必要になっている。

本末転倒。


関数ヘッダ（Function Headers）

短い関数には長い説明は不要。


の方が、コメントヘッダより優れている。

⸻

非公開コードの Javadocs

Public API に対する Javadocs は有用。

ですが、外部公開しない内部コードへ大量 Javadocs を付けるのは害悪です。


システム内部クラスに対する Javadoc ページ生成なんて、普通ほとんど価値がない。

なのに：

* 形式的
* 冗長
* ノイズ

だけ増える。

⸻

実例（Example）

著者は昔、悪いコードと悪いコメントの例として Listing 4-7 を書いたそうです。

当時は、「よくドキュメント化されている」と思われていた。

今見ると小さなゴミ山。


/**
* This class Generates prime numbers up to a user specified
* maximum. The algorithm used is the Sieve of Eratosthenes.
* <p>
* Eratosthenes of Cyrene, b. c. 276 BC, Cyrene, Libya --
* d. c. 194, Alexandria. The first man to calculate the
* circumference of the Earth. Also known for working on
* calendars with leap years and ran the library at Alexandria.
* <p>
* The algorithm is quite simple. Given an array of integers
* starting at 2. Cross out all multiples of 2. Find the next
* uncrossed integer, and cross out all of its multiples.
* Repeat untilyou have passed the square root of the maximum
* value.
*
* @author Alphonse
* @version 13 Feb 2002 atp
*/
import java.util.*;
public class GeneratePrimes
{
  /**
  * @param maxValue is the generation limit.
  */

  public static int[] generatePrimes(int maxValue)
  {
    if (maxValue >= 2) // the only valid case
    {
      // declarations
      int s = maxValue + 1; // size of array
      boolean[] f = new boolean[s];
      int i;

      // initialize array to true.
      for (i = 0; i < s; i++)
        f[i] = true;

      // get rid of known non-primes
      f[0] = f[1] = false;
      // sieve
      int j;
      for (i = 2; i < Math.sqrt(s) + 1; i++){
        if (f[i]) // if i is uncrossed, cross its multiples.
        {
          for (j = 2 * i; j < s; j += i)
            f[j] = false; // multiple is not prime
        }
      }
      // how many primes are there?
      int count = 0;
      for (i = 0; i < s; i++)
      {
      if (f[i])
          count++; // bump count.
      }
      int[] primes = new int[count];
      // move the primes into the result
      for (i = 0, j = 0; i < s; i++)
      {
        if (f[i]) // if prime
          primes[j++] = i;
      }
        return primes; // return the primes
    }
    else // maxValue < 2
      return new int[0]; // return null array if bad input.
  }
}

GeneratePrimes.java の問題点

コードを見ると：

* 冗長コメント
* obvious コメント
* 関数が長い
* 意味の弱い変数名
* コメント依存

など問題だらけ。

例えば：

// initialize array to true.

見れば分かる。

// get rid of known non-primes

もコードで表現可能。

// bump count.

完全にノイズ。

// return the primes

見ればわかる。


フォーマット（Formatting）

人がコードの内部を見たとき、

「整然さ」「一貫性」「細部への注意」

に感心してほしい。

秩序を感じてほしい。

モジュールをスクロールしながら、

「プロが作ってるな」

と思ってほしい。

逆に、

酔っぱらった船乗り集団が書いたような、ぐちゃぐちゃコード

が見えたら、人はこう考える。

「どうせ他の部分も雑なんだろう」

と。

だからコードは綺麗にフォーマットすべき。

単純なルールを決め、一貫して適用する。

チーム開発なら、

「チーム全体で統一ルール」

を持つべき。

自動整形ツールがあると理想的。

⸻

フォーマットの目的（The Purpose of Formatting）

まず明確にしておく。

コードフォーマットは重要。

無視できるほど軽くない。

一方で、

「宗教化するほど神聖でもない」

フォーマットの本質は、

「コミュニケーション」

です。

そしてコミュニケーションこそ、

「プロ開発者の最重要業務」

。

もしかすると昔は、

「動けばいい」

が最優先だと思っていたかもしれない。

ですがこの本をここまで読んできたなら、

「それが誤解だ」

と理解しているはず。

今日作った機能は、次のリリースで変更される可能性が高い。

ですが：

「コードの読みやすさ」

は、未来のすべての変更へ影響する。

コーディングスタイルと可読性は、

* 保守性
* 拡張性

へ長期的影響を与える。

元コードが原型を失っても、

「あなたのスタイルと規律」

は残り続ける。

⸻

垂直方向のフォーマット（Vertical Formatting）

まずファイルの縦サイズ。

ソースファイルはどれくらい大きくあるべきか？

Java では、

「ファイルサイズ ≒ クラスサイズ」

なので密接に関係している。

著者はいくつかの有名プロジェクトを調査している。

* JUnit
* FitNesse
* TestNG
* Ant
* Tomcat

など。

するとかなり差がある。

例えば：

* FitNesse の平均ファイル長は約65行
* 大半は200行未満
* 最大でも約400行

一方：

* Tomcat
* Ant

には、

「数千行ファイル」

も存在する。

そこから分かること。

「大規模システムでも小さいファイル群で構築可能」

ということ。

FitNesse は約5万行規模なのに、

「典型ファイル長は200行程度」

。

これは絶対ルールではない。

ですが：

「小さいファイルの方が理解しやすい」

傾向はかなり強い。

⸻

新聞メタファー（The Newspaper Metaphor）

優れた新聞記事を想像してほしい。

人は縦に読む。

まず見出し。

それで：

「読む価値ある記事か」

判断する。

最初の段落は概要。

細部は隠しつつ、

「全体像」

を伝える。

下へ進むにつれて：

* 詳細
* 日付
* 名前
* 引用
* 細かい事実

が増えていく。

ソースコードも、そうあるべき。

まずファイル名。

シンプルだが説明的。

名前だけで：

「目的のモジュールか」

分かるべき。

ファイル上部には：

* 高レベル概念
* 大きなアルゴリズム

を書く。

下へ行くほど詳細化。

最後に：

「低レベル実装」

へ到達する。

新聞は大量の記事で構成される。

ほとんどは小さい。

巨大記事は少数。

だから読みやすい。

もし新聞が：

「長大で無秩序な事実・名前・日付の塊」

だったら、誰も読まない。

コードも同じ。


概念間の縦方向の余白（Vertical Openness Between Concepts）

コードは基本的に、

* 左から右
* 上から下

へ読まれる。

1行1行は：

* 式
* 文節

を表し、

行のまとまりは：

「1つの思考単位」

を表す。

そして：

「異なる思考単位は空行で分離すべき」

と著者は言っている。

例えば Listing 5-1 では、

* package 宣言
* import
* 各関数

の間に空行が入っている。

これは単純なルールに見える。

ですが視認性へ大きな影響を与える。

空行は：

「ここから別概念ですよ」

という視覚的シグナルになる。

人の目は、

「空行の次の行」

へ自然に注目する。

⸻

逆に空行を消した Listing 5-2。

すると一気に読みにくくなる。

コード全体が：

「塊」

として潰れて見える。

著者は、

「少し目をぼかして見ると差が顕著」

と言っている。

空行あり：
概念のグループが浮かび上がる

空行なし：
全部ごちゃ混ぜに見える

この差が：

「vertical openness（縦方向の開放感）」

。

かなり本質的な話。

⸻

縦方向の密度（Vertical Density）

空行が概念を分離するなら、

逆に：

「密集」

は、

「強い関連性」

を意味する。

つまり：

「密接に関係するコードは近くに置く」

べき。

例として、

不要コメントが変数同士の関連性を壊しているコードが出てくる。

悪い例：

private String m_className;

（無意味コメント）

private List m_properties

みたいな構造。

コメントのせいで、

「この2変数は同じ概念グループ」

という認知が分断される。

コメント削除版では：

* 2変数
* 1メソッド

が一視野に収まる。

著者はこれを：

「eye-full」

と表現してる。

つまり：

「視線移動なしで理解できる範囲」

。

これめちゃくちゃ重要。

可読性って、

「脳内メモリ消費」

だから。

視線移動が増えるほど：

* 文脈保持コスト
* ワーキングメモリ負荷

が増える。

だから：

「近い概念は物理的にも近く」

が大事。

⸻

縦方向の距離（Vertical Distance）

こんな経験ない？

* 関数Aを見る
* 呼び出し先探す
* スクロール
* また別関数飛ぶ
* 変数定義探す
* 継承元飛ぶ

そのうち：

「何してたっけ？」

になる。

著者は、

これは：

「システム理解ではなく、部品探索に脳を使ってる状態」

と言っている。

つまり：

認知リソースの無駄。

だから：

「密接な概念は縦方向に近づける」

べき。

⸻

変数宣言（Variable Declarations）

ローカル変数は：

「使う場所の近く」

に置く。

Clean Code は関数を小さくする思想だから、

通常は：

「関数冒頭」

にローカル変数を書く。

ループ変数は：

for文内宣言

が理想。

for (Test each : tests)

みたいなやつ。

理由は：

「スコープ最小化」

。

必要範囲だけ存在させる。

⸻

長い関数だけ例外。

その場合：

「使用直前」

に変数を置くこともある。

⸻

インスタンス変数

一方でインスタンス変数は：

「クラス先頭」

に置くべき。

Java文化ではこれが一般的。

昔のC++では：

クラス末尾に置く

流派もあった（scissors rule）。

ですが著者は：

「場所統一の方が重要」

と言ってる。

つまり：

「どこにあるか全員が知ってる」

状態が大事。

⸻

JUnit の悪い例も出てくる。

クラス途中にインスタンス変数が突然現れる。

読む人は：

「偶然見つけるしかない」

。

これはかなり嫌なコード。

⸻

依存関数（Dependent Functions）

関数Aが関数Bを呼ぶなら：

* AとBは近く
* Aを上
* Bを下

に置くべき。

するとコードが：

「上から下への自然な流れ」

になる。

著者はこれをかなり重視してる。

つまり：

高レベル処理
↓
詳細処理
↓
低レベル処理

という構造。

まさに前に出てきた：

「新聞メタファー」

と一致してる。

上は概要。

下へ行くほど詳細。


依存関数（Dependent Functions）

もし関数Aが関数Bを呼ぶなら：

* 2つは近くに置く
* 呼び出す側を上
* 呼び出される側を下

に置くべき。

するとコードに：

「自然な流れ」

が生まれる。

このルールが徹底されると、読者は：

「使われた関数は、この少し下にあるはず」

と信頼できる。

だから探索コストが減る。

⸻

例として WikiPageResponder.java が出てくる。

最上部の：

makeResponse()

が、

* getPageNameOrDefault()
* loadPage()
* notFoundResponse()
* makePageResponse()

を呼ぶ。

さらにその下の関数たちが、
また下の詳細関数を呼ぶ。

つまり：

高レベル
↓
中レベル
↓
低レベル

へ自然に降りていく構造。

これはかなり読みやすい。

⸻

定数を適切なレベルへ置く

著者は途中で面白い話をしてる。

“FrontPage”

という定数。

これを：

getPageNameOrDefault()

内部へ埋め込むこともできた。

ですが著者は：

「それは低レベル関数に重要概念を隠すことになる」

と言っている。

つまり：

「FrontPage を知るべき場所」

と、

「実際に使う場所」

は違う。

だから：

高レベル側から渡す

方が自然。

これかなり本質的。

設定値・ビジネス概念・ルールが、
低レベルユーティリティへ埋まると：

「意味の所在」

が崩れる。

⸻

概念的親和性（Conceptual Affinity）

コードには：

「近くにいたがるコード」

がある。

著者はこれを：

conceptual affinity（概念的親和性）

と呼んでる。

親和性が強いほど、
縦距離を短くすべき。

⸻

親和性の理由は：

* 関数呼び出し
* 同じ変数使用

だけじゃない。

例えば JUnit の：

assertTrue()
assertFalse()

みたいな関数群。

これらは：

* 名前体系
* 役割
* 操作内容

が似ている。

だから近くに置くべき。

たとえ互いに呼び合ってなくても。

つまり：

「意味的まとまり」

も重要。

⸻

縦方向の順序（Vertical Ordering）

基本原則：

「依存は下方向へ流れる」

。

つまり：

呼ばれる関数を下へ置く。

するとソースコード全体が：

高レベル概念
↓
低レベル詳細

へ流れる。

これまた新聞メタファー。

新聞も：

* 上：重要概念
* 下：細部

になっている。

コードも同じ。

最初に：

「何をするモジュールか」

を理解できる。

その後で必要に応じて詳細へ降りる。

だから読者は：

「最初の数関数だけ読んで全体把握」

ができる。

細部へ潜るかは後で決めればいい。

これ実際かなり重要で、

コード読解って：

「どこまで詳細へ入るか制御できる」

ことがめちゃくちゃ大事。


横方向のフォーマット（Horizontal Formatting）

1行はどれくらい長くあるべきか？

著者はいくつかのJavaプロジェクトを分析している。

すると面白いことが分かる。

多くのコードは：

「短い行」

を好んでいる。

特に：

45文字前後

がかなり多い。

80文字超えると急激に減る。

つまりプログラマは本能的に：

「短い横幅」

を好んでいる。

⸻

昔は：

「右スクロール不要」

が有名ルールだった。

80文字制限とか。

今はモニタが巨大だから、
100〜120文字くらいは許容される。

ですが：

「200文字横長コード」

みたいなのはやめろ、

と著者は言ってる。

著者自身は：

120文字上限

くらいにしている。

⸻

横方向の空白と密度（Horizontal Openness and Density）

横方向の空白も意味を持つ。

空白は：

* 関連性を分離
* 優先順位を強調

する。

例えば：

int lineSize = line.length();

代入演算子 = の左右に空白。

これは：

左辺 と 右辺

を視覚的に分離するため。

⸻

逆に：

function(arg)

では、

関数名と ( の間に空白を入れない。

なぜか？

関数と引数は：

「強く結びついている」

から。

空白入れると：

「別物感」

が出る。

⸻

引数間には空白。

function(a, b, c)

これは：

引数同士の分離

を見せるため。

⸻

演算子優先順位の表現

著者は空白で：

「優先順位」

も表現している。

例：

return bb - 4a*c;

ここで：

bb
4a*c

の中には空白がない。

掛け算は結びつきが強いから。

一方：

の前後には空白。

つまり：

「低優先順位演算」

を視覚的に分離している。

かなり美しい考え方。

コードを：

数式として読みやすくする

発想。

⸻

ただし問題もある。

自動フォーマッタは：

演算子優先順位

を理解しない。

なので：

「繊細な空白設計」

は消されがち。

⸻

横方向の整列（Horizontal Alignment）

昔のプログラマは：

変数名や = を縦に揃える

文化があった。

例えば：

private Socket       socket;
private InputStream  input;

みたいなやつ。

著者も昔やってた。

ですが今は否定的。

理由：

「目線がズレる」

から。

⸻

整列すると人は：

型を読まず変数名だけ追う

とか、

= を見ず右辺だけ見る

みたいな読み方になる。

さらに：

自動整形ツールで壊れる。

⸻

著者はいま：

「揃えない」

方を好む。

そして本質的な指摘をする。

もし：

「整列したくなるほど長いリスト」

があるなら、

問題は整列不足ではない。

「クラスがデカすぎる」

可能性が高い。

これかなり鋭い。

つまり：

フォーマット欲求が設計問題を示す

ことがある。

⸻

インデント（Indentation）

ソースコードは：

階層構造

になっている。

* ファイル
* クラス
* メソッド
* ブロック
* ネストブロック

など。

インデントは：

この階層を可視化するため

にある。

⸻

例えば：

クラス内メソッド

は1段右。

if ブロック

はさらに右。

人はインデントをめちゃくちゃ頼りにしている。

左端を見るだけで：

* スコープ
* 構造
* ネスト

を瞬時に理解する。

⸻

著者は：

インデントなしコード

も見せる。

同じコードなのに：

「読むのが地獄」

。

これは実感あると思う。

人間は：

空間配置

で構造理解している。

⸻

インデント省略への誘惑

短い if や短関数を：

1行で潰したくなる

ことがある。

例えば：

if (x) doSomething();

著者は：

毎回あとで戻して直した

と言ってる。

だから最初からやらない。

⸻

悪い例：

public String render() throws Exception {return “”; }

良い例：

public String render() throws Exception {
return “”;
}

。

読みやすさ優先。

⸻

ダミースコープ（Dummy Scopes）

こんなコード：

while (…) ;

末尾セミコロンだけ。

これ超危険。

著者は嫌ってる。

理由：

見落としやすい。

だから避ける。

必要なら：

while (…) {
}

みたいに明示的に書け、

と言ってる。

⸻

チームルール（Team Rules）

ここかなり重要。

著者は：

「個人の好みはある」

と認めてる。

ですが：

チーム開発ではチームルールが優先

。

つまり：

「俺流フォーマット」

は禁止。

⸻

チーム全員で：

* 波括弧位置
* インデント
* 命名

などを統一する。

そして：

IDEフォーマッタへ設定

する。

⸻

著者は面白いこと言ってる。

FitNesse 開発初期、
チームでフォーマットルール決定に：

10分しか使ってない。

でもその後ずっと守った。

しかも：

「自分好みじゃなかった」

。

ですがチームメンバーとして従った。

⸻

最後の話かなり本質。

良いソフトウェアは：

「読みやすい文書群」

。

読者は：

「このフォーマットにはこういう意味がある」

と信頼できるべき。

ファイルごとに文化違うと：

ソースコード自体がノイズ化する。
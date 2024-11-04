import numpy as np

def sigmoid(x):
  return 1 / (1 + np.exp(-x))

def identity_function(x):
  return x

def init_network():
  network = {}
  network['W1'] = np.array([
    [0.1, 0.3, 0.5],
    [0.2, 0.4, 0.6]
  ])
  network['b1'] = np.array([0.1, 0.2, 0.3])
  network['W2'] = np.array([
    [0.1, 0.4],
    [0.2, 0.5],
    [0.3, 0.6]
  ])
  network['b2'] = np.array([0.1, 0.2])
  network['W3'] = np.array([
    [0.1, 0.3],
    [0.2, 0.4]
  ])
  network['b3'] = np.array([0.1, 0.2])

  return network

# フォーワード→入力信号が出力方向への伝達処理←→バックワード(backward)方向
def forward(network, x):
  W1, W2, W3 = network['W1'], network['W2'], network['W3']
  b1, b2, b3 = network['b1'], network['b2'], network['b3']

  a1 = np.dot(x, W1) + b1
  z1 = sigmoid(a1)
  a2 = np.dot(z1, W2) + b2
  z2 = sigmoid(a2)
  a3 = np.dot(z2, W3) + b3
  y = identity_function(a3)
  return y

network = init_network()
x = np.array([1.0, 0.5])
y = forward(network, x)
# print(y)

# 出力層
# 分類問題と回帰問題
# 分類問題→データがどのクラスに属するか（人の写った画像からその人の性別を分類するような問題）
# 回帰問題→入力データから数値を予測する（人の写った画像からその人の体重を予測するような問題）
# 一般的に回帰問題では恒等関数を、分類問題ではソフトマックス関数を使う
# a = np.array([0.3, 2.9, 4.0])
# exp_a = np.exp(a)
# print(exp_a)
# sum_exp_a = np.sum(exp_a)
# print(sum_exp_a)
# y = exp_a / sum_exp_a
# print(y)
# print(np.sum(y))

# def softmax(a):
#   exp_a = np.exp(a)
#   sum_exp_a = np.sum(exp_a)
#   y = exp_a / sum_exp_a
#   return y

# ソフトマックス関数の実装上の注意
# オーバーフロー　指数関数の計算をするので容易に大きな値になる。
# コンピューターで数を扱う場合は有効桁数がある

def softmax(a):
  c = np.max(a)
  exp_a = np.exp(a - c)
  sum_exp_a = np.sum(exp_a)
  y = exp_a / sum_exp_a
  return y

a = np.array([0.3, 2.9, 4.0])
y = softmax(a)
print(y)
print(np.sum(y))

# ソフトマックス関数の出力は0から1.0の間の実数
# 出力の総和は1なので確率と解釈することができる
# この関数を適用しても重みなどと違って各要素の大小関係は変化しない
# 機械学習の問題を解く手順は学習と推論の2つのフェーズに分けられる
# 学習フェーズでモデルの学習を行い、推論フェーズで学習したモデルを使って未知のデータに対して推論（分類）を行う
# 推論フェーズでは出力層のソフトマックス関数は省略するのが一般的
# 出力層にソフトマックス関数を用いる理由は、学習時に関係してくる（後述）

# 出力層のニューロンの数
# 解くべき問題に応じて適宜決める必要がある
# 0から9の数字が書かれた画像を予測するなら10個とか
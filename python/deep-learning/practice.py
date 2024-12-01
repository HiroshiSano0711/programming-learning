
# ゼロから作るDeepLearning １
import numpy as np
import matplotlib.pylab as plt

# パーセプトロン
# 重み（パラメーター）を変えるだけでANDやNAND、ORの回路にできたりする。

# def AND(x1, x2):
#   w1,w2, theta = 0.5, 0.5, 0.7
#   tmp = x1 * w1 + x2*w2
#   if tmp <= theta:
#     return 0
#   elif tmp > theta:
#     return 1

# print(AND(0,0))
# print(AND(1,0))
# print(AND(0,1))
# print(AND(1,1))
# 出力確認OK

# x = np.array([1, 1])
# w = np.array([0.5, 0.5])
# b = -0.7
# print(w*x)               # 配列の各要素同士を乗算する→配列
# print(np.sum(w*x))       # 配列の各要素を総和→decimal
# print(np.sum(w*x) + b)   # バイアスを加える

# バイアスを使った式に書き換え
# def AND(x1, x2):
#   x = np.array([x1, x2])
#   w = np.array([0.5, 0.5])
#   b = -0.7
#   tmp = np.sum(x*w) + b
#   if tmp <= 0:
#     return 0
#   else:
#     return 1

# print(AND(0,0))
# print(AND(1,0))
# print(AND(0,1))
# print(AND(1,1))

# 働きの違いに注意
# w1,w2は入力信号への重要度をコントロールするパラメーターとして機能する
# バイアスは発火のしやすさ（出力信号が１を出力する度合い）を調整するパラメーターとして機能

# def NAND(x1, x2):
#   x = np.array([x1, x2])
#   w = np.array([-0.5, -0.5]) # 重みとバイアスだけがANDと違う
#   b = 0.7
#   tmp = np.sum(x*w) + b
#   if tmp <= 0:
#     return 0
#   else:
#     return 1

# def OR(x1, x2):
#   x = np.array([x1, x2])
#   w = np.array([0.5, 0.5]) # 重みとバイアスだけがANDと違う
#   b = -0.2
#   tmp = np.sum(x*w) + b
#   if tmp <= 0:
#     return 0
#   else:
#     return 1

# AND, NAND, ORは同じ構造のパーセプトロンで重みとバイアスだけが違った

# 単層のパーセプトロンの限界
# XORは1本の直線によって0,1を分ける領域を作ることができない。線形だから
# 直線という制約を外すことができたら分けることができる

def XOR(x1 ,x2):
  s1 = NAND(x1, x2)
  s2 = OR(x1, x2)
  y = AND(s1, s2)
  return y

# print(XOR(0,0))
# print(XOR(1,0))
# print(XOR(0,1))
# print(XOR(1,1))

# NANDの組み合わせでコンピューターも（理論上）実現できる。
# 層を重ねることで非線形のものも表現できる→メリット
# 重みを人間の手で設定する→デメリット

# 入力信号の総和を出力信号に変換する関数→活性化関数
def h(s):
  if s <= 0:
    return 0
  else:
    return 1

def AND(x1, x2):
  x = np.array([x1, x2])
  w = np.array([0.5, 0.5])
  b = -0.7
  return h(np.sum(x*w) + b)

def NAND(x1, x2):
  x = np.array([x1, x2])
  w = np.array([-0.5, -0.5])
  b = 0.7
  return h(np.sum(x*w) + b)

def OR(x1, x2):
  x = np.array([x1, x2])
  w = np.array([0.5, 0.5])
  b = -0.2
  return h(np.sum(x*w) + b)

# パーセプトロン
# 単純パーセプトロン
# 一般的には単層のネットワークで、活性化関数にステップ関数（閾値を境にして出力が切り替わる関数）を使用したモデルを指す
# 多層パーセプトロン
# ニューラルネットワークで、シグモイド関数などの滑らかな活性化関数を使用するネットワークを指す

# ステップ関数（閾値を境にして出力が切り替わる関数）
# def h(s):
#   if s <= 0:
#     return 0
#   else:
#     return 1

# 滑らかな活性化関数
def sigmoid(x):
  return 1 / (1 + np.exp(-x))

def identity_function(x):
  return x

# tmp = 0
# for x in range(1, 300):
#     print(x / 100.0)
#     print(sigmoid(x / 100.0))
#     print(sigmoid(x / 100.0) - tmp)
#     tmp = sigmoid(x / 100.0)

# 〜1.0ぐらい→ xが0.01増えると出力が約0.002増える
# 1.5ぐらい→ xが0.01増えると出力が約0.0015増える
# 2.0ぐらい→ xが0.01増えると出力が約0.001増える
# xが大きくなるほど増加量は減っていく関数

# パーセプトロンとニューラルネットワークの違いは活性化関数だけ
# 多層につながる構造、信号の伝達方法などは基本同じ

# def step_func(x):
#   return np.array(x > 0, dtype=np.int64)

# x = np.arange(-5.0, 5.0, 0.1) # -5.0~5.0まで0.1刻みで配列を生成 
# y = sigmoid(x)
# plt.plot(x, y)
# plt.ylim(-0.1, 1.1)
# plt.show(block=True)

# ReLU関数。xが0より大きいならそのまま出力。0以下なら0を出力
# 活性化関数として主に使われる
# def relu(x):
#   return np.maximum(0, x)

# 3層ニューラルネットワークの実装
# A = XW + B
# W1 一層目の重み
# B1 一層目のバイアス
X = np.array([1.0, 0.5])
W1 = np.array([
  [0.1, 0.3, 0.5],
  [0.2, 0.4, 0.6]
])
B1 = np.array([0.1, 0.2, 0.3])
# print(W1.shape)
# print(X.shape)
# print(B1.shape)

A1 = np.dot(X, W1) + B1

# 第一層の出力Z1
Z1 = sigmoid(A1)
print(A1)
print(Z1)

W2 = np.array([
  [0.1, 0.4],
  [0.2, 0.5],
  [0.3, 0.6]
])
B2 = np.array([0.1, 0.2])
A2 = np.dot(Z1, W2) + B2
Z2 = sigmoid(A2)
print(A2)
print(Z2)

W3 = np.array([
  [0.1, 0.3],
  [0.2, 0.4]
])
B3 = np.array([0.1, 0.2])
A3 = np.dot(Z2, W3) + B3
Y = identity_function(A3)

print(Y) # →[0.31682708 0.69627909]

# → three_network.pyにて実装

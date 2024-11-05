"""
学習に関する基本的な知識
    損失関数
    ミニバッチ
    勾配
    勾配降下法
        ミニバッチからランダムにデータを選んで使用するのは、確率的勾配降下法と呼ばれる

    前提
        ニューラルネットワークは適応可能な重みとバイアスがあり、重みとバイアスを訓練データに適応するように調整することを「学習」と呼ぶ

        ステップ1（ミニバッチ）
            訓練データの中からランダムに一部のデータを選び出す。
            その選ばれたデータをミニバッチといい、ここではそのミニバッチの損失関数の値を減らすことを目的とする
        ステップ2（勾配の算出）
            ミニバッチの損失関数の値を減らすために、各重みパラメータの勾配を求める。
            勾配は、損失関数の値を減らす方向を示す。
        ステップ3（パラメータの更新）
            重みパラメータを勾配方向に微少量だけ更新する
        ステップ4（繰り返す）
            ステップ1,ステップ2,ステップ3を繰り返す
"""

import sys, os
sys.path.append(os.pardir)
import numpy as np
from common.functions import softmax, cross_entropy_error
from common.gradient import numerical_gradient

class simpleNet:
    def __init__(self):
        # W 重みの行列2x3
        # w11 w21 w31
        # w12 w22 w32
        self.W = np.random.randn(2, 3) # ガウス分布で初期化

    def predict(self, x):
        return np.dot(x, self.W)
    
    def loss(self, x, t):
        z = self.predict(x)
        y = softmax(z)
        loss = cross_entropy_error(y, t)

        return loss

net = simpleNet()
# print(net.W)

x = np.array([0.6, 0.9])
p = net.predict(x)
# print(p)

# print(np.argmax(p))

t = np.array([0, 0, 1]) # 正解ラベル
# print(net.loss(x, t))

f = lambda w: net.loss(x, t)

# 重みと損失関数の勾配
dW = numerical_gradient(f, net.W)
print(dW)

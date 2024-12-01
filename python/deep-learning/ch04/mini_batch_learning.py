# coding: utf-8
import sys, os
sys.path.append(os.pardir)
import numpy as np
from dataset.mnist import load_mnist

def mean_squared_error(y, t):
    return 0.5 * np.sum((y - t)**2)

def cross_entropy_error(y ,t):
    if y.ndim == 1:
        t = t.reshape(1, t.size)
        y = y.reshape(1, y.size)
    batch_size = y.shape[0]
    return -np.sum(np.log(y[np.arange(batch_size), t] + 1e-7)) / batch_size

(x_train, t_train), (x_test, t_test) = load_mnist(normalize=True, one_hot_label=True)

train_size = x_train.shape[0]
batch_size = 10
batch_mask = np.random.choice(train_size, batch_size)
x_batch = x_train[batch_mask]
t_batch = t_train[batch_mask]

t = [0, 0, 1, 0, 0, 0, 0, 0 ,0 ,0] # 「2」を正解とする
y = [0.1, 0.05, 0.6, 0.0, 0.05, 0.1, 0.0, 0.1, 0.0, 0.0]
print(cross_entropy_error(np.array(y), np.array(t)))

# 認識精度を指標にするとパラメータの微分がほとんどの場所で０になる
# 少しパラメータをいじっただけでは認識精度は変化しない
# 変化するとしても、33%、34%と飛び飛びになり不連続な急激な変化。
# 損失関数を指標とすれば微小にパラメータを変えても連続的に変化する
# ステップ関数を学習に使うと同じ理由でうまくいかない。０以外の地点では微分は全て０になる。

# coding: utf-8
import sys, os
sys.path.append(os.pardir)  # 親ディレクトリのファイルをインポートするための設定
import numpy as np
import pickle
from dataset.mnist import load_mnist
from common.functions import sigmoid, softmax

def get_data():
    (x_train, t_train), (x_test, t_test) = load_mnist(normalize=True, flatten=True, one_hot_label=False)
    return x_test, t_test


def init_network():
    with open("sample_weight.pkl", 'rb') as f:
        network = pickle.load(f)
    return network


def predict(network, x):
    W1, W2, W3 = network['W1'], network['W2'], network['W3']
    b1, b2, b3 = network['b1'], network['b2'], network['b3']

    a1 = np.dot(x, W1) + b1
    z1 = sigmoid(a1)
    a2 = np.dot(z1, W2) + b2
    z2 = sigmoid(a2)
    a3 = np.dot(z2, W3) + b3
    y = softmax(a3)

    return y


x, t = get_data()
network = init_network()
accuracy_cnt = 0
for i in range(len(x)):
    y = predict(network, x[i])
    p= np.argmax(y) # 最も確率の高い要素のインデックスを取得

    if p == t[i]:
        accuracy_cnt += 1

print("Accuracy:" + str(float(accuracy_cnt) / len(x)))
# → Accuracy:0.9352

"""
    正規化について。normalize=True
    画像の各ピクセルを255で除算して0.0~1.0の範囲に収まるように変換される
    このようなデータをある決まった範囲に変換する処理を正規化という。
    ニューラルネットワークの入力データに対して、なんらかの決まった変換を行うことを前処理という。
    前処理はニューラルネットワークにおいて実践的によく用いられる。
    データ全体の分布を考慮した前処理を行うことが多い。
    データ全体の平均や標準偏差を利用して、データ全体が0を中心に分布するように移動させたり
    データ全体の分布の形状を均一にする（白色化）といったものがある
"""

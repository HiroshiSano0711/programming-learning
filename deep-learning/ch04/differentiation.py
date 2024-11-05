# coding: utf-8
import numpy as np
import matplotlib.pylab as plt
from mpl_toolkits.mplot3d import Axes3D

def numerical_diff(f, x):
    h = 1e-4 # 0.0001
    return (f(x+h) - f(x-h)) / (2*h)

def func_1(x):
    return 0.01*x**2 + 0.1*x
    # 解析的な解
    #   0.02x+0.1
    #   x=5 → 0.2, x=10 → 0.3
    # 数値微分の結果
    #   x=5  → 0.1999999999990898
    #   x=10 → 0.2999999999986347

# print(numerical_diff(func_1, 5))
# print(numerical_diff(func_1, 10))

# x = np.arange(0.0, 20.0, 0.1)
# y = func_1(x)
# plt.xlabel("x")
# plt.ylabel("f(x)")
# plt.plot(x, y)
# plt.show()

def tangent_line(f, x):
    d = numerical_diff(f, x)
    print(d)
    y = f(x) - d*x
    return lambda t: d*t + y

# x = np.arange(0.0, 20.0, 0.1)
# y = func_1(x)
# plt.xlabel("x")
# plt.ylabel("f(x)")

# tf = tangent_line(func_1, 5)
# y2 = tf(x)

# tf = tangent_line(func_1, 10)
# y3 = tf(x)

# plt.plot(x, y)
# plt.plot(x, y2)
# plt.plot(x, y3)
# plt.show()

# f(x, y) = x**2 + y**2のグラフを3Dで表示してみる
# def func_2(x, y):
#     return x**2 + y**2

# x = np.arange(-3, 3.0, 0.1)
# y = np.arange(-3, 3.0, 0.1)

# X, Y = np.meshgrid(x, y)
# Z = func_2(X, Y)

# fig = plt.figure(figsize=(8, 8)) # 図の設定
# ax = fig.add_subplot(projection='3d') # 3D用の設定
# ax.plot_wireframe(X, Y, Z) # ワイヤーフレーム図
# ax.set_xlabel('x') # x軸ラベル
# ax.set_ylabel('y') # y軸ラベル
# ax.set_zlabel('z') # z軸ラベル
# plt.show()

# 勾配
# def func_2(x):
#     return np.sum(x**2)

def _numerical_gradient_no_batch(f, x):
    h = 1e-4
    grad = np.zeros_like(x) # xと同じ形状の配列を生成

    for idx in range(x.size):
        tmp_val = x[idx]
        x[idx] = tmp_val + h
        fxh1 = f(x)

        x[idx] = tmp_val - h
        fxh2 = f(x)

        grad[idx] = (fxh1 - fxh2) / (2*h)
        x[idx] = tmp_val

    return grad

# print(numerical_gradient(func_2, np.array([3.0, 4.0])))
# print(numerical_gradient(func_2, np.array([0.0, 2.0])))
# print(numerical_gradient(func_2, np.array([3.0, 0.0])))

def numerical_gradient(f, X):
    if X.ndim == 1:
        return _numerical_gradient_no_batch(f, X)
    else:
        grad = np.zeros_like(X)
        
        for idx, x in enumerate(X):
            grad[idx] = _numerical_gradient_no_batch(f, x)
        
        return grad


def function_2(x):
    if x.ndim == 1:
        return np.sum(x**2)
    else:
        return np.sum(x**2, axis=1)


x0 = np.arange(-2, 2.5, 0.25)
x1 = np.arange(-2, 2.5, 0.25)
X, Y = np.meshgrid(x0, x1)

X = X.flatten()
Y = Y.flatten()

grad = numerical_gradient(function_2, np.array([X, Y]).T).T

# plt.figure()
# plt.quiver(X, Y, -grad[0], -grad[1], angles="xy",color="#666666")
# plt.xlim([-2, 2])
# plt.ylim([-2, 2])
# plt.xlabel('x0')
# plt.ylabel('x1')
# plt.grid()
# plt.draw()
# plt.show()

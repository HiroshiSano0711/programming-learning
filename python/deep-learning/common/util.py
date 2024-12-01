# coding: utf-8
import numpy as np
import pdb
def smooth_curve(x):
    """損失関数のグラフを滑らかにするために用いる

    参考：http://glowingpython.blogspot.jp/2012/02/convolution-with-numpy.html
    """
    window_len = 11
    s = np.r_[x[window_len-1:0:-1], x, x[-1:-window_len:-1]]
    w = np.kaiser(window_len, 2)
    y = np.convolve(w/w.sum(), s, mode='valid')
    return y[5:len(y)-5]

def im2col(input_data, filter_h, filter_w, stride=1, pad=0):
    # N データの個数
    # C データのチャンネル数（RGB）
    # H データの行数（縦幅）
    # W データの列数（横幅）
    N, C, H, W = input_data.shape

    # // 除算で小数点以下を切り捨てる演算子
    # 割り切れない場合は畳み込みをするときにはみ出してしまうため
    out_h = (H + 2*pad - filter_h)//stride + 1
    out_w = (W + 2*pad - filter_w)//stride + 1

    # [(0,0), (0,0), (pad, pad), (pad, pad)]
    # [(上下に入れる要素),(左右に入れる要素), (上下に入れる要素数), (左右に入れる要素数)]
    img = np.pad(input_data, [(0,0), (0,0), (pad, pad), (pad, pad)], 'constant')

    # 出力サイズの配列を空で生成。N
    col = np.zeros((N, C, filter_h, filter_w, out_h, out_w))

    for y in range(filter_h):
        y_max = y + stride*out_h
        for x in range(filter_w):
            x_max = x + stride*out_w
            # 配列のインデックス指定
            # [:] 全て
            # [i] i番目の要素
            # [i, j] i番目(1次元)のj番目（2次元）の要素（2次元配列）
            # [i, j, k] i番目(1次元)のj番目（2次元）のk番目（3次元）の要素（3次元配列）
            # y:y_max:stride → [start:end:step] スライスによる範囲指定
            # 各チャネルごとにまとめて一度に代入している
            # トリッキーなやり方。出力の高さ、横幅で要素を1次元に並べている
            col[:, :, y, x, :, :] = img[:, :, y:y_max:stride, x:x_max:stride]

    # transpose(0,1,2,3,4,5)
    # 軸を入れ替えたり軸間の演算ができる
    # オペレーターの次元の数だけ「軸」を示す引数を取る
    # 6次元なら(0,1,2,3,4,5)が変更なし
    # col→(N, C, filter_h, filter_w, out_h, out_w)
    # (0,4,5,1,2,3)は、まず出力の形式（out_h→軸4、out_w→軸5）を基準にかえる
    # そしてその内部を（チャンネル数(軸1)、フィルターの縦（軸2）、フィルターの横(軸3)）の３次元に変換
    # 出力の形式に合わせて各データをチャンネルごとでまとめてフィルター形式にしている
    col = col.transpose(0, 4, 5, 1, 2, 3).reshape(N*out_h*out_w, -1)
    return col

def col2im(col, input_shape, filter_h, filter_w, stride=1, pad=0):
    N, C, H, W = input_shape
    out_h = (H + 2*pad - filter_h)//stride + 1
    out_w = (W + 2*pad - filter_w)//stride + 1
    col = col.reshape(N, out_h, out_w, C, filter_h, filter_w).transpose(0, 3, 4, 5, 1, 2)

    img = np.zeros((N, C, H + 2*pad + stride - 1, W + 2*pad + stride - 1))
    for y in range(filter_h):
        y_max = y + stride*out_h
        for x in range(filter_w):
            x_max = x + stride*out_w
            img[:, :, y:y_max:stride, x:x_max:stride] += col[:, :, y, x, :, :]

    return img[:, :, pad:H + pad, pad:W + pad]

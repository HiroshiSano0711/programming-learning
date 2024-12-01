# coding: utf-8
import sys, os
sys.path.append(os.pardir)
import numpy as np
from dataset.mnist import load_mnist
from PIL import Image

def img_show(img):
  pil_img = Image.fromarray(np.uint8(img))
  pil_img.show()

# mnist　有名な数字画像のデータセット
# (訓練画像, 訓練ラベル), (テスト画像, テストラベル)
# normalize → 入力画像を0.0~1.0の値に正規化するかどうかの設定
# flatten →入力画像を平らにする（１次元配列にする）かどうかの設定
(x_train, t_train), (x_test, t_test) = load_mnist(flatten=True, normalize=False)
img = x_train[0]
label = t_train[0]
print(label)
print(img.shape)
img = img.reshape(28, 28)
print(img.shape)
img_show(img)

# coding: utf-8
import sys, os
sys.path.append(os.pardir)
import numpy as np
from common.util import im2col
import pdb

a1 = np.arange(48)
x1 = a1.reshape(1,3,4,4)
# x1 = np.random.rand(1, 3, 7, 7)
col1 = im2col(x1, 2, 2, stride=1, pad=0)
print(x1)
print(col1)
print(col1.shape)

# x2 = np.random.rand(10, 3, 7, 7)
# col2 = im2col(x2, 5, 5, stride=1, pad=0)
# # print(x2)
# # print(col2)
# print(col2.shape)

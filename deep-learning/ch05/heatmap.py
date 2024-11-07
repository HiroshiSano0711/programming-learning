import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np

matrix_2d = np.random.rand(28, 28)

plt.figure(figsize=(28, 28))
sns.heatmap(matrix_2d, annot=True, fmt=".2f", cmap='viridis')
plt.title('2D Matrix Heatmap')
plt.show()

from blueqat import Circuit

# Hゲートの配置
# print(Circuit().h[0])

# # 結果を測定する
# print(Circuit().h[0].m[:])

# # Hゲートを配置し、測定して回路を実行する
# print(Circuit().h[0].m[:].run(shots=100))

# # ２量子重ね合わせを起こす
# print(Circuit().h[0,1].m[:].run(shots=100))
# print(Circuit().h[0].h[1].m[:].run(shots=100))

print(Circuit().h[0].cx[0,1].m[:].run(shots=100))

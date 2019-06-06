def dec2bin(target):
  amari = []

  while target != 0:
    amari.append(target % 2)
    target = target // 2

  amari.reverse()
  return amari

print(dec2bin(26))
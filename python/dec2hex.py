def dec2hex(target):
  amari = []

  while target != 0:
    amari.append(target % 16)
    target = target // 16

  for i in range(len(amari)):
    if amari[i] == 10: amari[i] = 'A'
    elif amari[i] == 11: amari[i] = 'B'
    elif amari[i] == 12: amari[i] = 'C'
    elif amari[i] == 13: amari[i] = 'D'
    elif amari[i] == 14: amari[i] = 'E'
    elif amari[i] == 15: amari[i] = 'F'

  amari.reverse()
  return amari

print(dec2hex(26))
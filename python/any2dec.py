def any2dec(target, m):
  n = len(target) - 1
  sum = 0

  for i in range(len(target)):
    if target[i] == 'A': num = 10
    elif target[i] == 'B': num = 11
    elif target[i] == 'C': num = 12
    elif target[i] == 'D': num = 13
    elif target[i] == 'E': num = 14
    elif target[i] == 'F': num = 15
    else: num = int(target[i])

    sum += (m ** n) * num
    n -= 1
  return sum

print(any2dec('11010', 2))
print(any2dec('1A', 16))
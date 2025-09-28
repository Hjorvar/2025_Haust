n = int(input())
a = sorted(list(map(int, input().split())))
m = int(input())
b = sorted(list(map(int, input().split())))

boy_ptr = 0
girl_ptr = 0
pairs = 0

while boy_ptr < n and girl_ptr < m:
    if abs(a[boy_ptr] - b[girl_ptr]) <= 1:
        pairs += 1
        boy_ptr += 1
        girl_ptr += 1
    elif a[boy_ptr] < b[girl_ptr]:
        boy_ptr += 1
    else:
        girl_ptr += 1

print(pairs)
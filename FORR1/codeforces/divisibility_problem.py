def solve():
    a, b = map(int, input().split())
    remainder = a % b
    if remainder == 0:
        print(0)
    else:
        print(b - remainder)

t = int(input())
for _ in range(t):
    solve()
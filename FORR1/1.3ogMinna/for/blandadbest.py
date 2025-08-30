import sys

n = int(sys.stdin.readline())

if n == 1:
    meat = sys.stdin.readline().strip()
    print(meat)
else:
    for _ in range(n):
        sys.stdin.readline()
    print("blandad best")
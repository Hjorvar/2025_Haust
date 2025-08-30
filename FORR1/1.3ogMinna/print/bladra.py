import sys

v, a, t = map(int, sys.stdin.readline().split())

print(f'{(v * t) + (0.5 * a * (t ** 2)):.4f}')
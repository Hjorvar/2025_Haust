import sys

_ = sys.stdin.readline()
n = int(sys.stdin.readline())

total_chars = 0
dot_count = 0

for _ in range(n):
    line = sys.stdin.readline().strip()
    
    total_chars += len(line)
    dot_count += line.count('.')

if total_chars == 0:
    ratio = 0
else:
    ratio = dot_count / total_chars

print(f'{ratio:.9f}')
import sys

name = sys.stdin.readline().strip()
n = int(sys.stdin.readline())

output_lines = []
line = f'Hipp hipp hurra, {name}!'
for _ in range(n):
    output_lines.append(line)

print("\n".join(output_lines))
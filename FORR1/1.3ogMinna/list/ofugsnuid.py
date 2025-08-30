import sys

n = int(sys.stdin.readline())

numbers = [sys.stdin.readline().strip() for _ in range(n)]

output = '\n'.join(reversed(numbers))

if output:
    print(output)
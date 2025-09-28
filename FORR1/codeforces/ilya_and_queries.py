s = input()
m = int(input())
n = len(s)

prefix_sums = [0] * n

for i in range(n - 1):
    if s[i] == s[i+1]:
        prefix_sums[i+1] = prefix_sums[i] + 1
    else:
        prefix_sums[i+1] = prefix_sums[i]

for _ in range(m):
    l, r = map(int, input().split())
    result = prefix_sums[r-1] - prefix_sums[l-1]
    print(result)
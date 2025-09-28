import bisect

n = int(input())
a = list(map(int, input().split()))
m = int(input())
q = list(map(int, input().split()))

prefix_sums = [0] * n
prefix_sums[0] = a[0]
for i in range(1, n):
    prefix_sums[i] = prefix_sums[i - 1] + a[i]

for worm in q:
    pile_index = bisect.bisect_left(prefix_sums, worm)
    print(pile_index + 1)
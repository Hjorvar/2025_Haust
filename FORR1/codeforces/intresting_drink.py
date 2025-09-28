import bisect

n = int(input())
prices = list(map(int, input().split()))
prices.sort()

q = int(input())
for _ in range(q):
    money = int(input())
    count = bisect.bisect_right(prices, money)
    print(count)
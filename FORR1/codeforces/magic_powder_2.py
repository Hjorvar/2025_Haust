n, k = map(int, input().split())
a = list(map(int, input().split()))
b = list(map(int, input().split()))

def can_make(x):
    magic_powder_needed = 0
    for i in range(n):
        required = a[i] * x
        if required > b[i]:
            magic_powder_needed += required - b[i]
        if magic_powder_needed > k:
            return False
    return True

low = 0
high = 2 * 10**9 + 7
ans = 0

while low <= high:
    mid = (low + high) // 2
    if mid == 0:
        low = mid + 1
        continue
    
    if can_make(mid):
        ans = mid
        low = mid + 1
    else:
        high = mid - 1

print(ans)
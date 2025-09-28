import math

def solve():
    n = int(input())
    a = list(map(int, input().split()))
    
    total_sum = 0
    i = 0
    
    while i < n:
        current_sign = math.copysign(1, a[i])
        block_max = a[i]
        j = i + 1
        while j < n and math.copysign(1, a[j]) == current_sign:
            block_max = max(block_max, a[j])
            j += 1
        
        total_sum += block_max
        i = j
        
    print(total_sum)

t = int(input())
for _ in range(t):
    solve()
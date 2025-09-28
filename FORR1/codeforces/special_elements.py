def solve():
    n = int(input())
    a = list(map(int, input().split()))

    counts = [0] * (n + 1)
    for x in a:
        counts[x] += 1
        
    special_count = 0
    
    for i in range(n):
        current_sum = a[i]
        for j in range(i + 1, n):
            current_sum += a[j]
            if current_sum > n:
                break
            
            if counts[current_sum] > 0:
                special_count += counts[current_sum]
                counts[current_sum] = 0
                
    print(special_count)

t = int(input())
for _ in range(t):
    solve()
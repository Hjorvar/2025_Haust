def solve():
    n = int(input())
    w = sorted(list(map(int, input().split())))
    
    max_pairs = 0
    
    for s in range(2, 2 * n + 1):
        current_pairs = 0
        left = 0
        right = n - 1
        
        while left < right:
            current_sum = w[left] + w[right]
            if current_sum == s:
                current_pairs += 1
                left += 1
                right -= 1
            elif current_sum < s:
                left += 1
            else: # current_sum > s
                right -= 1
        
        max_pairs = max(max_pairs, current_pairs)
        
    print(max_pairs)

t = int(input())
for _ in range(t):
    solve()
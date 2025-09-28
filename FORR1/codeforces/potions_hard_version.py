def solve():
    n = int(input())
    strings = [input() for _ in range(n)]
    string_set = set(strings)
    
    result = []
    for s in strings:
        found = False
        for i in range(1, len(s)):
            prefix = s[:i]
            suffix = s[i:]
            if prefix in string_set and suffix in string_set:
                found = True
                break
        if found:
            result.append('1')
        else:
            result.append('0')
            
    print("".join(result))

t = int(input())
for _ in range(t):
    solve()
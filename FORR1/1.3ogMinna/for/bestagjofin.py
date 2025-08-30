n = int(input())

max_value = -1
winner = ""

for _ in range(n):
    name, gift_str = input().split()
    gift_value = int(gift_str)

    if gift_value > max_value:
        max_value = gift_value
        winner = name

print(winner)
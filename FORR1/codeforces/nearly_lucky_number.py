n = input()
lucky_digits_count = n.count('4') + n.count('7')

if lucky_digits_count == 4 or lucky_digits_count == 7:
    print("YES")
else:
    print("NO")
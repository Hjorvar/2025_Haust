host_name = input()
guest_name = input()
shuffled_pile = input()

combined_names = host_name + guest_name

if sorted(combined_names) == sorted(shuffled_pile):
    print("YES")
else:
    print("NO")
n = int(input())

database = {}

for _ in range(n):
    name = input()
    if name not in database:
        print("OK")
        database[name] = 1
    else:
        count = database[name]
        new_name = name + str(count)
        print(new_name)
        database[name] += 1
        database[new_name] = 1
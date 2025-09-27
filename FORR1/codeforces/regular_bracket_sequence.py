s = input()

open_brackets = 0
valid_length = 0

for char in s:
    if char == '(':
        open_brackets += 1
    elif char == ')' and open_brackets > 0:
        open_brackets -= 1
        valid_length += 2

print(valid_length)

# s = input()
# stack = []

# valid_length = 0

# for char in s:
#     if char == '(':
#         stack.append(char)
#     elif char == ')':
#         if stack:
#             stack.pop()
            
#             valid_length += 2

# print(valid_length)

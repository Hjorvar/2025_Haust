import sys

num = int(sys.stdin.readline())

if num > 0:
    numbers_as_strings = (str(i) for i in range(1, num + 1))
    output = '\n'.join(numbers_as_strings)
    
    sys.stdout.write(output + '\n')
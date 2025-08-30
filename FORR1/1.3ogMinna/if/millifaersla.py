import sys

a = int(sys.stdin.readline())
b = int(sys.stdin.readline())
c = int(sys.stdin.readline())

if a < b and a < c:
    print("Monnei")
elif b < a and b < c:
    print("Fjee")
else:
    print("Dolladollabilljoll")
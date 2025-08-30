import sys

trump = int(sys.stdin.readline())
kim = int(sys.stdin.readline())

if trump > kim:
    print("MAGA!")
elif kim > trump:
    print("FAKE NEWS!")
else: # Þetta er eina tilvikið sem er eftir.
    print("WORLD WAR 3!")
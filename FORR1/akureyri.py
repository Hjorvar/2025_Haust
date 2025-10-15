import sys

# Lesið fyrstu línuna til að fá fjölda lína sem fylgja
try:
    n = int(sys.stdin.readline())
except (IOError, ValueError):
    # Ef línan er tóm eða ekki tala, setjum við n = 0
    n = 0

# Búum til tómt set til að geyma einstök borgarnöfn
unique_cities = set()

# Lesum n línur af inntaki
for _ in range(n):
    # Lesum eina línu, notum .strip() til að fjarlægja
    # aukabil eða línubil í enda
    city = sys.stdin.readline().strip()
    # Bætum borginni við í settið. Ef hún er þegar til,
    # gerist ekkert.
    unique_cities.add(city)

# Prentum út fjölda staka í settinu, sem er svarið okkar
print(len(unique_cities))
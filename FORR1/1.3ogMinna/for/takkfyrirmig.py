import sys

num_guests = int(sys.stdin.readline())

for _ in range(num_guests):
    name = sys.stdin.readline().strip()
    
    sys.stdout.write(f'Takk {name}\n')
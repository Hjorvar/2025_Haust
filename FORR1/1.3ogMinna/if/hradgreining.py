import sys

dna = sys.stdin.readline().strip()

print("Veikur!" if "COV" in dna else "Ekki veikur!")
import sys

target_problem_name = sys.stdin.readline().strip()

num_submissions = int(sys.stdin.readline())

max_score_for_target = 0

for _ in range(num_submissions):
    _, problem_name, score_str, *_ = sys.stdin.readline().split()
    
    if problem_name == target_problem_name:
        score = int(score_str)
        max_score_for_target = max(max_score_for_target, score)

print(max_score_for_target)
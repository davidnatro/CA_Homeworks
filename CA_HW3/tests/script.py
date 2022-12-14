import os

test_result_path = ".test-result.txt"

for i in range(1, 200 + 1):
    os.system(f".././main.exe inputs/input_{i} {test_result_path}")
    with open(test_result_path, "r") as f:
        result = f.read().strip()

    with open(f"outputs/output_{i}", "r") as f:
        expected = f.read().strip()
    print(f"{i}) ", end = ' ')
    print("OK!" if result == expected else "Failed!")

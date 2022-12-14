import os

test_result_file_path = ".test_result.txt"  # Файлы вывода данных "прогона" теста

for i in range(1, 201):
    os.system(f".././main.exe inputs/input_{i} {test_result_file_path}")
    with open(test_result_file_path, "r") as f:
        result = f.read().strip()

    with open(f"outputs/output_{i}", "r") as f:
        expected = f.read().strip()

    print("OK!" if result == expected else "Failed!")

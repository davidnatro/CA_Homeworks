import subprocess
import os

test_result_file_path = ".test_result.txt" # Файлы вывода данных "прогона" теста

input_files = os.listdir("inputs") # Входные данные
output_files = os.listdir("outputs") # Ожидаемые выходные данные

input_files.sort()
output_files.sort()

index = 0

for file_name in input_files:
    isFailed = os.popen(f".././main.exe inputs/{file_name} {test_result_file_path}").read().strip()
    if (isFailed == "Wrong array size!"):
        with open(f"outputs/{output_files[index]}") as f:
            result = f.readline().strip()
            print(result)
            if (result == isFailed):
                print("OK! В прошлом тесте введен некорректный размер массива!")
                index += 1
                continue
    result = ""

    with open(f"{test_result_file_path}", "r") as f:
        result = f.read().strip().split(" ")
    final_output = " ".join(result[1:len(result)])

    expected_output = ""
    with open(f"outputs/{output_files[index]}", "r") as f:
        expected_output = f.readline().strip()
    index += 1

    print("OK!" if final_output == expected_output else "Failed!")

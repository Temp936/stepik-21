target = int(input())

remaining = target
summands = []

for number in range(1, target+1):
    next_num = number + 1

    if (number + next_num) <= remaining:
        summands.append(number)
        remaining -= number
    else:
        summands.append(remaining)
        remaining = 0
        break

print(len(summands))
print(" ".join(str(i) for i in summands))

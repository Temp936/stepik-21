let target = Int(readLine()!)!

var remaining = target
var summands: [Int] = []

for number in 1... {
  let next = number + 1

  if (number + next) <= remaining {
    summands.append(number)
    remaining -= number
  } else {
    summands.append(remaining)
    remaining = 0
    break
  }
}

print(summands.count)
print(summands.map({ String($0) }).joined(separator: " "))

import Foundation

func read2() -> (Int, Int) {
  let line = readLine()!.split(separator: " ")
  let int0 = Int(line[0])!
  let int1 = Int(line[1])!
  return (int0, int1)
}

struct Item {
  let price: Int
  let size: Int
  var partCost: Double {
    return Double(price) / Double(size)
  }
}

let (count, capacity) = read2()
var items: [Item] = []
for _ in 0..<count {
  let (price, size) = read2()
  let item = Item(price: price, size: size)
  items.append(item)
}

items.sort(by: { $0.partCost > $1.partCost })

var remainingCapacity = capacity
var totalPrice: Double = 0
for item in items {
  let partsCount = min(item.size, remainingCapacity)
  remainingCapacity -= partsCount
  totalPrice += Double(partsCount) * item.partCost
}

print(String(format: "%.3f", totalPrice))

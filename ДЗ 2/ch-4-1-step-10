def read2():
    line = input().split()
    int0 = int(line[0])
    int1 = int(line[1])
    return (int0, int1)

class Item:
    def __init__(self, price, size):
        self.price = price
        self.size = size

    @property
    def partCost(self):
        return float(self.price) / float(self.size)

count, capacity = read2()
items = []
for _ in range(count):
    price, size = read2()
    item = Item(price, size)
    items.append(item)

items.sort(key=lambda x: x.partCost, reverse=True)

remainingCapacity = capacity
totalPrice = 0
for item in items:
    partsCount = min(item.size, remainingCapacity)
    remainingCapacity -= partsCount
    totalPrice += float(partsCount) * item.partCost

print("{:.3f}".format(totalPrice))

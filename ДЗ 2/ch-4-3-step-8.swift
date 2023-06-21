struct MaxBinaryHeap {
    var rawData: [Int] = []

    mutating func insert(_ item: Int) {
        self.rawData.append(item)
        self.siftUp(at: self.rawData.endIndex - 1)
    }

    mutating func removeMax() -> Int? {
        guard self.rawData.count > 0 else {
            return nil
        }

        self.rawData.swapAt(0, self.rawData.endIndex - 1)
        let value = self.rawData.removeLast()

        if self.rawData.count > 0 {
            self.siftDown(at: 0)
        }

        return value
    }

    mutating private func siftUp(at index: Int) {
        guard index != 0 else {
            return
        }

        let parentIndex = self.parentIndexUnchecked(for: index)

        if self.value(at: index)! > self.value(at: parentIndex)! {
            self.rawData.swapAt(index, parentIndex)
            self.siftUp(at: parentIndex)
        }
    }

    mutating private func siftDown(at index: Int) {
        let value = self.value(at: index)!

        let children = self.childrenIndexesUnchecked(for: index)
        let leftValue = self.value(at: children.left)
        let rightValue = self.value(at: children.right)

        if leftValue != nil {
            if leftValue! > value {
                if rightValue != nil && rightValue! > leftValue! {
                    self.rawData.swapAt(index, children.right)
                    self.siftDown(at: children.right)
                } else {
                    self.rawData.swapAt(index, children.left)
                    self.siftDown(at: children.left)
                }
            } else if rightValue != nil && rightValue! > value {
                self.rawData.swapAt(index, children.right)
                self.siftDown(at: children.right)
            }
        }
    }

    func value(at rawIndex: Int) -> Int? {
        guard rawIndex < self.rawData.count else {
            return nil
        }

        return self.rawData[rawIndex]
    }

    private func parentIndexUnchecked(for childIndex: Int) -> Int {
        let (quotient, _) = MaxBinaryHeap.logicalIndex(for: childIndex).quotientAndRemainder(dividingBy: 2)
        return MaxBinaryHeap.rawIndex(for: quotient)
    }

    private func childrenIndexesUnchecked(for parentIndex: Int) -> (left: Int, right: Int) {
        let logicalParent = MaxBinaryHeap.logicalIndex(for: parentIndex)

        let logicalLeft = 2 * logicalParent
        let logicalRight = 2 * logicalParent + 1

        let left = MaxBinaryHeap.rawIndex(for: logicalLeft)
        let right = MaxBinaryHeap.rawIndex(for: logicalRight)

        return (left: left, right: right)
    }

    private static func logicalIndex(for rawIndex: Int) -> Int {
        return rawIndex + 1
    }

    private static func rawIndex(for logicalIndex: Int) -> Int {
        return logicalIndex - 1
    }
}

let operationCount = Int(readLine()!)!
var heap = MaxBinaryHeap()

for _ in 0..<operationCount {
    let line = readLine()!.split(separator: " ")

    if line[0] == "Insert" {
        let value = Int(line[1])!
        heap.insert(value)
    } else if line[0] == "ExtractMax" {
        let value = heap.removeMax()!
        print(value)
    }
}

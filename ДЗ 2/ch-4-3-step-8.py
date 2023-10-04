class MaxBinaryHeap:
    def __init__(self):
        self.rawData = []

    def insert(self, item):
        self.rawData.append(item)
        self.siftUp(len(self.rawData) - 1)

    def removeMax(self):
        if len(self.rawData) == 0:
            return None

        #self.rawData[0], self.rawData[-1] = self.rawData[-1], self.rawData[0]
        value = self.rawData.pop()

        if len(self.rawData) > 0:
            self.siftDown(0)

        return value

    def siftUp(self, index):
        if index == 0:
            return

        parentIndex = self.parentIndexUnchecked(index)

        if self.value(index) > self.value(parentIndex):
            self.rawData[index], self.rawData[parentIndex] = self.rawData[parentIndex], self.rawData[index]
            self.siftUp(parentIndex)

    def siftDown(self, index):
        value = self.value(index)

        children = self.childrenIndexesUnchecked(index)
        leftValue = self.value(children[0])
        rightValue = self.value(children[1])

        if leftValue is not None:
            if leftValue > value:
                if rightValue is not None and rightValue > leftValue:
                    self.rawData[index], self.rawData[children[1]] = self.rawData[children[1]], self.rawData[index]
                    self.siftDown(children[1])
                else:
                    self.rawData[index], self.rawData[children[0]] = self.rawData[children[0]], self.rawData[index]
                    self.siftDown(children[0])
            elif rightValue is not None and rightValue > value:
                self.rawData[index], self.rawData[children[1]] = self.rawData[children[1]], self.rawData[index]
                self.siftDown(children[1])

    def value(self, rawIndex):
        if rawIndex >= len(self.rawData):
            return None

        return self.rawData[rawIndex]

    @staticmethod
    def parentIndexUnchecked(childIndex):
        quotient = (childIndex - 1) // 2
        return MaxBinaryHeap.rawIndex(quotient)

    @staticmethod
    def childrenIndexesUnchecked(parentIndex):
        logicalParent = parentIndex + 1

        logicalLeft = 2 * logicalParent
        logicalRight = 2 * logicalParent + 1

        left = MaxBinaryHeap.rawIndex(logicalLeft - 1)
        right = MaxBinaryHeap.rawIndex(logicalRight - 1)

        return (left, right)

    @staticmethod
    def logicalIndex(rawIndex):
        return rawIndex + 1

    @staticmethod
    def rawIndex(logicalIndex):
        return logicalIndex - 1


operationCount = int(input())
heap = MaxBinaryHeap()

for i in range(operationCount):
    line = input().strip().split()

    if line[0] == "Insert":
        value = int(line[1])
        heap.insert(value)
    elif line[0] == "ExtractMax":
        value = heap.removeMax()
        if value is not None:
            print(value)

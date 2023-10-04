class Node:
    def __init__(self):
        self.value = None
        self.left = None
        self.right = None

    def insert(self, value, iterator):
        char = next(iterator, None)
        if char is None:
            self.value = value
        else:
            if char == "0":
                if self.left is None:
                    self.left = Node()
                self.left.insert(value, iterator)
            else:
                if self.right is None:
                    self.right = Node()
                self.right.insert(value, iterator)

    def traverseUntilFound(self, iterator):
        if self.value is not None:
            return self.value
        else:
            char = next(iterator, None)
            if char is None:
                return None

            if char == "0":
                return self.left.traverseUntilFound(iterator)
            else:
                return self.right.traverseUntilFound(iterator)


count = int(input().split()[0])

root = Node()
for _ in range(count):
    line = input()
    char = line[0]
    iterator = iter(line[2:])
    root.insert(char, iterator)

iterator = iter(input())
output = ""
while True:
    char = root.traverseUntilFound(iterator)
    if char is not None:
        output += char
    else:
        break

print(output)

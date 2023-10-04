
class Node:
    def __init__(self, value=None, left=None, right=None, priority=0):
        self.value = value
        self.left = left
        self.right = right
        self.priority = priority

    def encodeAll(self, existingPath=""):
        encodings = {}

        if self.value is not None:
            encodings[self.value] = existingPath
        else:
            if self.left is not None:
                additionalEncodings = self.left.encodeAll(existingPath + "1")
                encodings.update(additionalEncodings)
            if self.right is not None:
                additionalEncodings = self.right.encodeAll(existingPath + "0")
                encodings.update(additionalEncodings)

        return encodings


string = input()

frequencies = {}
for character in string:
    frequencies[character] = frequencies.get(character, 0) + 1

nodes = [Node(value=key, priority=value) for key, value in frequencies.items()]

# Algorithm from https://habr.com/en/post/144200/
# (thanks to comment https://stepik.org/lesson/13239/step/5?discussion=131243&unit=3425)
while len(nodes) > 1:
    nodes.sort(key=lambda x: x.priority, reverse=True)

    left = nodes.pop()
    right = nodes.pop()
    node = Node(
        left=left,
        right=right,
        priority=left.priority + right.priority
    )

    nodes.append(node)

if len(frequencies) != 1:
    encodings = nodes[0].encodeAll()
else:
    encodings = {list(frequencies.keys())[0]: "0"}

encodedString = "".join(encodings[character] for character in string)

print(len(frequencies), len(encodedString))
for character, encoding in encodings.items():
    print("{}: {}".format(character, encoding))
print(encodedString)

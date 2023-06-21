class Node {
    let value: Character?
    let left: Node?
    let right: Node?
    let priority: Int

    init(value: Character? = nil, left: Node? = nil, right: Node? = nil, priority: Int) {
        self.value = value
        self.left = left
        self.right = right
        self.priority = priority
    }

    func encodeAll(prepending existingPath: String = "") -> [Character: String] {
        var encodings: [Character: String] = [:]

        if self.value != nil {
            encodings[self.value!] = existingPath
        } else {
            if self.left != nil {
                let additionalEncodings = self.left!.encodeAll(prepending: existingPath + "0")
                encodings.merge(additionalEncodings, uniquingKeysWith: { value1, _ in value1 })
            }
            if self.right != nil {
                let additionalEncodings = self.right!.encodeAll(prepending: existingPath + "1")
                encodings.merge(additionalEncodings, uniquingKeysWith: { value1, _ in value1 })
            }
        }

        return encodings
    }
}

let string = readLine()!

var frequencies: [Character: Int] = [:]
for character in string {
    frequencies[character] = frequencies[character, default: 0] + 1
}

var nodes = frequencies.map { key, value in
    Node(value: key, priority: value)
}

// Algorithm from https://habr.com/en/post/144200/
// (thanks to comment https://stepik.org/lesson/13239/step/5?discussion=131243&unit=3425)
while nodes.count > 1 {
    nodes.sort { lhs, rhs in
        lhs.priority > rhs.priority
    }

    let left = nodes.popLast()!
    let right = nodes.popLast()!
    let node = Node(
        left: left,
        right: right,
        priority: left.priority + right.priority
    )

    nodes.append(node)
}

var encodings: [Character: String]
if frequencies.count != 1 {
    encodings = nodes[0].encodeAll()
} else {
    encodings = [:]
    encodings[frequencies.first!.key] = "0"
}

var encodedString = ""
for character in string {
    encodedString += encodings[character]!
}

print(frequencies.count, encodedString.count)
for (character, encoding) in encodings {
    print("\(character): \(encoding)")
}
print(encodedString)

class Node {
    var value: Character?
    lazy var left: Node = Node()
    lazy var right: Node = Node()

    func insert(value: Character, with iterator: inout String.Iterator) {
        let char = iterator.next()
        if char == nil {
            self.value = value
        } else {
            if char! == "0" {
                self.left.insert(value: value, with: &iterator)
            } else {
                self.right.insert(value: value, with: &iterator)
            }
        }
    }

    func traverseUntilFound(iterator: inout String.Iterator) -> Character? {
        if self.value != nil {
            return self.value!
        } else {
            let char = iterator.next()
            guard char != nil else {
                return nil
            }

            if char! == "0" {
                return self.left.traverseUntilFound(iterator: &iterator)
            } else {
                return self.right.traverseUntilFound(iterator: &iterator)
            }
        }
    }
}

let count = Int(readLine()!.split(separator: " ")[0])!

var root = Node()
for _ in 0..<count {
    var iterator = readLine()!.makeIterator()
    let char = iterator.next()!
    _ = iterator.next() // skip ":"
    _ = iterator.next() // skip " "
    root.insert(value: char, with: &iterator)
}

var iterator = readLine()!.makeIterator()
var output = ""

while true {
    let char = root.traverseUntilFound(iterator: &iterator)

    if char != nil {
        output.append(char!)
    } else {
        break
    }
}

print(output)

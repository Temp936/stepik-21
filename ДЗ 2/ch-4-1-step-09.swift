// Simpler algorithm figured out from others' solutions.
//
// Given an existing optimal solution...
//
// 0  1  2  3  4  5  6  7  8  9
//          |--+--------o--|
// |-----------o--|     |
//                   |--+-----|
//
// ...notice that, if we move each point to the right bound
// of the segment with the lowest right bound that it is on...
//
// 0  1  2  3  4  5  6  7  8  9
//          |-----+--------o
// |--------------o        |
//                   |-----+--|
//
// ...the solution is still optimal (we didn't increase the
// count of points) and it is still valid:
//     - if a point intersected some other segment, then that other
//       segment:
//         - began earlier or on this (unmoved) point and
//         - ends later than the segment we used for moving (because
//           we used the segment with the lowest right bound),
//       hence the point will still intersect it;
//     - if a point did not intersect some other segment, then it may
//       continue to not intersect it or it may begin intersecting it
//       (both of which are not a problem).
//
// Because of this, we can place the points on right bounds of ranges
// while processing them in 'ascending right bound' order (while not
// placing a new point if the previous one is already contained in
// the current range).

// Input data as given.
let count = Int(readLine()!)!
var ranges: [ClosedRange<Int>] = []
for _ in 0..<count {
    let rangeBounds = readLine()!.split(separator: " ")
    let begin = Int(rangeBounds[0])!
    let end = Int(rangeBounds[1])!
    ranges.append(begin...end)
}

// Sort ranges/segments in ascending order by the right bound
// e.g. [(1...2), (1...3), (2...3), (2...7), (7...9)].
ranges.sort(by: { $0.last! < $1.last! })

// Collect right bounds of ranges, unless the latest right bound
// is already contained in a range.
var points: [Int] = []
for range in ranges {
    if !points.isEmpty && range.contains(points.last!) {
        continue
    }

    points.append(range.last!)
}

// Print the points.
print(points.count)
print(points.map({ String($0) }).joined(separator: " "))

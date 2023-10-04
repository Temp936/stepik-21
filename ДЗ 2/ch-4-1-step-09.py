count = int(input())
ranges = []
for _ in range(count):
    range_bounds = input().split()
    begin = int(range_bounds[0])
    end = int(range_bounds[1])
    ranges.append(range(begin, end))

# Sort ranges/segments in ascending order by the right bound
# e.g. [(1...2), (1...3), (2...3), (2...7), (7...9)].
ranges.sort(key=lambda x: x.stop)

# Collect right bounds of ranges, unless the latest right bound
# is already contained in a range.
points = []
for r in ranges:
    if (len(points)!=0  and r[0] <= points[-1] and points[-1]  <=r[-1]) == False:

        points.append(r.stop)

# Print the points.
print(len(points))
print(" ".join(str(p) for p in points))

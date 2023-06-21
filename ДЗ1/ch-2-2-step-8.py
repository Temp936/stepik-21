# Resources:
# - https://stepik.org/lesson/13228/step/8?discussion=425053&unit=3414
# - Some other comments


def main():
    n, m = map(int, input().split())
    remainders = [0, 1]
    period = None

    for i in range(2, 6 * m + 2):
        remainders.append((remainders[i - 1] + remainders[i - 2]) % m)

        if len(remainders) >= 4 and \
           remainders[len(remainders) - 1] == 1 and \
           remainders[len(remainders) - 2] == 0:
            period = len(remainders) - 2
            break

    print(remainders[n % period])


if __name__ == "__main__":
    main()
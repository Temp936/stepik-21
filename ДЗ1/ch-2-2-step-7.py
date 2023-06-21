a = {
    1: 1,
    2: 1,
}

def main():
    n = int(input())
    for n in range(3, n + 1):
        x = (a[n - 1] + a[n - 2]) % 10
        a[n] = x

    print(a[n])


if __name__ == "__main__":
    main()
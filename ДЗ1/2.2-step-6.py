a = {
    1: 1,
    2: 1,
}

def fib(n):
    if n in a:
        return a[n]
    else:
        x = fib(n - 1) + fib(n - 2)
        a[n] = x
        return x

def main():
    n = int(input())
    print(fib(n))

if __name__ == "__main__":
    main()

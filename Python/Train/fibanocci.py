# Using recursion
# Time Complexity O(2^n)

'''
def fibanocci(n):
    if n <= 1:
        return n

    else:
        return fibanocci(n-1) + fibanocci(n-2)


print(fibanocci(100))

'''

# USing Dynamic Programming - Memoization


def fib(n, cache={}):

    if n < 2:
        return n

    if n in cache:
        return cache[n]

    else:
        cache[n] = fib(n - 1, cache) + fib(n - 2, cache)
        return cache[n]


print(fib(6))

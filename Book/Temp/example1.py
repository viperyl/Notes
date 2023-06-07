def gen(num):
    while num > 0:
        yield num
        num -=1
    return


if __name__ == "__main__":
    # gen(): generator function
    # g: generator object
    g = gen(5)
    first = next(g)
    for i in g:
        print(i)
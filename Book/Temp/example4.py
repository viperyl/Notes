# def double(x):
#     return x * 2


# def triple(x):
#     return x * 3

# def calc_num(func, x):
#     print(func(x))

# calc_num(triple, 3)


# def get_multiple_func(n):
#     def mutiple(x):
#         return n * x
#     return mutiple


# double = get_multiple_func(2)
# triple = get_multiple_func(3)

# print(double(3))
# print(triple(3))



# def dec(f):
#     pass

# @dec
# def double(x):
#     return x * 2

# equivalent to the following
# double = dec(double) 


# def dec(f):
#     return 1

# @dec
# def double(x):
#     return x * 2


# print(double)

# import time
# def timeit(f):
#     def wrapper(*args, **kwargs):
#         start = time.time()
#         ret = f(*args, **kwargs)
#         print(time.time() - start)
#         return ret
#     return wrapper

# @timeit
# def my_func(x):
#     time.sleep(x)

# # my_func(5)

# @timeit
# def other_func(x):
#     return x * 2

# # other_func(2)

# @timeit
# def add_two(x, y):
#     return x + y

# add_two(1,2)



import time
def timeit(iteration):
    def inner(f):
        def wrapper(*args, **kwargs):
            start = time.time()
            for _ in range(iteration):
                ret = f(*args, **kwargs)
            print(time.time() - start)
            return ret
        
        return wrapper
    
    return inner

@timeit(1000)
def double(x):
    return x * 2

double(2)


























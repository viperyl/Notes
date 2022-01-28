## 1. Compiler

|      | C     | C++     | Fortran |
| ---- | ----- | ------- | ------- |
| GNU  | GCC   | g++     | gfortan |
| LLVM | clang | clang++ | flang   |

## 2. Makefile

单文件编译不方便，不利于模块化，工程量大的时候，编译时间很长。

因此多文件编译被提出。

g++ -c hello.cpp -o hello.o

g++ -c hello.cpp -o main.o



自动构建完整的系统。

1. 更新了hello.cpp时，他只更新hello.o
2. 能自动并行地发起对hello.cpp 和main.cpp 的编译 (make -j)



CMake

跨平台的Makefile 解决方案

只需要一份CmakeLists.txt， 就可以自动生成当前系统所支持的构建系统

Cmake 可以自动检测源文件和头文件之间的依赖关系，到处到Makefile里



库

多个可执行文件，他们之间用到的某些功能时相同的，将公用的功能做成库方便共享。

有静态库和动态库。

静态库相当于几那个代码插入到生成的可执行文件中。

动态库则只在生产的可执行文件中生成“插桩”函数，当可执行文件被加载时会读取指定目录中的dll文件，加载到内存中空闲的位置，并且替换相应的“插桩”指向地址为加载后的地址，又叫重定向。



Camke中的静态库和动态库

Add_library 生成库文件

add_library(test STATIC source1.cpp source2.cpp)      libtest.a

add_library(test SHARED source1.cpp source2.cpp)  libtest.so

target_link_libraries(myexec PUBLIC test) 为myexec链接刚刚制作的库libtest.a



为什么需要声明

需要知道函数的参数和返回值类型才能支持重载，隐式转换类型。

头文件－预处理器

对于多个文件都需要同样的函数，则每个文件都需要一个函数声名，避免麻烦所以引入了头文件。此外修改函数的时候，如果没有头文件，当改变函数的输入值类型时，每个文件的声明也都需要改变。

<hello.h>：默认在/usr/include 内查找。

“Hello.h”： 当前目录下寻找，或指定目录

用<> 的地方可以用””， 因为”” 是当前目录优先。



头文件会递归的引用某些类。

如果多个头文件都引用了同一个 Myclass.h， 那么这个类会被重复定义两遍。

解决方法是为头文件加上一行 #programe once

预处理器第二次读到同一个文件时会自动跳过。



第三方库

纯头文件，子模块，系统预安装。

纯头文件需要重复编译。






















































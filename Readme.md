# NanoOS API Docs

## 这是NanoOS的API文档

### 欢迎开发者阅读

> API版本：191229.04
>
> NanoOS适用版本：NanoOS [Blue] Build 19/12/29 Version 191229.04 以及以上

![](https://s2.ax1x.com/2019/12/30/lQDoVK.jpg)

[NanoOS [Blue\] Build 19/12/29 Version 191229.04版本快照]: 

![](https://s2.ax1x.com/2019/12/29/lKFurQ.png)

> 本项目Github地址（暂为Private）：https://github.com/hanbings/NanoOS 

| 函数名     | 原型                                                         |
| ---------- | ------------------------------------------------------------ |
| sendrec(); | *int* sendrec(*int* function, *int* src_dest, MESSAGE* p_msg); |
| printx();  | *int* printx(*char** str);                                   |

| 函数名    | 原型                                                       |
| --------- | ---------------------------------------------------------- |
| memcpy(); | void\* memcpy(void\* es:p_dst, void\* ds:p_src, int size); |
| memset(); | void memset(void\* p_dst, char ch, int size);              |
| strcpy(); | char* strcpy(*char** dst, const *char** src);              |
| strlen(); | *int* strlen(const *char** p_str);                         |

| 函数名    | 原型                                                       |
| --------- | ---------------------------------------------------------- |
| open();   | *int* open    (const *char* *pathname, *int* flags);       |
| read();   | int read   (*int* fd, *void* *buf, *int* count);           |
| write();  | *int* write    (*int* fd, const *void* *buf, *int* count); |
| close();  | *int* close    (*int* fd);                                 |
| unlink(); | *int* unlink   (const *char* *pathname);                   |

| 函数名  | 原型                            |
| ------- | ------------------------------- |
| fork(); | *int* fork    ();               |
| exit(); | *void* exit    (*int* status);  |
| wait(); | *int* wait    (*int* * status); |

| 函数名    | 原型            |
| --------- | --------------- |
| getpid(); | *int* getpid(); |

| 函数名      | 原型                                                         |
| ----------- | ------------------------------------------------------------ |
| printf();   | *int*   printf(const *char* *fmt, ...);                      |
| vsprintf(); | *int*   vsprintf(*char* *buf, const *char* *fmt, va_list args); |
| spin();     | *void* spin(*char* * func_name);                             |

示例程序：（Linux中的echo，这是简化版本）

```c
#include "stdio.h"
int main(int argc, char* argv[])
{
	int i;
 	for (i = 1; i < argc; i++)
 	printf("%s%s", i == 1 ? "" : " ", argv[i]);
 	printf("\n");
 	return 0;
}
```

```
$echo Hello World
Hello World
```

示例编译指令

> 首先您需要确定NDKcore.a确实存在，它位于./lib/NDKcore.a，否则请使用make image编译源代码，再进入./command目录使用make install，而使用make install您必须确保80m.img存在，您也可以修改makeflie

直接进入./command目录使用make install编译应用

END.



**最后，感谢您的耐心阅读和为NanoOS编写软件**



参考书籍：

^《OrangeS:一个操作系统的实现》（于渊）电子工业出版社 2009-6-1 ISBN 9787121084423, 7121084422

^《操作系统设计与实现（第3版）》（Andrew S. Tanenbaum）清华大学出版社出版 2008-5-4 ISBN：9787302172765

^《一个64位操作系统的设计与实现》（田宇）人民邮电出版社  2018-5 ISBN: 9787115475251

^《Intel® 64 and IA-32 Architectures Software Developer Manuals》 （Intel Inc.）2016-10-12
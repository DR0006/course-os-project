# OS

操作系统课程实验

## 作者

* ***Fxx***

- ***[github--@FxDr2003](https://github.com/FxDr2003)***
- ***[CSDN--@Fxx_2003](https://blog.csdn.net/Fx_2003?type=blog)***

## 实验:

### 目录

- [实验三](#实验三)
- [实验四](#实验四)
- [实验五](#实验五)
- [实验六](#实验六)
- [实验七](#实验七)
- [实验八](#实验八)
- [实验九]()
- [实验十](#实验十)

### 实验三

***文件管理系统设计***  

目的与要求：
本设计的目的是通过设计和调试一个简单的文件系统，通过模拟文件操作命令的执行，来模拟文件管理。  
具体要求如下：  
⑴设计一个支持n个用户的文件系统，每个用户可拥有多个文件；  
⑵采用二级或二级以上的多级文件目录管理；  
⑶对文件应设置存取控制保护方式，如“只能执行”、“允许读”、“允许写”等；  
⑷系统的外部特征应接近于真实系统，可设置下述文件操作命令：建立文件、打开文件、关闭文件、删除文件、读文件、写文件、复制文件、查询目录；  
⑸通过键盘使用该文件系统，系统应显示操作命令的执行结果。  


---

### 实验四

> 题干  
> 目的与要求：  
> 本设计的目的是通过设计和调试一个简单请求分页式系统，加深对虚拟存储管理中页面调度算法FIFO、LRU等的理解。具体要求如下：  
> ⑴设计一个模拟请求分页式的系统；  
> ⑵采用FIFO和LRU页面置换算法；  
> ⑶根据输入的页面访问次序，及初始分配的块数，进行模拟；  
> ⑷如果发生页面置换则将置换出的页面显示出来，并显示该页面是否被修改等信息。

```python
PAGE_MEMORY = 4  # 系统可以容纳4个页面
INTERVAL = 1  # 模拟页面的访问时间间隔
print('页面请求序列为 8 9 10 7 0 1 2 0 3 0 4 2 3 0 3 2 1 2 0 1 7 0 1')
```

***分析***

****FIFO****
> FIFO又名先入先出  
> 最先进去的最先出来  
> 8 9 10 7 0 1 2 0 3 0 4 2 3 0 3 2 1 2 0 1 7 0 1  
> 可容纳四个页面  
> 所以先时 8 9 10 7  
> 然后把第一个置换以此类推  
> 9 10 7 0  
> 10 7 0 1  
> 7 0 1 2 。。。。
> 当然已经存在就不用置换了

部分输出结果

```
8 9 10 7 

下一个页面:0
页面0替换旧页面8
旧页面8已被修改
当前页面队列：[9, 10, 7, 0]
页面置换次数： 1 

下一个页面:1
页面1替换旧页面9
旧页面9已被修改
当前页面队列：[10, 7, 0, 1]
页面置换次数： 2 

下一个页面:2
页面2替换旧页面10
旧页面10已被修改
当前页面队列：[7, 0, 1, 2]
页面置换次数： 3 

下一个页面0已在队列中，在队列第2个

下一个页面:3
页面3替换旧页面7
旧页面7已被修改
当前页面队列：[0, 1, 2, 3]
页面置换次数： 4 

下一个页面0已在队列中，在队列第1个

下一个页面:4
页面4替换旧页面0
旧页面0已被修改
当前页面队列：[1, 2, 3, 4]
页面置换次数： 5 

下一个页面2已在队列中，在队列第2个
。。。。。。。。。。。
```

****LRU****  
******又名最近未使用******
> 望词生义我们可以知道，优先选择最近未使用的页面置换出去  
> 我们这里用time来模拟  
> INTERVAL = 1 # 模拟页面的访问时间间隔  
> 8 9 10 7 0 1 2 0 3 0 4 2 3 0 3 2 1 2 0 1 7 0 1  
> 8 9 10 7  
> 然后时 9 10 7 0 - > 10 7 0 1 - >7 0 1 2  
> 此时下一个页面是0 存在列表中 这个时候怎么呢？    
> 当前页面队列：[7, 0, 1, 2]  
> 下一个页面0已在队列中，在队列第2个   
> 当前页面队列：[7, 0, 1, 2]  
> 页面7,时间5   
> 页面0,时间1   
> 页面1,时间3   
> 页面2,时间2   
> 最近未访问的页面:7 所以把7置换出去了  
> 上一个访问的是2 所以页面2时间是2  
> 上上个是页面1 所以时间3  
> 而7是时间最长的，也就是最近未使用的页面，是我们优先置换的，置换出去  
> 后面的道理都一样

部分输出结果

```
LRU:
页面请求序列为 8 9 10 7 0 1 2 0 3 0 4 2 3 0 3 2 1 2 0 1 7 0 1
当前页面队列：[8]
当前页面队列：[8, 9]
当前页面队列：[8, 9, 10]
当前页面队列：[8, 9, 10, 7]
页面8,时间4
页面9,时间3
页面10,时间2
页面7,时间1
最近未访问的页面:8
```

***还有一点需要注意***

```python
"""
根据随机数来判断页面是否修改是为了模拟实际系统中页面的访问和修改行为。
在真实的计算机系统中，页面的修改是由操作系统和应用程序控制的，这取决于具体的使用情况和应用需求。
生成一个随机数来模拟页面的修改情况。当生成的随机数小于0.5时，将页面标记为未修改（False），表示该页面在被访问过程中没有被修改；
当随机数大于等于0.5时，将页面标记为已修改（True），表示该页面在被访问过程中被修改过。
这样做的目的是为了在页面置换算法中引入一定的随机性和变化性。"""

import random


# 页面在访问过程中如果被修改了就需要将其写回磁盘或其他存储介质，以保持数据的一致性


def init(pages):
    for p in pages:
        p['time'] = 0
        p['visited'] = False  # 访问flag
        a = random.random()
        if a < 0.5:
            p['modified'] = False  # 修改flag
        else:
            p['modified'] = True
```

---

### 实验五

【实验报告】基于消息的通讯系统设计

一、实验目的  
本实验旨在通过设计和调试一个基于消息的通讯系统，来实现进程之间的间接通讯，使学生对进程间的通讯机制、进程间的同步机制有一个深入的理解。  
具体目的如下：

1. 理解消息传递系统的设计原理和实现方式。
2. 掌握利用中间实体实现进程间消息交换的方法。
3. 熟悉并使用互斥锁和条件变量等同步机制确保进程间的同步与互斥。

二、实验要求  
根据实验目的，设计一个消息传递系统，满足以下要求：

1. 两进程以消息为单位进行数据交换。
2. 采用间接方式进行消息传递，发送进程将消息发送到中间实体，接收进程从中取得消息。
3. 中间实体能够保留一定数量的消息，例如保留10条消息。
4. 两进程能够保证同步与互斥。

三、实验设计与实现  
在本次实验中，我们设计并实现了一个基于消息的通讯系统，其中包括发送进程和接收进程。  
具体设计与实现如下：

1. 设计消息队列类：MessageQueue类作为中间实体，用于存储消息和实现进程间的消息传递。  
   该类具有以下主要方法：
    - send_message：发送进程调用该方法将消息发送到消息队列中。
    - receive_message：接收进程调用该方法从消息队列中获取消息。
    - get_recent_messages：获取最近十条消息的方法。

2. 设计发送进程：sender_process函数作为发送进程，通过用户输入选择操作，包括发送消息和查看最近十条消息。

3. 设计接收进程：receiver_process函数作为接收进程，通过调用接收消息方法从消息队列中获取消息。

4. 实现同步与互斥：在MessageQueue类中使用**互斥锁和条件变量**，确保发送进程和接收进程的同步与互斥访问。  
   具体包括：
    - 使用互斥锁实现对消息列表的访问互斥。
    - 使用条件变量实现发送进程在消息队列已满时等待，接收进程在消息队列为空时等待。

四、实验结果与分析  
经过设计与实现，我们成功完成了基于消息的通讯系统。实验结果如下：

1. 发送进程和接收进程能够以消息为单位进行数据交换，通过中间实体实现消息的传递。
2. 中间实体可以保留一定数量的消息，如保留10条消息。
3. 发送进程和接收进程通过互斥锁和条件变量

实现了同步与互斥，确保消息队列的安全访问。

通过实验结果分析，我们可以得出以下结论：

1. 基于消息的通讯系统可以有效实现进程间的间接通讯，提供了一种可靠的消息传递机制。
2. 同步与互斥是保证系统正确性和稳定性的重要机制，互斥锁和条件变量等同步机制能够确保进程间的安全访问和正确执行。

五、实验总结  
通过本次实验，我们深入理解了进程间通讯机制和同步机制的重要性，掌握了基于消息的通讯系统的设计与实现方法。  
在实验过程中，我们学习了互斥锁和条件变量的使用，掌握了如何利用这些同步机制确保进程间的同步与互斥。  
实验结果表明，通过合理的设计和实现，基于消息的通讯系统能够有效地实现进程间的数据交换和同步操作。

```

**********************************************************

请选择操作：

1. 发送消息
2. 查看最近十条消息
   1
   请输入要发送的消息：你好
   Fxx发送消息：你好

**********************************************************

请选择操作：

1. 发送消息
2. 查看最近十条消息
   接收方接收到消息：你好
   1
   请输入要发送的消息：我不会
   Fxx发送消息：我不会

**********************************************************

请选择操作：

1. 发送消息
2. 查看最近十条消息
   接收方接收到消息：我不会
   2
   最近十条消息：
   你好
   我不会

**********************************************************

请选择操作：

1. 发送消息
2. 查看最近十条消息
   3
   无效的选择，请重新输入。

**********************************************************

请选择操作：

1. 发送消息
2. 查看最近十条消息

```

-------

### 实验六

动态资源分配系统的设计

目的与要求：

本设计的目的是通过编写和调试一个系统动态分配资源的简单模拟程序，观察死锁产生的条件，并采用适当的算法，有效地防止和避免死锁的发生。具体要求如下：  
⑴模拟一个银行家算法；  
⑵初始化时让系统拥有一定的资源；  
⑶用键盘输入的方式申请资源；  
⑷如果预分配后，系统处于安全状态，则修改系统的资源分配情况；  
⑸如果预分配后，系统处于不安全状态，则提示不能满足请求。

***银行家算法***
> Available（可利用资源向量）：表示系统中当前可用的资源数量。  
> 在安全序列的查找过程中，Available会不断更新，模拟进程执行过程中资源的释放和回收。  
> Allocation（已分配矩阵）：表示当前系统中已经分配给各个进程的资源数量。  
> 在安全序列的查找过程中，Allocation会模拟进程执行过程中的资源分配情况。  
> Need（需求矩阵）：表示各个进程还需要的资源数量。  
> 在安全序列的查找过程中，Need会根据进程执行过程中的资源分配情况进行更新。
>
***理解看下面的运行结果:***

```

Available
[3 3 2]
Max
[[7 5 3]
[3 2 2]
[9 0 2]
[2 2 2]
[4 3 3]]
Allocation
[[0 1 0]
[2 0 0]
[3 0 2]
[2 1 1]
[0 0 2]]
Need
[[7 4 3]
[1 2 2]
[6 0 0]
[0 1 1]
[4 3 1]]
进程 3 满足条件：Need[3] = [0 1 0] <= Available = [3 3 1]
更新 Available: [5 4 3] + [2 1 2] = [5 4 3]
更新 finish[3] = True
更新安全序列: [3]

进程 4 满足条件：Need[4] = [4 3 1] <= Available = [5 4 3]
更新 Available: [5 4 5] + [0 0 2] = [5 4 5]
更新 finish[4] = True
更新安全序列: [3, 4]

进程 1 满足条件：Need[1] = [1 2 2] <= Available = [5 4 5]
更新 Available: [7 4 5] + [2 0 0] = [7 4 5]
更新 finish[1] = True
更新安全序列: [3, 4, 1]

进程 2 满足条件：Need[2] = [6 0 0] <= Available = [7 4 5]
更新 Available: [10  4  7] + [3 0 2] = [10  4  7]
更新 finish[2] = True
更新安全序列: [3, 4, 1, 2]

进程 0 满足条件：Need[0] = [7 4 3] <= Available = [10  4  7]
更新 Available: [10  5  7] + [0 1 0] = [10  5  7]
更新 finish[0] = True
更新安全序列: [3, 4, 1, 2, 0]

***************************************
您输入的请求进程是: 3
您输入的请求资源数: [0 0 1]
系统安全性: 安全
安全序列为: [3, 4, 1, 2, 0]
资源分配情况:
Available: [10  5  7]
Allocation:
[[0 1 0]
[2 0 0]
[3 0 2]
[2 1 2]
[0 0 2]]
Need:
[[7 4 3]
[1 2 2]
[6 0 0]
[0 1 0]
[4 3 1]]
***************************************
您输入的是进程2,
请求资源数:[6 0 0]
[6 0 0] <= [3 3 1]
没有足够的资源可用于满足请求
***************************************
您输入的是进程1,
请求资源数:[1 2 3]
[1 2 3] <= [1 2 2]
请求的资源超过了进程的最大需求资源数
***************************************

进程已结束,退出代码0

```

------

### 实验七

模拟磁盘调度算法系统的设计

目的与要求：
本设计的目的是通过设计一个磁盘调度模拟系统， 以加深对FCFS、最短寻道时间以及电梯等磁盘调度算法的理解。  
具体要求如下：  
⑴模拟一个磁盘调度算法；  
⑵要求能够模拟FCFS、最短寻道时间、电梯算法三个磁盘调度算法；  
⑶输入为一组作业的磁道请求；  
⑷输出为按选择的算法执行时的磁头移动轨迹。

```python
# 选择磁道序列
track_request = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
# 开始位置:50
TRACK_START = 50
```

#### 分析

FCFS:先来先服务按照请求的顺序依次访问磁道


> 访问的磁道序列为: [50, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100]  
> 移动的磁道数为：130  
> 平均移动的磁道数为：13.00


> 很明显啊,先来先服务,先来的是10，开始在50  
> 所以50 --> 10 ->20。。。  
> 50先跑到10 四十距离  
> 再跑到20、30等等、一直跑到100就又跑了90  
> 一加起来就是130

SSTF:最短寻道时间优先

> 访问的磁道序列为: [50, 50, 40, 30, 20, 10, 60, 70, 80, 90, 100]  
> 移动的磁道数为：130  
> 平均移动的磁道数为：13.00

> 最短寻道时间 优先 很明显啊，最短寻道  
> 50开始，而50正好是其中一个 所以50 、50
> 然后 发现 40和 60 都和50 差10  
> 那我随便选择,40  
> 那问题来了，为啥选择40而不选择60？  
> 没啥原因，因为我是遍历数组，40排在60前面就40呗  
> 那么 50 50 40 然后就是30  
> 50 50 40 30 20 10 此时40距离了  
> 然后回到60 是50距离  
> 70 80 90 100 40距离  
> 40+50+40 =130也是130

SCAN: 扫描算法电梯哥
> 访问的磁道序列为: [50, 60, 70, 80, 90, 100, 40, 30, 20, 10]  
> 移动的磁道数为：140  
> 平均移动的磁道数为：14.00

按照一个方向扫描磁道，并在扫描的过程中按照请求的顺序依次访问磁道
> 50开始啊
>
在这种情况下，向增加的方向扫描，SCAN算法将首先访问大于等于50的磁道中最小的磁道。在给定的磁道序列中，大于等于50的最小磁道是60。
> 50 60 70 80 90 100 此时距离为50  
> 然后再回到40 距离为60  
> 30 20 10 距离30  
> 50+60+30 =140

------

### 实验八

模拟作业调度算法系统的设计

目的与要求：

本设计的目的是通过设计一个作业调度模拟系统，以加深对FIFO、短作业优先、优先级优先等作业调度算法的理解。具体要求如下：  
⑴模拟一个作业调度算法；  
⑵要求能够模拟FIFO、短作业优先、优先级三个作业调度算法；  
⑶输入为一组作业到达的时间、服务时间以及优先级；  
⑷输出为按选择的算法执行的调度次序。

#### 示例：

- 作业1：到达时间为0，服务时间为4，优先级为2
- 作业2：到达时间为1，服务时间为3，优先级为1
- 作业3：到达时间为2，服务时间为2，优先级为3
- 作业4：到达时间为3，服务时间为1，优先级为4

#### 分析

```
 *FIFO* 只考虑到达顺序
1. 排序后的作业顺序为：作业1、作业2、作业3、作业4。

2. 按照顺序依次执行作业。
   为 1 ->2 ->3 ->4
```

```
 非抢占
 *SJF* 按照服务时间的短小顺序进行作业调度。
 初始时刻，只有作业1到达，开始执行作业1，执行完毕时刻4
 此时其余三个作业都到达，选择最短的4执行，执行完毕时刻5
 时刻5选择最短的作业3，执行完毕时刻7
 时刻7选择最后一个作业2，执行完毕时刻10
 为 1 ->4 ->3 ->2
```

```
 *Priority*  非抢占 优先级 我规定的是数字越小越高
1. 按照顺序依次执行作业。
 时刻0，作业1到达，开始执行作业1，执行完毕时刻4。
 在作业1运行完成之后，其余作业都到达，选择优先级最高的
 [2,3,4] 中作业2 最高
 时刻4，选择 2 ，完成时间 7
 时刻7 选择 3 ，完成时间 9
 时刻9 选择 4 完成时间 10
 
 为:1 -> 2 -> 3 -> 4
```

#### 输出

```
输出选择的算法: FIFO OR SJF OR Priority
FIFO
调度次序: [1, 2, 3, 4] 

输出选择的算法: FIFO OR SJF OR Priority
SJF
调度次序: [1, 4, 3, 2] 

输出选择的算法: FIFO OR SJF OR Priority
Priority
调度次序: [1, 2, 3, 4] 

```

--------------------------------

### 实验十

同步算法跟踪与验证系统设计

目的与要求：

本设计的目的是通过设计和调试一个简单的同步算法跟踪与验证系统  
使系统在跟踪同步算法的执行路径的同时，验证一个同步算法的正确性。  
要求自己书写一个简单的解释系统  
对至少由两个并发进程组成的系统中进程的同步关系进行跟踪与验证。

### 示例

进程1开始执行时，它会调用 semaphore.acquire() 方法来获取信号量， 此时信号量的计数器值会减少。
由于初始计数器值为1，进程1能够成功获取信号量并继续执行。
而进程2在此时调用 semaphore.acquire() 方法时，
由于计数器值为0，它会被阻塞，直到进程1释放信号量后，才能获得信号量并开始执行。

```
进程 1 正在执行
进程 1 获得了信号量
信号量: 0
进程 1 释放了信号量
信号量: 1
进程 2 正在执行
进程 2 获得了信号量
信号量: 0
进程 2 释放了信号量
信号量: 1
process_1 正确
process_2 正确

进程已结束,退出代码0
```

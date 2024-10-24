---
title: 利用Linux系统开一个Minecraft服务器
tags: 技术分享
id: '30'
date: 2024-01-17 22:01:25
---

**前提提要**

总所不周知（？）

**Windows**的桌面化内存占用相比没有桌面化的系统占用来说会有很多的无用的内存被占用，但目前的中小型的服务商（包括雨云）大多都不会另外带一个没有桌面化系统Windows版本预留。

那为何不使用Linux LiveServer操作系统呢？他并不会有另外的桌面内存占用，游戏服务器也有更多的冗余保持服务器的运行。

**缺点**

其实很明显。

没有了桌面化操作（GNOME）对于新手来说极为不友好。不友好会有这篇文章吗？

那这篇文章就会教会你使用在无桌面环境下开一个Minecraft Paper服务器。

干货警告

没有任何的文章和网站能解决所有问题，遇到问题你应该先去使用搜索引擎搜索。

[KuoHuBit-如何正确选择并使用搜索引擎](https://bot.khbit.cn/question/how-to-search.html)

[USTC-提问的智慧](https://lug.ustc.edu.cn/wiki/doc/smart-questions/)

**新系统最初开始**

**提示**

想必你也看到了，这是基于**Ubuntu**（版本号20.04）而衍生出的文章，若你不是Debian系操作系统（包括Debian、Ubuntu、Kali等任何Debian系分支）请跳转至其他操作系统的初步教学。

连接Linux服务器一般都有一个SSH软件，如果你是**\*\*Windows 10 1809\*\***以上的操作系统，Microsoft内置了SSH Client供你连接SSH服务器

但无论如何都建议你安装一个SSH专业连接软件。

**保命提示（**

以下纯属个人推荐，看你自己如何选择

XShell：

[家庭和学生版](https://www.xshell.com/zh/free-for-home-school/)

[30天专业版（适用于企业）](https://www.xshell.com/zh/xshell-download/)

FinalShell：

[论坛hostbuf免费下载链接](https://www.hostbuf.com/t/988.html)

[官方网站](https://www.finalshell.org/)

**例外**

**Red Hat**系（包括CentOS、Red Hat等任何CentOS系分支）是可以按照此教程照葫芦画瓢完成这个初步教程。

**系统包更新**

一个**GNU/Linux**系统一般都会有一个系统管理包，列如Debian系的系统是apt管理包，但大部分的最新做出更改的系统都不会更新系统管理包列表包， 你第一步做出的应该是更新他的列表包。

`sudo apt-get update`

若你使用的是**Red Hat**分支系统，你应该使用以下命令

`sudo yum update`

**系统依赖**

一般一个游戏服务器都会要求安装一个依赖包，我们一般都可以使用\`apt\`、yum包安装这些依赖。

列如Minecraft的服务器依赖包应该需要以下JRE包

各Minecraft版本可在MCSL Docs中查找

[https://mcsl.com.cn/doc/user/configure-server.html#java%E8%AE%BE%E7%BD%AE](https://mcsl.com.cn/doc/user/configure-server.html#java%E8%AE%BE%E7%BD%AE)

OpenJDK 17

```
sudo apt-get install openjdk-17-jre
```

OpenJDK 8

```
sudo apt-get install openjdk-8-jre
```

**Tips**

一般apt包到一定重量需要你输入\`Y\`以继续安装，你可以加上\`-y\`参数跳过安装，列如这样（apt系演示）

```
sudo apt-get install -y openjdk-8-jre
```

**下载开服核心**

以Paper举例，若你要使用其他的开服核心，寻找他们的官方网站是一个最好的方式，而不是在评论底下瞎bb

访问[Paper团队官方网站](https://papermc.io/)，默认他是给你一个Paper团队最新研发出的新开服核心，但如果你选择老版本，你可以点击底下的 [build explore](https://papermc.io/downloads/all)以选择其他的编译Minecraft版本。

选择好版本之后，右键**Download**选择复制链接，但不是点击下载。

回到服务器当中，输入以下命令（Ubuntu、Windows、CentOS通用）

```
curl -O [url]
```

在\[url\]替换成复制的链接即可。

**番外**

一般大蛇就要说了

啊你为什么不使用wget下载，你是不是不会Linux啊，LLL

提一嘴，是可以使用wget下载，但是在Red Hat系统中，wget一般不会内置在Red Hat系统，反而curl命令是内置的，使用wget也不是不行。

但是我们要保证的是简便，而不是用一个大佬形态看小白傻傻的弄，这种情况下，老馋的你就这么显现出来你不知了。

开启服务器

我们目前已经具备了开服核心和依赖环境。现在仅需简单配置即可。

我的建议是，一定，一定，**一定！！**，创建一个文件夹放置它们。Minecraft服务器会产生大量的文件在文件夹中（也就是\`./\`中），创建文件夹的命令是\`mkdir\`，后面跟上名字即可，同时不建议出现中文字符，尽量是全英文，因为你永远不知道大部分报错可能就是因为你的路径问题。

在此之前，我们需要安装一个`tmux`

```
sudo apt-get install tmux
```

```
sudo yum install tmux
```

这么做就是为了做好一个虚拟窗口，以至于我们关闭SSH窗口连带着Minecraft服务器一起关闭。

虽然网络上已经有了很多tmux使用方式，为此我就简单讲讲（请记得将\[session\]换成其他名称，只能英文）

创建窗口

```
tmux new -t [session]
```

连接目前窗口

```
tmux at -t [session]
```

或者

```
tmux a -t [session]
```

连接至上一个窗口

```
tmux a
```

之后只需要启动服务器即可。那如何启动呢

有一个适用于所有服务器的启动方式，那就是`java -jar [jarname]`（将jarname替换成开服核心名称）

但不建议这么做，所以建议加入`-Xmx`和`-Xmn`参数，具体百度上网搜索，tm别用百度

一般第一次开服务器，会报这个错误

`You need to agree to the EULA in order to run the server. Go to eula.txt for more info.`

这其实就是未同意Mojang的协议，输入以下命令即可

```
sed -i -e 'false' -e 'true' ./eula.txt
```

或者

```
sudo apt-get install nano && nano eula.txt
```

修改false为true，之后按下Ctrl+X保存，回车两次即可。

之后重启服务器即可。

**对于雨云NAT机器**

[雨云论坛- hhjmk](https://forum.rainyun.com/t/topic/5595)

## Linux开服问题

如果遇到开一会就遇到`[killed]`的问题，请尝试将服务端的`-Xmx`的使用降低，尽量低于系统1-2G即可
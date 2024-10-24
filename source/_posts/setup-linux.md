---
title: Linux 小白向：装完Linux之后应该干什么
tags: []
id: '262'
categories:
  - - 技术分享
date: 2024-06-10 23:20:42
---

## 安装完毕最初的登录向导

那玩意真的叫做登录向导吗🤔？

Linux 的发行版有很多，列如 Debian 系。CentOS 系，Arch 系等，最初登录进去的第一步虽然都不一样，但其实大差不差。列如 Debian，大部分人刚进入系统一般都会去更新软件包

```
sudo apt-get update
```

当然，我们作为中国新时代运维选手的一号种子（不是），我们可能因为装不上软件包而抓狂而放弃我们的运维生涯。我们该怎么解决呢？

实际上，国内有很多的镜像源可以选择，列如腾讯云和阿里云，也有高校联合的镜像站。在圈内的高校镜像站比较出名的是 清华大学 TUNA 镜像站。这些大家可以在搜索引擎中搜到他们的切换源。我们以腾讯云源为例。

打开 /etc/apt/source.list 这个文件，你可以使用 VIM 打开，也可以使用 nano 打开这个文件，我们以 nano 为例子。

删除 archive.ubuntu.com 的域名，替换为 mirrors.cloud.tencent.com。按下 Ctrl+X 再按两下回车即可保存退出。当然如果你们高校校内有内网源我肯定是推荐你们使用那个源的，毕竟局域网的速度和公网的速度不是一个量级，且有些学校网络的收费标准还是以公网流量计算的

之后，再运行一次，不出意外的好，大概可能就成功更新了......吧？

部分运气极好的机器可能会因为时间不同导致SSL握手失败，你可以使用 date 命令临时更改下时间。

```
date -d "year-month-day hour:minute:second"
```

这下再运行，应该就不会出现什么原因了。

## 依赖包安装

实际上，这个依旧是因人而异。

我只列出可能默认依赖包没有但我感觉很有必要的（？）一些包

```
sudo apt-get install tmux zip unzip python3 vim htop gcc make openssl
```

tmux: 抽象意义上（？）的一款进程守护。推荐文章：[可能是东半球最全面易懂的 Tmux 使用教程！( 强烈建议收藏 )-腾讯云开发者社区-腾讯云 (tencent.com)](https://cloud.tencent.com/developer/article/1526675)

zip unzip: 这俩老哥我感觉没啥比较讲吧。zip 压缩软件，反之 unzip 就是解压缩 zip 的包。

python3：顾名思义，python软件包，虽然大部分发行包都会预装 python，但我依然建议另外再装一个，大部分的自动化都是以 python 为基础写的。若不想要可以不用装。

vim：对我来说最强的控制台编辑器，但是的教学基本可以出一本书了。。。推荐视频：[vim编辑器的使用\_哔哩哔哩\_bilibili](https://www.bilibili.com/video/BV1vj411172T/?spm_id_from=333.999.0.0)

htop：一款性能监视器。

gcc：编译时要用，你可以当作是c++（？）

make：编译时要用，常用于 make && make install

openssl：编译时要用，一般用于 nginx 的 SSL 模块。
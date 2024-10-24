---
title: Windows 网络验证修改与配置
tags: 技术分享
id: '372'
date: 2024-08-29 08:20:24
---

诶🤓👆变一个网给你

## 先说原理

原理先放这边，以免你听不懂

Windows 验证你的网络可用性一般有两种方式，一种访问 www.msftconnecttest.com 下的 connecttest.txt 文件，另外一种则是 DNS 查询 dns.msftncsi.com 的记录。

那么，我们就可以修改他的查询地址即可给你变一个网出来给你用（×）

若你主要是因为想解决"有网但是Windows显示无网络连接"的问题，请直接跳到"客户端"，并将以下项修改

```
ActiveWebProbeHost => connecttest.ymbit.cn
ActiveWebProbeHostV6 => ipv6.connecttest.ymbit.cn
ActiveDnsProbeHost => dns.connecttest.ymbit.cn
ActiveDnsProbeHostV6 => dns.connecttest.ymbit.cn
```

## 要求

一个服务器（或者能跑网页的都行，你甚至不需要用到服务器，列如使用 Netlify 和 GitHub Pages）

一个 Windows 系统

一个域名（使用中国大陆内的服务器需进行 ICP 备案，具体可看 [阿里云备案文档](https://help.aliyun.com/zh/icp-filing/basic-icp-service/user-guide/icp-filing-application-overview)）

## 服务端配置

服务器中需要开放 80/443 端口，和一个 IPv4/IPv6 公网IP.

服务器内安装 Nginx，若你是 Windows 系统可以尝试使用 IIS 管理 Web 服务器。

Nginx 安装方式可以查看本站下的文章

[使用LNMP（纯环境）创建一个网站 - YanMoBlog (ymbit.cn)](https://blog.ymbit.cn/archives/lnmp_install/)

[LNMP Part 2: 使用编译安装 Nginx - YanMoBlog (ymbit.cn)](https://blog.ymbit.cn/archives/lnmp_install-build-nginx/)

若条件允许，可以尝试部署 SSL 证书。

在 Web 服务器配置内，创建一个名为`connecttest.txt`，这个文件可以随意更改，后期可以在客户端内修改。

在`connecttest.txt`文件内，输入以下文本。

```
Microsoft Connect Test
```

当然，这个文本也可以修改，后期可以在客户端内修改。**但不建议使用中文、Emoji等不支持Unicode字符作为域名、文件、文本的名称**

在一切都做完之后，配置好 Nginx 即可。

## 客户端

在 Windows 系统下打开 regedit 注册表编辑器。

打开以下路径：HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\NlaSvc\\Parameters\\Internet

若你的系统正常且未经过任何修改，应该注册表信息如下为：

![](https://blog.ymbit.cn/wp-content/uploads/2024/08/image-5-1024x536.png)

首先我们需要修改以下信息（分情况）：

若你创建了网站，但未增加除网站的其他 DNS 记录，服务器内没有 IPv6 地址，没有修改上文的文件文本：

```
ActiveWebProbeHost
```

若服务器内拥有 IPv6 地址，且你已经配置Nginx、IIS监听IPv6地址，则需修改：

```
ActiveWebProbeHostV6
```

若修改了文件名：

```
ActiveWebProbePath
ActiveWebProbePathV6 # 在配置了IPv6的情况下，注释不需要输入
```

若修改了文件内的文本：

```
ActiveWebProbeContent
ActiveWebProbeContentV6 # 在配置了IPv6的情况下，注释不需要输入
```

若设置了 DNS 解析：

```
ActiveDnsProbeHost
ActiveDnsProbeHostV6 # 在设置了AAAA记录情况下，注释不需要输入
```

## 关于 DNS 记录

若不需要修改 `ActiveDnsProbeHost` 你可以直接测试是否可用，而不需要继续观看

首先我们需要清楚 `ActiveDnsProbeHost` 和 `ActiveDnsProbeHostV6` 的区别 但似乎不需要区别

`ActiveDnsProbeHost` 主要解析 A 记录，也就是 IPv4 记录，你可以这么填写：

![](https://blog.ymbit.cn/wp-content/uploads/2024/08/image-6.png)

IPv4 地址可以修改，但需要遵守 RFC 的标准，不然无法添加解析。

`ActiveDnsProbeHostV6` 主要解析 AAAA 记录，也就是 IPv6 记录，你可以这么填写：

![](https://blog.ymbit.cn/wp-content/uploads/2024/08/image-7.png)

IPv6 地址可以修改，但仍然需要遵守 RFC 的标准，不然无法添加解析。

之后是关于 `ActiveDnsProbeContent` 和 `ActiveDnsProbeContentV6`，这些就是填写 A 记录和 AAAA 记录内的信息，不然系统无法检测通过。
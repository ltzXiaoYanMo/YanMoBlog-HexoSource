---
title: Tailscale VPN：简便和高效的代名词
tags: 技术分享
id: '323'
date: 2024-07-19 23:48:59
---

## 什么是 VPN？

根据[虚拟专用网 - 维基百科，自由的百科全书 (wikipedia.org)](https://zh.wikipedia.org/wiki/%E8%99%9B%E6%93%AC%E7%A7%81%E4%BA%BA%E7%B6%B2%E8%B7%AF)的说法

**虚拟专用网**（英语：**V**irtual **P**rivate **N**etwork，缩写：**VPN**）将专用网络延伸到公共网络上，使用户能够在共享或公共网络上发送和接收数据，就像他们的计算设备直接连接到专用网络上一样[\[1\]](https://zh.wikipedia.org/wiki/%E8%99%9B%E6%93%AC%E7%A7%81%E4%BA%BA%E7%B6%B2%E8%B7%AF#cite_note-1)。VPN的好处包括增加专用网络的功能、安全性和管理，它提供了对公共网络上无法访问的资源访问通常用于远程办公人员。加密很常见但不是VPN连接的固有部分。[\[2\]](https://zh.wikipedia.org/wiki/%E8%99%9B%E6%93%AC%E7%A7%81%E4%BA%BA%E7%B6%B2%E8%B7%AF#cite_note-2)

VPN是通过使用专用线路或在现有网络上使用隧道协议建立一个虚拟的点对点连接而形成的。可从公共 [Internet](https://zh.wikipedia.org/wiki/%E4%BA%92%E8%81%94%E7%BD%91) 获得的 VPN可以提供[广域网](https://zh.wikipedia.org/wiki/%E5%B9%BF%E5%9F%9F%E7%BD%91)（WAN）的一些好处。 从用户的角度来看，可以远程访问专用网络中可用的资源。[\[3\]](https://zh.wikipedia.org/wiki/%E8%99%9B%E6%93%AC%E7%A7%81%E4%BA%BA%E7%B6%B2%E8%B7%AF#cite_note-3)

## Tailscale 又是什么？

在 [What is Tailscale? Zapier](https://zapier.com/blog/what-is-tailscale/) 中可以看到：

> If you ever listen to podcasts, you've probably heard ads for [VPNs](https://zapier.com/blog/what-is-a-vpn/), or virtual private networks. Or maybe your work has a VPN that you connect to when accessing sensitive data. If you're new to it: these services help protect you by rerouting all your web traffic through their trusted servers. That means you can be online on any [random free Wi-Fi network](https://zapier.com/blog/open-wifi-login-page/) without having to worry about security.

简单意思就是说

> 如果您曾经听过播客，您可能听过 VPN 或虚拟专用网络的广告。或者您的工作单位可能设有 VPN，您可以在访问敏感数据时连接到 VPN。如果您是新手：这些服务会通过其受信任的服务器重新路由您的所有网络流量，从而保护您的安全。这意味着您可以在任何随机的免费 Wi-Fi 网络上网，而不必担心安全问题。

## Tailscale 的付费制度

Tailscale 官方对于 100 实例以下的机子、三位用户（一位所有者，两位协作者）的个人用户免费开放。

## 安装 Tailscale 客户端

Tailscale 官网：[https://tailscale.com/](https://tailscale.com/)

![](https://blog.ymbit.cn/wp-content/uploads/2024/07/QQ_1721401166345-1024x551.png)

在上方有`Download`选项，点击它。

![](https://blog.ymbit.cn/wp-content/uploads/2024/07/QQ_1721401214737-1024x551.png)

根据你的操作系统安装对应的安装包，我们以`Windows`和`Linux`做演示

Windows

点击`Download Tailscale for Windows`按钮，你的系统版本应高于 Windows 10 20H2 及以后的版本，推荐Windows 10 23H1 或 Windows 11 最新稳定版（23H2）

下载之后，双击打开安装包。

![](https://blog.ymbit.cn/wp-content/uploads/2024/07/image.png)

点击`I agree to the license terms and conditions`，之后点击 Install.

若你的电脑开启了 UAC 用户账户控制，请点击"是"以进行下一步安装。

稍等一会应该就会安装完毕。

Linux

将网页上的 Linux 中的代码粘贴到 Terminal 中，也就是

```
curl -fsSL https://tailscale.com/install.sh  sh
```

等待一会即可完成安装。

致中国内地服务器用户：

因`pkgs.tailscale.com`的服务器在国内速度酷似某度网盘，你可以尝试切换国内源：

```
vi /etc/apt/sources.list.d/tailscale.list
```

将`https://pkgs.tailscale.com/`更改为`https://mirrors.locyan.cn/tailscale/`

尝试运行`sudo apt-get update && apt-get install -y tailscale tailscale-archive-keyring`

若在 update 中提示`Mirror sync in progress?`可以不用管，直接进行下一步。

## Tailscale 登录

Tips: Windows 和 Linux 、macOS 都是同样的登录方式

Windows 用户按下`Windows 徽标键 + R`打开运行框，若是 Linux 桌面用户、macOS 用户，在键盘下按下`Ctrl+Alt+T`打开终端，输入以下命令

```
tailscale login
```

若提示`Access denied: prefs write access denied`，Windows 用户请使用管理员方式打开终端，Linux 用户和 macOS 用户请尝试在 tailscale 前面加上 sudo 重新尝试。

Windows 用户可以在通知中心中查看 Tailscale 发送通知，列如：

![](https://blog.ymbit.cn/wp-content/uploads/2024/07/QQ_1721402495323.png)

若是 Linux 用户可在终端中查看登录链接：

![](https://blog.ymbit.cn/wp-content/uploads/2024/07/QQ_1721402644701.png)

登录完成可在终端中看到`Success.`字样即可表示登录成功。

## Tailscale 使用

进入 [https://login.tailscale.com](https://login.tailscale.com) 你可以查看到你登录到此账号下的设备。

![](https://blog.ymbit.cn/wp-content/uploads/2024/07/QQ_1721402796952-1024x822.png)

在`MACHINE`一栏为你的设备，`ADDRESSES` 是 Tailscale 为你分配的 IP 连接信息。你可以点击 Addresses 中的倒三角查看链接地址。

我们演示一下。

假如我的云服务器的 Tailscale 内网 IP 地址是 `100.122.74.123` 我的电脑计算机设备上也安装了 Tailscale 客户端，我在我的云服务器上安装 1Panel 管理面板，端口为 14334。那我们可以用以下方式连接

```
http://100.122.74.123:14334
```

若你认为 IP 记得不方便，你可以回到 Tailscale 界面，看到 Machine 一栏，复制它们的 ID，列如我的云服务器 ID 为 WebServer，我们就可以这么连接

```
http://webserver:14334
```

当然，如果你关闭了`accept-dns`，这种将不会生效。但是你可以放心的是，默认就是开启。

## 致阿里云服务器用户

因为 Tailscale 内网地址段与阿里云内网源地址段相同，这样会导致阿里云源无法使用，你需要运行以下命令以恢复阿里云源且不会导致 Tailscale 关闭

```
sudo tailscale down # 关闭 Tailscale
sudo tailscale up --netfilter-mode=off --accept-dns=false # 打开 Tailscale 并配置 netfilter-mode 和 accept-dns 为关闭
```

## 安装 Tailscale 服务端

本文章不赘述，详细可以查看 Muska AmiのLife

[自建Tailscale DERP服务教程 - 夏沫花火zzz🌙 (Muska\_Ami)のLife (1l1.icu)](https://blog.1l1.icu/2024/04/07/zi-jian-tailscale-derp-fu-wu-jiao-cheng/)

## 为什么说 Tailscale 简便和高效？

因为它善

想象一下，你的网络被你的三大神奇运营商 NAT 过 114514 次的 IP 给了你，或者是你的网络被某些若至盯着扫端口，且有重要项目需要在服务器上开放，你就可以使用 Tailscale 内网打洞连接至服务器，因为 Tailscale 是基于 WireGuard 开发的。

因为这是内网连接，你不需要暴露至公网，也就不需要做一系列的保护以保护项目运行，这不仅简便了我们，也更高效地开发项目，不被攻击者打扰。
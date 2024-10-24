---
title: 'LNMP Part 2: 使用编译安装 Nginx'
tags: 技术分享
id: '199'
date: 2024-05-04 02:59:55
---

## 系统环境

网络上大部分都是使用 CentOS 来编译 Nginx 环境，那我们先说 CentOS 环境编译 Nginx

## 系统依赖包

首先你需要在 CentOS 系统中安装以下软件包：

编译环境：

```
sudo yum -y install gcc gcc-c++
```

http-rewrite pcre软件包（使 nginx 支持 http-rewrite）

```
sudo yum install -y pcre pcre-devel
```

openssl-devel 软件包（使 nginx 支持 SSL）

```
sudo yum install -y openssl openssl-devel
```

zilb 软件包（Nginx 必要）

```
sudo yum install -y zlib zlib-devel gd gd-devel
```

## 下载 Nginx

打开 Nginx 官网（[https://nginx.org](https://nginx.org)）

![](https://api.ymbit.cn/images/lnmp_install/nginx_website.png)

你会看到一个较为简陋的一个官网，这就是 Nginx 官网。点击右侧的 download 链接打开它的下载页

![](https://api.ymbit.cn/images/lnmp_install/nginx_website_download.png)

其中：

Mainline version：开发版本。是 Nginx 官方目录最主力制作的版本，它包含了最新的功能与 Bug 修复。所以这个版本包括一些实验模块，而且它也可能有一些新的bug，因此不建议生产环境使用。

Stable version：稳定版本，是最建议在生产环境中使用的版本。版本中所有的功能可能不是最新的，且仅修复了一些关键性的 bug ，由于这个版本中的功能会优先在 Mainline 版本中测试，所以此版本较为稳定，也推荐用于生产环境。

Legacy version：经典/老旧版本。Nginx 遗留的老版本的稳定版，除非需要适配老的数据需求，一般新生产环境不建议使用。

下载好了对应版本的 Nginx。你可以使用 curl 或是 wget 下载 nginx。

我们以 nginx 1.26.0 stable 版本举例，在终端中可以输入以下命令下载 nginx

```
wget https://nginx.org/download/nginx-1.26.0.tar.gz
```

![](https://api.ymbit.cn/images/lnmp_install/terminal_wget_nginx.png)

当提示`‘nginx-1.26.0.tar.gz’ saved` 时，说明我们已经下载好了 nginx

使用`tar -vxzf nginx-1.26.0.tar.gz`解压 nginx，解压完毕之后进入 nginx 文件夹

之后在终端中输入以下命令进行配置

```
sudo ./configure \
--prefix=/usr/local/nginx \
--pid-path=/var/run/nginx/nginx.pid \
--lock-path=/var/lock/nginx.lock \
--error-log-path=/var/log/nginx/error.log \
--http-log-path=/var/log/nginx/access.log \
--with-http_gzip_static_module \
--http-client-body-temp-path=/var/temp/nginx/client \
--http-proxy-temp-path=/var/temp/nginx/proxy \
--http-fastcgi-temp-path=/var/temp/nginx/fastcgi \
--http-uwsgi-temp-path=/var/temp/nginx/uwsgi \
--http-scgi-temp-path=/var/temp/nginx/scgi \
--with-http_stub_status_module \
--with-http_ssl_module \
--with-file-aio \
--with-http_realip_module
# 在某些情况下 你需要更改配置，但在大部分情况下你不需要更改
```

之后在终端中输入以下命令进行编译

```
sudo make
sudo make install
```

若出现没有 make 可使用以下命令安装

```
sudo yum install make
```

## 大功告成！

成功之后，可以输入`nginx -V`检查 nginx 是否安装完好。

## Debian 的安装

Debian 的安装与 CentOS 大差不差，但最重要的：CentOS 使用的是 yum 安装包（也就是 rpm）而 Debian 是 apt 安装包（deb 安装包）

所以在 Ubuntu 下，我们应该安装依赖的命令是：

```
sudo apt install -y gcc g++ openssl make libpcre3-dev zlib1g-dev
```
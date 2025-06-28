---
title: 在Tor上新建一个网站
date: 2025-06-28 11:34:30
tags: 技术分享
---
## 在 Tor 网络中新建一个网站
观前警告：
> 本文章仅为学习交流，并非为搭建灰黑网站等**中华人民共和国法律所禁止的网站。**
> 
> 若你确实有此需求，请你出门左拐看其他的教程。
### 准备工作
- 存在于环大陆的服务器
- 服务器为 Linux 操作系统，最好为 Debian 系列系统
### 依赖安装
在 Terminal 中输入以下命令
```shell
sudo apt install apt-transport-https
```
安装 TorProject 的 GPG 公钥
```shell
wget -qO- https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --dearmor | sudo tee /usr/share/keyrings/tor-archive-keyring.gpg >/dev/null
```
添加 APT Source 源
```shell
echo "deb     [signed-by=/usr/share/keyrings/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org $(lsb_release -cs) main" | sudo tee -a /etc/apt/sources.list.d/tor.list
echo "deb-src [signed-by=/usr/share/keyrings/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org $(lsb_release -cs) main" | sudo tee -a /etc/apt/sources.list.d/tor.list
```
安装 Tor Server
```shell
sudo apt update
sudo apt install tor deb.torproject.org-keyring
```
一个简单的 Tor 服务器就这么简单做完了
### 配置服务
Tor 的配置服务存放于`/etc/tor/torrc`中，一般情况下，你只需要配置两个设置项
```plaintext
HiddenServiceDir /var/lib/tor/hidden_service/
HiddenServicePort 80 127.0.0.1:80
```
`HiddenServiceDir`申明 Tor Service 配置文件存放路径

`HiddenServicePort`申明 Tor Service 监听的端口和实际监听的端口

如果你用的是 1Panel 开站，你可以新建一个网站，端口设置为非标（80, 443）端口。

创建完成后，前往 网站配置 - 配置文件 中，将 `server_name` 后面的域名更改为`_`
![](./images/create-onion/nginx_config.png)
若你修改完了`/etc/tor/torrc`文件，你可以输入
```shell
service tor restart
```
重新启动 Tor 服务。

查看`service tor status`的运行信息，若显示**running**状态，打开你的 Tor Browser 并尝试连接至 Tor 网络。

连接成功后，你可以查看在`/etc/tor/torrc`中申明的`HiddenServiceDir`目录文件，若成功运行后应该会出现一个叫做`hostname`的文件，
我们 cat 它之后应该会得到一个 .onion 域名，输入进你的 Tor Browser 中，即可访问你的网站。

## 自定义 Onion 域名前缀
我们先知道的 Onion 站点的 hostname 是由公钥生成的，目前 V3 版本的站点长度为 56 长度。
不过你可以使用类似与 HASH 碰撞的方式拿到一个你想要的前缀。

当然，生成的速度依赖你的CPU主频和你的长度。
```shell
git clone https://github.com/cathugger/mkp224o.git # 使用 mkp224o
sudo apt install gcc libc6-dev libsodium-dev make autoconf
cd mkp224o
./autogen.sh
./configure --enable-amd64-51-30k
make
```
假如我们需要一个 hello 的前缀，你可以这么输入
```shell
./mkp224o -d ./result -n 1 -s hello
```
`./result`目录是跑完撞库输出之后的产生的文件存放的目录，你可以自行选择放在哪里。

生成完成后，你就可以移动到`/var/lib/tor/hidden_service/`内并重启 Tor 服务并稍等一会访问测试。

## 申明 Onion 网站
若你的正常网站和 Onion 网站的相同的话，你可以尝试这么宣传。
![](./images/create-onion/show_onion_domain.png)
- 若你的正常网站使用了内容分发网络（CDN），在此之前请查看服务商是否限制了 HTTP-Header
进入Nginx配置文件目录，在`server`块内输入`add_header`，头内容可以参照我的。
```nginx
add_header Onion-Location http://ymbitjzgoubbonj65qs3rcw5g6xqcexldrwpf535kgx4qwrg72oiklyd.onion;
```
如果你的 CDN 是 Cloudflare，你可以在 规则-概述-创建规则 中这么填写
![](./images/create-onion/cloudflare-rules.png)

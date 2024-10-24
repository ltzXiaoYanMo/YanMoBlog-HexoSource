---
title: 如何创建自己的 apt 软件源
tags: 技术分享
id: '410'
date: 2024-09-23 21:14:31
---

## 想法由来

有感而发（？）

这几天不知道干什么好，正好关于自建 apt 的教程少之又少。这篇文章就这么出来了。

文章参考：

[如何创建自己的apt软件源 码农家园](https://www.codenong.com/cs106770248/)

文章"码农家园"因历史悠久，因此利用上方链接搭建 apt 软件源完全无法成功。

## 系统要求

系统：Debian 系操作系统（目前在官网上只有 APT 链接）

硬件要求：CPU1核 内存1G 起步即可。

环境、软件要求：服务器内需要拥有外部连接和Nginx、Apache2等Web服务。

## 软件安装

我们这边使用 aptly 来作为创建 apt 软件源的安装。

打开 aptly 的官网：[aptly - Debian repository management tool](https://www.aptly.info/)

进入官网之后，点击 DOWNLOAD 按钮

![](https://blog.ymbit.cn/wp-content/uploads/2024/09/image-1024x516.png)

我知道你们嫌麻烦或者根本看不懂英文，我在底下贴几行命令你自己装就行。日后不要说是我干的就行

```
sudo apt-get install curl && echo "deb [signed-by=/etc/apt/keyrings/aptly.asc] http://repo.aptly.info/ squeeze main"  sudo tee /etc/apt/sources.list.d/aptly.list && sudo mkdir -p /etc/apt/keyrings; sudo chmod 755 /etc/apt/keyrings && wget -O /etc/apt/keyrings/aptly.asc https://www.aptly.info/pubkey.txt && sudo apt-get update && sudo apt-get install aptly
```

之后一行命令下去之后（这其实已经好几行了xd） 使用你最常用的编辑器编辑`~/.aptly.conf`文件。

这边需要举个例子，列如我们公开访问的地址为`/data/nginx/www`目录

```
{
"rootDir": "/data/nginx/www/"
}
```

之后在输入以下命令创建 apt 空白源

```
aptly repo create stable
```

这个命令将会在`/data/nginx/www`中创建一个创建一个 stable 频道的 APT 源，当然，这个`stable`你可以另外起一个名字，但**一定，一定，一定**不要用**除英文外的所有字符**，具体为什么这里就不说了，你都点开这个博客并且看到了这里你就应该知道为什么。

之后你可以在任意一个地方创建一个目录即可，这个目录将会存放你的`*.deb`文件。

但此刻如果你是看上方参考链接来到的这里的，那你可以选择关闭那个页面了，因为剩下的在现有的版本根本起不了作用。

## 上传安装文件

创建一个新的目录，并且cd进目录，你可以使用任意一个办法把你的deb文件传进去。

之后在文件夹下输入以下命令添加至暂存区

```
aptly repo add stable *.deb
```

之后上传至 APT 源后，我们需要创建一个 GPG 密钥。

## 创建 GPG 密钥

此处文件只会简单阐述，只能确保你能正常创建 GPG 密钥，具体可看 GitHub 文档。

且我强烈建议你在本机创建 GPG，跨环境使用 GPG 密钥会出现无法预想的错误。

[生成新 GPG 密钥 - GitHub 文档](https://docs.github.com/zh/authentication/managing-commit-signature-verification/generating-a-new-gpg-key)

使用以下命令创建 GPG 密钥

```
gpg --full-generate-key
```

一路下一步至输入用户信息，若需要自定义 GPG，请查看 GitHub 文档。

在用户信息中，你需要填写你的用户信息，建议与 deb 安装信息相同。之后输入密码，若你不需要可以不写。

之后在命令行中输入

```
gpg --list-secret-keys --keyid-format=long
```

输入回车后，会显示你 GPG 的基本信息

![](https://blog.ymbit.cn/wp-content/uploads/2024/09/image-1.png)

之后记下 sec 中你 GPG 密钥中的信息，列如我这里是`FDF75529AF497E0974C1FBE2D859A4CADE933693`，那么在命令行中输入

```
gpg --armor --export FDF75529AF497E0974C1FBE2D859A4CADE933693
```

这样就会出现你的 GPG 公钥信息。

![](https://blog.ymbit.cn/wp-content/uploads/2024/09/image-2-1024x935.png)

复制从`-----BEGIN PGP PUBLIC KEY BLOCK-----`到`-----END PGP PUBLIC KEY BLOCK-----`为止，上传至随意一个公钥服务器即可，这边在公开网站查看和测试发现只有 Ubuntu Keyserver 还能在国内正常使用

[OpenPGP Keyserver (ubuntu.com)](https://keyserver.ubuntu.com/)

点击 Submit key 之后，上传你刚刚复制的 GPG 公钥文件即可。

## 上传至公开APT源

输入以下命令上传即可

```
aptly publish repo -distribution=stable -architectures="all" -gpg-key="FDF75529AF497E0974C1FBE2D859A4CADE933693" stable
```

需修改：`-gpg-key`和`-distribution`，若deb文件要求环境要求，也需要修改`-architectures`

回车即可成功上传。

## Nginx 配置

```
server {
        server_name localhost;
        root /data/nginx/www/public;

        location / {
                autoindex on;
                expires 30d;
        }

    listen 80;

}
```

按需修改。

## 如何使用 GitHub Actions 自动上传

这其实没个具体的说法（

你如果确实需要这个需求，你可以查看我这个commits

[ci(publish.yml): Auto push \*.deb to APT Source · Muska-Ami/NyaLCF@25c8163 (github.com)](https://github.com/Muska-Ami/NyaLCF/commit/25c816368e7fffc44908c25f2c5d631b3ad3c66d)

## 客户端配置

在 /etc/apt/source.list.d/中创建一个文件，要求后缀名为`.list`即可

在list文件中输入以下字符

```
deb http://localhost/public stable main
```

若你是使用上方的方式上传你的 GPG 公钥，你可以这么添加。

```
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key 0xd859a4cade933693
```

填写`-recv-key`的方式有很多种，你可以使用 keyserver 给你的标识符，或者 GPG 密钥 ID 都可。

之后使用`apt update`即可正常使用并利用 APT 更新下载

若需要一行命令，你可以自行写一个 SH 源文件，示例可看

[https://apt.nyalcf.1l1.icu/scripts/nyalcf\_install.sh](https://apt.nyalcf.1l1.icu/scripts/nyalcf_install.sh)

写好也可以上传至Web中，之后就可以使用以下命令使用一键安装

```
curl -fsSL https://apt.nyalcf.1l1.icu/scripts/nyalcf_install.sh  bash 
```
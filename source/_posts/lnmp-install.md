---
title: 使用LNMP（纯环境）创建一个网站
tags: 技术分享
id: '177'
date: 2024-05-02 07:53:49
---

## 什么是LNMP？

LNMP是指一组通常一起使用来运行动态网站或者服务器的自由软件名称首字母缩写。L指Linux，N指Nginx，M一般指MySQL，也可以指MariaDB，P一般指PHP，也可以指Perl或Python。

## Linux 安装

目前 Linux 在服务器界最常见的有两个系，一是 Debian 系，还有就是 CentOS 系。

其中，CentOS 在服务器中最出名的是 RHEL，也就是Red Hat Enterprise Linux。但既然都说到了 Enterprise 了，在看看价格

![](https://api.ymbit.cn/images/lnmp_install/redhat_contact.png)

嗯，一看就不是普通用户能用的（

![](https://api.ymbit.cn/images/lnmp_install/centos_download.png)

但是呢，CentOS的源已经差不多死绝了，且大部分的镜像源厂商都没有提供一键切换 CentOS Stream 9 的源了。所以若你是未来要因这个靠这个吃饭，不太建议使用 CentOS ，可以尝试他的同系 RockyLinux。

还有就是 Debian 系了。

这就是我要说的 Debian Linux 系统了——它是完全开源自由的 Linux 系统。

![](https://api.ymbit.cn/images/lnmp_install/debian_why_choose_debian.png)

Debian 还有一个它的亲兄弟，Ubuntu

![](https://api.ymbit.cn/images/lnmp_install/ubuntu_enterprise.png)

Ubuntu 主要面向于企业客户。

但是别慌，Ubuntu 相比 Red Hat 来说，Ubuntu 本身是免费的，Ubuntu Pro 只是他的增值服务。且如果你的镜像是在 Ubuntu 中国站下载，你的管理包源也是在中国大陆，对小白极为友好。

## 什么是 Nginx

这个世界上有一个神奇的引擎，把这个引擎放进服务器的时候，可以实现多种功能。如果我们把这种功能统一用"未知数X"来表示，这个引擎我们可以叫做"Engine X"，也就是 Nginx 的发音。

Nginx (engine x) 是一个高性能的HTTP和反向代理web服务器，同时也提供了IMAP/POP3/SMTP服务。Nginx是由伊戈尔·赛索耶夫为俄罗斯访问量第二的Rambler.ru站点（俄文：Рамблер）开发的，第一个公开版本0.1.0发布于2004年10月4日。其将源代码以类BSD许可证的形式发布，因它的稳定性、丰富的功能集、简单的配置文件和低系统资源的消耗而闻名。

## 什么是 MySQL

MySQL 是一个全球流行的开源数据库。[DB-Engines](https://db-engines.com/en/ranking) 的数据显示，MySQL 在全球最受欢迎的数据库排名中高居第二位，仅次于 [Oracle Database](https://www.oracle.com/cn/database/)。目前，全球访问量最高的流行应用的背后都有 MySQL 的身影，例如 Facebook、Twitter、Netflix、Uber、Airbnb、Shopify 和 Booking.com。

作为一个开源数据库，MySQL 在超过 25 年的发展历程中与全球用户密切合作，推出了众多先进功能，您喜欢的一些应用或编程语言很可能就是由 MySQL Database 提供支持的。

MySQL 的标志是一个海豚，名字叫做 "Sakila"。这个名字是从“海豚命名”竞赛中用户提议的一堆名字中选出来的，是来自非洲斯威士兰的开源软件开发人员 Ambrose Twebaze 提出的。

同时，MySQL 还有个分支，它叫做MariaDB

MariaDB Server 是一个通用的开源关系数据库管理系统。 它是世界上最受欢迎的数据库服务器之一，拥有包括 [Wikipedia](https://wikipedia.org/)、[WordPress.com](https://wordpress.com/) 和 [Google](https://google.com/) 在内的知名用户。 MariaDB Server 在 GPLv2 开源许可下发布，并保证保持开源。

它可用于高可用性事务数据、分析、作为嵌入式服务器，并且广泛的工具和应用程序支持 MariaDB Server。

当 MariaDB Server 的前身 MySQL 于 2009 年被 Oracle 收购时，MySQL 创始人 Michael “Monty” Widenius 出于对 Oracle 管理权的担忧而分叉了该项目，并将新项目命名为 MariaDB。 MySQL 以他的第一个女儿 My 命名，而 MariaDB 则以他的第二个女儿 Maria 命名。这就是 MariaDB 的来历。

大多数原始开发人员加入了新项目，此后 MariaDB Server 继续快速发展。

## 什么是 PHP Python

先说PHP

PHP，全称 Hypertext Preprocessor ，中文翻译“超文本预处理器”

在PHP的官网是这样介绍PHP的

> PHP is a popular general-purpose scripting language that is especially suited to web development.  
> Fast, flexible and pragmatic, PHP powers everything from your blog to the most popular websites in the world.

然后是 Python，它是一种[通用编程语言](https://www.zhihu.com/search?q=%E9%80%9A%E7%94%A8%E7%BC%96%E7%A8%8B%E8%AF%AD%E8%A8%80&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A3281485931%7D)

Python是一种高级编程语言，**它由荷兰人[Guido van Rossum](https://www.zhihu.com/search?q=Guido%20van%20Rossum&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A3281485931%7D)于1989年创建**。Python的设计哲学强调**代码的可读性和简洁性**，尤其是使用空格缩进划分代码块，而不是使用大括号或关键字。

Python的一个主要特点是它的语法简单明了，易于学习，这使得它成为初学者和专业人士的理想选择。

并且Python的一句名言是：**“人生苦短，我用Python。”** 这句话强调了Python语言简洁、易读的特点，使得开发者能够更高效地编写代码。

## 安装 LNMP

Linux：自行百度（

Nginx

你可以使用软件包安装 Nginx，这是最简单一种方式，你可以使用以下方式安装它：

Debian：

```
sudo apt-get install nginx
```

CentOS：

```
sudo yum install nginx
```

有些情况下，你还需要输入以下命令更新源：

Ubuntu：

```
sudo apt-get update
```

CentOS：

```
sudo yum update
```

MySQL

和 Nginx 一样，你可以使用以下方式安装它：

Debian：

```
sudo apt-get install mysql-server
```

CentOS：

```
sudo yum install mysql-server
```

PHP

我们如法炮制，使用管理包安装它：

Debian：

```
sudo apt-get install php
```

CentOS：

```
sudo yum install php
```

Python

Debian：

```
sudo apt-get install python3
```

CentOS：

```
sudo yum install python3
```

如果安装的包有软件要求，可以在 python 后添加大版本号安装 Python，例如

```
sudo apt-get install python3.12
sudo yum install python3.12
```

## 配置 LNMP

这里主要以配置 Nginx 为主。

进入`/etc/nginx`目前，你会看到`nginx.conf`这个文件，它里面的信息应该为以下这些

```
user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
        worker_connections 768;
        # multi_accept on;
}

http {

        ##
        # Basic Settings
        ##

        sendfile on;
        tcp_nopush on;
        types_hash_max_size 2048;
        # server_tokens off;

        # server_names_hash_bucket_size 64;
        # server_name_in_redirect off;

        include /etc/nginx/mime.types;
        default_type application/octet-stream;

        ##
        # SSL Settings
        ##

        ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3; # Dropping SSLv3, ref: POODLE
        ssl_prefer_server_ciphers on;

        ##
        # Logging Settings
        ##

        access_log /var/log/nginx/access.log;
        error_log /var/log/nginx/error.log;

        ##
        # Gzip Settings
        ##

        gzip on;

        # gzip_vary on;
        # gzip_proxied any;
        # gzip_comp_level 6;
        # gzip_buffers 16 8k;
        # gzip_http_version 1.1;
        # gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;

        ##
        # Virtual Host Configs
        ##

        include /etc/nginx/conf.d/*.conf;
        include /etc/nginx/sites-enabled/*;
}


#mail {
#       # See sample authentication script at:
#       # http://wiki.nginx.org/ImapAuthenticateWithApachePhpScript
#
#       # auth_http localhost/auth.php;
#       # pop3_capabilities "TOP" "USER";
#       # imap_capabilities "IMAP4rev1" "UIDPLUS";
#
#       server {
#               listen     localhost:110;
#               protocol   pop3;
#               proxy      on;
#       }
#
#       server {
#               listen     localhost:143;
#               protocol   imap;
#               proxy      on;
#       }
#}
```

这就是 Nginx 的配置文件，我们不讲这里面都是些什么。因为如果讲这些，还不如让你去看官方文档（

在服务器上创建一个文件夹，我以`/var/nginx/www`为例子。在服务器上上输入以下命令：

```
sudo mkdir /var/nginx/www
sudo chown -R nginx:nginx /var/nginx/www
find /var/nginx/www -type d -exec chmod 755 {} \;
find /var/nginx/www -type f -exec chmod 644 {} \;
```

接下来，在`/var/nginx/www`中创建一个文件，我们可以在终端中输入：

```
sudo touch /var/nginx/www/index.php
sudo nano /var/nginx/www/index.php
```

这样，我们就使用了 nano 打开了主程序文件夹 index.php，我们可以在这个文件中输入以下代码检测是否可用。

```
<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

echo '<h1 style="text-align: center;">欢迎使用 PHP！</h1>';
echo '<h2>版本信息</h2>';

echo '<ul>';
echo '<li>PHP版本：', PHP_VERSION, '</li>';
echo '</ul>';

echo '<h2>已安装扩展</h2>';
printExtensions();

/**
 * 获取已安装扩展列表
 */
function printExtensions()
{
    echo '<ol>';
    foreach (get_loaded_extensions() as $i => $name) {
        echo "<li>", $name, '=', phpversion($name), '</li>';
    }
    echo '</ol>';
}
?>
```

最后，我们回到`/etc/nginx/nginx.conf`中，在 events 块嵌入 server 块，例如这样

```
server{
listen 80;
server_name blog.ymbit.cn;

root /var/nginx/www
index  index.php index.html index.htm;
}
```

注意：server\_name 后面需要跟上自己域名，若是在云服务器可使用服务器公网 IP，本地电脑可使用 localhost.

## 大功告成！

我们已经编写完了一个 PHP 网站，但是我们需要重载 nginx 服务才可正常访问，在服务器中输入以下命令：

```
sudo nginx -t    # 检查 nginx.conf 编写是否正确
sudo nginx -s reload    # 若提示 successful，则就直接重载服务
```

现在，可以传入例如 WordPress 等任何你想搭建的服务了！
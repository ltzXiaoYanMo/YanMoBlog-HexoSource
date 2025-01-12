---
title: 使用 Rclone 上传到 Amazon S3 协议的对象存储
date: 2025-01-12 13:05:17
tags: 技术分享
---

## Amazon S3 协议
我们可以查看 [AWS中国](https://docs.amazonaws.cn/s3/) 的文档概述可以了解到

Amazon Simple Storage Service（Amazon S3）是一种对象存储服务，提供行业领先的可扩展性、数据可用性、安全性和性能。各种规模和行业的客户都可以使用 Amazon S3 存储和保护任意数量的数据，用于数据湖、网站、移动应用程序、备份和恢复、归档、企业应用程序、IoT 设备和大数据分析。Amazon S3 提供了管理功能，使您可以优化、组织和配置对数据的访问，以满足您的特定业务、组织和合规性要求。

而且 Amazon S3 在 2006 年就已经推出，所以许多云厂商使用此协议。

## Rclone
很显然，这主要作为一个备份文件所产出来的软件，据他们所说：
> Rclone是一个命令行程序，用于管理云存储上的文件。它是云供应商Web存储接口的功能丰富的替代品。超过70种云存储产品支持rclone，包括S3对象存储、企业和消费者文件存储服务以及标准传输协议。

### 下载与使用
## 下载 Rclone
可以从 [Rclone](https://rclone.org/downloads/) 下载，选择适合的操作系统的安装包。

但 Rclone 的软件主要以命令行操作，你可以使用 [Windows Terminal](https://www.microsoft.com/zh-cn/p/windows-terminal/9n0dx20hk701?rtc=1&activetab=pivot:overviewtab) 来使用 Rclone.

### Windows
将下载的 Rclone 存储至 `C:\Windows\System32` 下，然后打开 Terminal 输入 `rclone` 即可使用。
### Linux
将下载的 Rclone 存储至 `/usr/bin` 下，然后在 bash 下输入 `rclone` 即可使用。
### MacOS
将下载的 Rclone 存储至 `/usr/local/bin` 下，然后在 zsh 下输入 `rclone` 即可使用。

## 使用 Rclone
我们使用 Cloudflare R2 作为对象存储，~~因为我没有其他支持S3的对象存储了~~
在 Terminal 下输入`rclone config`配置 rclone.
![](./images/upload-to-amazon-s3-protocol-using-rclone/rclone_config.png)
输入 `n` 新增一个 new remote.
![](./images/upload-to-amazon-s3-protocol-using-rclone/rclone_new.png)
在`name >`中写一个名字，列如我写 Cloudflare-R2.

在`Storage >`中选择`4`, 也就是`Amazon S3 Compliant Storage Providers`（亚马逊S3协议）
![](./images/upload-to-amazon-s3-protocol-using-rclone/rclone_choose_storages.png)
然后在 `provider >`中选择`6`, 也就是`Cloudflare R2 Storage`
![](./images/upload-to-amazon-s3-protocol-using-rclone/rclone_choose_providers.png)
在`env_auth`中选择`1`, 我们要选择`Enter AWS credentials in the next step.`（在下一步中输入AWS凭据。）

在输入`access_key_id`中我们需要前往 Cloudflare Dashboard.

在此之前，你需要创建一个存储桶：<https://developers.cloudflare.com/r2/get-started/>

创建完毕后，前往 `API - 管理 API 令牌`, 创建 API 令牌即可: <https://developers.cloudflare.com/r2/api/s3/tokens/>

将上面的令牌填入 Rclone 即可
![](./images/upload-to-amazon-s3-protocol-using-rclone/rclone_successful.png)

## Sync
Rclone 本质上还是同步文件，所以上传文件我们使用`rclone sync`命令.
```bash
rclone sync /data/syncfolder Cloudflare-R2:/syncfolder
```
也可以使用`rclone copy`命令将一个存储桶同步至其他桶，列如
```bash
rclone copy Aliyun-OSS:/syncfolder Cloudflare-R2:/syncfolder
```
Windows 下可以挂载至本地盘符：
```bash
rclone mount Cloudflare-R2:/syncfolder D:
```
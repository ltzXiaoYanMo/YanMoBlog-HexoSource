---
title: 在 Windows Home 版本中启动 Hyper-V 功能
tags: []
id: '353'
categories:
  - - 技术分享
date: 2024-08-08 19:48:01
---

新建文件夹，将它的后缀改为 cmd

cmd 文本内的字符的如下：

```
pushd "%~dp0"

dir /b %SystemRoot%\servicing\Packages\*Hyper-V*.mum >hyper-v.txt

for /f %%i in ('findstr /i . hyper-v.txt 2^>nul') do dism /online /norestart /add-package:"%SystemRoot%\servicing\Packages\%%i"

del hyper-v.txt

Dism /online /enable-feature /featurename:Microsoft-Hyper-V-All /LimitAccess /ALL
```

右键以管理员方式运行 cmd 文件，安装完毕重启电脑即可。
---
title: 将 Steam 令牌导入至 Bitwarden
date: 2025-10-12 19:33:27
tags: 技术分享
---

## 将 Steam 令牌导入至 Bitwarden
### 准备工作
1. 安装 Watt Toolkit（下载地址：<https://apps.microsoft.com/detail/9mtcfhs560ng?hl=zh-cn&gl=CN>）
2. 你目前的移动设备绑定过 Steam 令牌
3. Bitwarden（VaultWarden）
### 获取 Steam 令牌 secretId
在 Watt Toolkit 中添加你的 Steam 令牌（本地令牌 - 新增）

如何导入就看你有什么方式导入了。个人建议是使用 Steam App 共存导入。

在绑定之前，先在 Steam App 中移除验证器（Authenticate - 右下角设置 - 移除验证器）

移除之后进行登录，Steam 将会在邮箱内发送验证码，验证就行。

验证完之后，重新打开 Steam App，在 Steam App 中重新添加 Steam 令牌，确认 Steam 恢复代码能和 Watt Toolkit 对的上之后，输入 Steam 令牌就可以添加至 Watt Toolkit。

在你的 Watt Toolkit 绑定的 Steam 账号中，点击三个点，导出为 maFile 文件，随便选个地方即可，打开这个 maFile 文件，找到`"uri"`这个键，找到后面的`secret`将后面所有的文字到`\u`为止， 你应该会得到有 32 个字母的的 Steam 密钥，在前面添加`steam://`之后导入至 Bitwarden，然后再看一眼 Steam App 上的 Steam TOTP 密钥是不是一样的，一样的则不用管啥，若不一样可以多尝试几次，或等它几分钟看看（？）



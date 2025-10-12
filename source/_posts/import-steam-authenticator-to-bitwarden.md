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

在你的 Watt Toolkit 绑定的 Steam 账号中，点击三个点，导出为 maFile 文件，随便选个地方即可，打开这个 maFile 文件，打开之后找到`"shared_secret"`这个键，复制他对应的值，随便找一个 base64 转 base32 网站，或者用 Python 实现。
```python
import base64


def base64_to_base32(base64_string):
    decoded_bytes = base64.b64decode(base64_string)
    base32_encoded = base64.b32encode(decoded_bytes)
    return base32_encoded.decode('ascii')

base64_input = input("请输入 Base64 输入: ")
if len(base64_input) > 1:
    result = base64_to_base32(base64_input)
    print("Base32 结果: ", result)
else:
    print("请提供 Base64 字符串作为参数")
```
将获得的base32在前面添加`steam://`导入至Bitwarden，列如`steam://homo114514==`，若你使用其他的 TOTP 验证器也支持 Steam 的 TOTP 格式，也可以这么使用。

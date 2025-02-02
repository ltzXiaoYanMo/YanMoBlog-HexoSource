---
title: 腾讯云Nodejs SDK体积庞大导致被骂
date: 2025-02-02 16:34:08
tags: 杂谈
---

### 发生什么事了？
![](https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AA1yfJsP.img?w=768&h=1760&m=6)
* 图片来源:IT之家

~~为什么不是我自己截图因为我懒得截~~

这几天，腾讯云发布了他们Nodejs版本的4.0包，但是一个包却占用了100多MB，知道的这是SDK包，不知道的还以为是把UE塞里面了。

之后官方人员发出回复：
![](https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AA1yfSFy.img?w=768&h=235&m=6)
![](https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AA1yfXSD.img?w=768&h=383&m=6)

说真的，要不是他们回复了我还真不知道有分包这东西...

![](images/TencentCloud-NodeJS-issue/issue66_reply.png)

## 疑似使用 GitHub Mobile 写 Markdown
他们 Markdown 也是不会用的那种。
![](https://private-user-images.githubusercontent.com/115706851/408804136-e07f9d8c-fdee-4331-a42c-6d6343856f9c.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Mzg0ODYwNjEsIm5iZiI6MTczODQ4NTc2MSwicGF0aCI6Ii8xMTU3MDY4NTEvNDA4ODA0MTM2LWUwN2Y5ZDhjLWZkZWUtNDMzMS1hNDJjLTZkNjM0Mzg1NmY5Yy5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjAyJTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIwMlQwODQyNDFaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT00Y2QzNzBjMGY2MWE4OTc3MjRjYTEwZmQzYjUzOTUxNTljMGIzMTlkNGM0YjAyYTk4MzUxNjhkZjA2OGI4MWJlJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.Bi7ybWcMVFMiL0QZJrmqYFPJLkmOLGCx1Pc0YxYTMRc)

### 难绷的一集
<https://github.com/TencentCloud/tencentcloud-sdk-nodejs/pull/169>

> 你们那还缺工作么？能不能远程办公？如果腾讯开发者这种水平，我能不能上来混口饭吃啊？
> —— PR Author

![](./images/TencentCloud-NodeJS-issue/tg_channel.png)

最后祝大家新年快乐！也祝腾讯云的开发者新年快乐！

~~似乎有点晚了，说真他们也挺惨过年还要被骂还得改代码公关~~
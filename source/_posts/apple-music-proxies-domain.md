---
title: 为 Apple Music 部分域名添加代理规则
date: 2026-02-18 21:31:03
tags: 技术分享
---
规则
```list
# Self Upload Music
- DOMAIN-SUFFIX,downloaddispatch.itunes.apple.com
# Apple Podcasts & Radio
- DOMAIN-SUFFIX,itsliveradio.apple.com
# Apple Device Certificate for Podcasts & Radio
- DOMAIN-SUFFIX,aodp-ssl.apple.com
# TeleVision & Movie Trailer
- DOMAIN-SUFFIX,video-ssl.itunes.apple.com
# iTunes Store
- DOMAIN-SUFFIX,hls-amt.itunes.apple.com
- DOMAIN-SUFFIX,homesharing.itunes.apple.com
# iCloud
- DOMAIN-SUFFIX,cabana-server.cdn-apple.com
```


`downloaddispatch.itunes.apple.com`虽然在境内有部署服务器，但是自传音乐还是访问缓慢，所以切换海外。不需要可以删除

`cabana-server.cdn-apple.com`似乎是同步 Apple Music 资料库同步至 iCloud 域名，且解析在海外。
![*.cdn-apple.com](./images/apple-music-proxies-domain/_.cdn.apple.com.png)

`homesharing.itunes.apple.com`和`hls-amt.itunes.apple.com`本身是 iTunes Store 的服务，Apple 在国内没有提供这项服务，见仁见智。

---
title: 主站内的第三方开放服务
date: 2026-06-30 17:26:35
---
# 主站内的第三方开放服务
主站在站内中使用了**天气**和**IP地址**的排版选项。

## 天气
主站只显示了**地级市**、**温度**、**天气情况**，调用方式为
```http request
https://ymbit.cn/api/weather/today
```
默认以访问用户的 IP 地址显示信息，主要有
- ip (发起请求的公网 IP 地址)
- province (所在省份)
- city (所在城市)
- adcode (行政区划代码)
- weather (当前天气状况)
- temperature (温度)
- winddirection (风向)
- windpower (风力等级)
- humidity (相对湿度)
- reporttime (天气数据的发布或获取时间)

数据来自于[高德地图](https://amap.com)

数据示例：
```json
{
  "ip": "xxx.xxx.xxx.xxx",
  "province": "北京市",
  "city": "北京市",
  "adcode": "330300",
  "weather": "阴",
  "temperature": "30",
  "winddirection": "东南",
  "windpower": "≤3",
  "humidity": "75",
  "reporttime": "2026-06-XX XX:XX:XX"
}
```
## IP地址
主站只有显示IP地址，但不仅只有这些。
```http request
https://ymbit.cn/api/ip/location
```
默认以访问用户的 IP 地址显示信息，主要有
- ip (客户端直连 IP)
- country / countryCode (国家名称与代码)
- region / regionName (省份/地区简码与名称)
- city (城市名称)
- zip (邮政编码)
- lat / lon (纬度与经度坐标)
- timezone (所属时区)
- isp (网络服务供应商)
- org (组织机构名称)
- as (自治系统号)
- query (实际用于发起查询的公网 IP)

数据示例：
```json
{
  "ip": null,
  "country": "中国",
  "countryCode": "CN",
  "region": "BJ",
  "regionName": "北京",
  "city": "北京市",
  "zip": "100000",
  "lat": 39.9042,
  "lon": 116.407,
  "timezone": "Asia/Shanghai",
  "isp": "联通",
  "org": "",
  "as": "AS4837 CHINANET",
  "query": "xxx.xxx.xxx.xxx"
}
```
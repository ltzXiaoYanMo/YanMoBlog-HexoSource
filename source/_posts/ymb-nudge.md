---
title: YanMoBit的戳一戳回应是怎么实现的？
tags: 技术分享
id: '78'
date: 2024-01-22 02:35:32
---

我们先来看Mirai Console Loader日志

```
2023-07-30 20:44:55 V/Bot.1373892821: Event: NudgeEvent(from=NormalMember(2315049216), target=Bot(1373892821), subject=Group(904464532), action=戳了戳, suffix=)
```

别看很乱，其实我们仅需要看Event冒号后面的记录：NudgeEvent

```
@channel.use(ListenerSchema(listening_events=[NudgeEvent]))
```

接着，我们需要让Python知道让截取哪个BotQQ账号，那下一行就是输入

```
async def nudge(app: Ariadne, event: NudgeEvent): # 使用async异步处理这条消息
```

即可完成戳一戳截取
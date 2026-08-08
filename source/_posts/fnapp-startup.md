---
title: 飞牛快速脚手架：如何快速制作一个飞牛App
date: 2026-08-05 10:01:51
tags: 技术分享
---
此类专门作为喜欢tl;dr（太长不看）的人看，亦或者想为做飞牛app的做skill，你不妨试试把这个文章喂给AI看看他能不能自己做成skill
## 快速入门
飞牛OS内置初始化Application CLI，他叫`fnpack`
<https://developer.fnnas.com/docs/cli/fnpack/>
主要用法为：
创建一个普通项目（直接运行至宿主机，包含桌面入口）
```shell
fnpack create <appname>
```
创建一个 Docker 项目
```shell
fnpack create <appname> --template docker
```
创建不包含桌面入口的服务类项目：
```shell
fnpack create <appname> --without-ui true
```
你也可以做成不包含入口的Docker项目
```shell
fnpack create <appname> --template docker --without-ui true 
```
## 主体框架
创建完项目后，一般情况下是以下的树型结构
```
/var/apps/{appname}
├── cmd/
│   ├── install_init
│   ├── install_callback
│   ├── main
│   ├── upgrade_init
│   ├── upgrade_callback
│   ├── uninstall_init
│   ├── uninstall_callback
│   ├── config_init
│   └── config_callback
├── config/
│   ├── privilege
│   └── resource
├── manifest
├── ICON.PNG
├── ICON_256.PNG
├── target -> /vol{n}/@appcenter/{appname}
├── etc    -> /vol{n}/@appconf/{appname}
├── var    -> /vol{n}/@appdata/{appname}
├── tmp    -> /vol{n}/@apptemp/{appname}
├── home   -> /vol{n}/@apphome/{appname}
├── meta
├── shares/
└── wizard/
    ├── install
    ├── upgrade
    ├── uninstall
    └── config
```
看着很多？我们可以先把重要的拆开
### 应用目录与文件说明

| 目录/文件                       | 主要作用                                                           |
|:--------------------------------|:-------------------------------------------------------------------|
| **`cmd/`**                      | 存放生命周期管理脚本（包含安装、升级、卸载、运行控制及配置回调）。 |
| **`config/`**                   | 存放应用配置声明文件（如 `privilege` 权限、`resource` 资源控制）。 |
| **`manifest`**                  | 应用元数据配置文件，定义应用基本信息与运行参数。                   |
| **`ICON.PNG` / `ICON_256.PNG`** | 应用的图标资源文件（不同分辨率规格）。                             |
| **`target`**                    | 软链接，指向应用安装后的主程序文件与运行资源目录。                 |
| **`etc`**                       | 软链接，指向应用的持久化配置文件目录。                             |
| **`var`**                       | 软链接，指向应用重启后仍需保留的运行数据目录。                     |
| **`tmp`**                       | 软链接，指向应用运行过程中的临时文件目录。                         |
| **`home`**                      | 软链接，指向应用的用户数据存放目录。                               |
| **`meta`**                      | 存放应用的元信息。                                                 |
| **`shares/`**                   | 存放 `config/resource` 中声明的共享目录。                          |
| **`wizard/`**                   | 存放安装、升级、卸载或配置阶段的向导页面（UI 表单）。              |

---

### `cmd/` 目录下的生命周期脚本说明

| 脚本名称                 | 主要作用                                                                        |
|:-------------------------|:--------------------------------------------------------------------------------|
| **`install_init`**       | 安装文件应用前执行的前置脚本。                                                  |
| **`install_callback`**   | 安装文件应用后执行的后置回调脚本。                                              |
| **`main`**               | 服务运行控制脚本，处理 `start`（启动）、`stop`（停止）和 `status`（状态检查）。 |
| **`upgrade_init`**       | 应用升级前执行的脚本（常用于数据备份或兼容性检查）。                            |
| **`upgrade_callback`**   | 应用升级后执行的脚本（常用于数据或配置迁移）。                                  |
| **`uninstall_init`**     | 应用卸载前执行的脚本。                                                          |
| **`uninstall_callback`** | 应用卸载清理后执行的回调脚本。                                                  |
| **`config_init`**        | 配置变更应用前执行的脚本。                                                      |
| **`config_callback`**    | 配置变更应用后执行的回调脚本。                                                  |
### Manifest
这是描述应用包，不包含扩展名。 只显示在飞牛 app 上的应用名称和描述。

| 配置字段                         | 主要作用                                                                                          |
|:---------------------------------|:--------------------------------------------------------------------------------------------------|
| **`appname`**                    | 应用唯一标识。                                                                                    |
| **`version`**                    | 应用版本，例如 1.0.0 或 2.1.3-beta。                                                              |
| **`display_name`**               | 显示在应用中心、应用设置和用户界面中的名称。                                                      |
| **`desc`**                       | 应用描述。必要时可以使用 HTML 内容。                                                              |
| **`source`**                     | 应用来源。第三方应用使用 thirdparty。                                                             |
| **`platform`**                   | 支持的硬件架构（`x86` / `arm` / `all`）。                                                         |
| **`maintainer`**                 | 开发者或团队名称。                                                                                |
| **`maintainer_url`**             | 开发者网站或联系方式。                                                                            |
| **`distributor`**                | 发布者名称。                                                                                      |
| **`distributor_url`**            | 发布者网站或联系方式。                                                                            |
| **`os_min_version`**             | 支持的最低系统版本。                                                                              |
| **`os_max_version`**             | 支持的最高系统版本。                                                                              |
| **`install_type`**               | 安装目标（留空由用户选择，`root` 为系统分区）。                                                   |
| **`install_dep_apps`**           | 依赖的应用列表与版本要求。                                                                        |
| **`desktop_uidir`**              | 桌面 UI 资源相对目录（默认 `ui`）。                                                               |
| **`desktop_applaunchname`**      | 存在多入口时，卡片默认打开的入口 ID。                                                             |
| **`service_port`**               | 应用绑定的服务端口号。                                                                            |
| **`checkport`**                  | 控制启动前是否检查端口占用（默认 `true`）。                                                       |
| **`disable_authorization_path`** | 控制应用设置页是否显示授权目录设置。（`false`：用户可以配置授权目录；`true`：隐藏授权目录设置。） |
### 应用权限
权限配置文件位于`config/privilege`

| 配置字段          | 主要作用                                                     |
|:------------------|:-------------------------------------------------------------|
| **`run-as`**      | 运行身份设置（使用 `package` 表示使用专用应用用户运行）。    |
| **`username`**    | 专用用户名（可选项，默认以 `manifest.appname` 生成）。       |
| **`groupname`**   | 专用用户组名（可选项，默认以 `manifest.appname` 生成）。     |
| **`join-groups`** | 附加用户组设置（可选项，用于将应用用户加入其他附加用户组）。 |

生命周期脚本或访问包用户无法处理的设备除外。**不要将`run-as`设置为特权用户Root**

### 文件访问
配置文件为`config/resource`，应用默认不会获得用户文件的广泛访问权限。需要读取或写入用户数据时，应由用户明确授权目录访问。

这段需要分两部分：
#### 宿主机运行
当应用需要提供可由用户在文件管理器中访问的共享目录时，使用 data-share。
```json
{
  "data-share": {
    "shares": [
      {
        "name": "myapp/documents"
      },
      {
        "name": "myapp/backups"
      }
    ]
  }
}
```
默认ACL权限模型为 **Windows ACL**，可以通过环境变量`TRIM_DATA_SHARE_PATHS`，亦或是对`/var/apps/myapp/share/`制作符号链接。

若需要制作跨应用或系统级别访问目录时，需要配置`permission`
```json
{
  "data-share": {
    "shares": [
      {
        "name": "myapp/documents",
        "permission": {
          "rw": ["other_app_user"],
          "ro": ["report_reader"]
        }
      }
    ]
  }
}
```
#### Docker 运行
仅需要配置 Docker Compose 内的文件，但需要配置`config/resource`
```json
{
  "docker-project": {
    "projects": [
      {
        "name": "myapp-stack",
        "path": "docker"
      }
    ]
  }
}
```
`name`需要与`docker-compose.yaml`中的项目名称相同，`path`应包含`docker-compose.yaml`。
### 应用入口
配置文件为 app/ui/config（当 Manifest 中指定 desktop_uidir=ui 时）。应用入口定义了用户从飞牛 fnOS 打开应用的方式，常用于注册桌面图标及文件右键打开方式。入口 ID 建议统一加上应用前缀（如 myapp.main）。

根据用户交互场景的不同，入口配置分为以下两种主要形式：
#### 注册桌面图标
当应用需要提供一个快捷入口，直接在 fnOS 桌面窗口或新浏览器标签页中打开服务时，配置基础入口信息。
```json
{
  ".url": {
    "myapp.main": {
      "title": "My App",
      "icon": "images/icon_{0}.png",
      "type": "iframe",
      "protocol": "http",
      "port": "8080",
      "url": "/",
      "allUsers": true
    }
  }
}
```
| 配置字段       | 主要作用                                                                            |
|:---------------|:------------------------------------------------------------------------------------|
| **`title`**    | 用户看到的入口名称。                                                                |
| **`icon`**     | 相对于 UI 目录的图标路径。可使用 {0} 表示不同尺寸的图标，例如 images/icon_{0}.png。 |
| **`type`**     | 打开方式，一种是`iframe`，在内置窗口打开，否则`http`就是外部 Web 视图中打开。       |
| **`protocol`** | `http`和`https`选择，可留空，交给系统自适应处理。                                   |
| **`port`**     | 服务端口。需要使用向导中收集的端口时，可以使用 ${wizard_port}。                     |
| **`url`**      | 入口打开的路径。需要使用向导中收集的路径时，可以使用 ${wizard_path}。               |
| **`allUsers`** | 控制入口是否对所有用户可见。                                                        |
#### index.cgi
`index.cgi`需放在`app/ui`目录中，且不参与配置文件中的`protocol`和`port`路由。
### 用户向导
所有关于向导的文件将会保存在`wizard`目录中。其中包括`install`、`uninstall`、`upgrade`、`config`，他们通用以下json结构
```json
[
  {
    "stepTitle": "Setup",
    "items": [
      {
        "type": "text",
        "field": "wizard_username",
        "label": "Username",
        "initValue": "admin",
        "rules": [
          {
            "required": true,
            "message": "Enter a username"
          }
        ]
      }
    ]
  }
]
```
> `wizard_username`将会作为环境变量。
### 项目对应依赖
若应用需要依赖，可在`manifest`中申明依赖`install_dep_apps`，同时可作嵌套依赖。
```manifest
install_dep_apps=database:cache
```
同时若需要关系数据库、运行时环境，也可使用`install_dep_apps=redis`。

如果用到了运行时环境，请加入对应的PATH。
```shell
export PATH=/var/apps/{environment}/target/bin:$PATH
```
### 应用图标
需另外图标文件
`ICON.PNG`: 64 x 64 px
`ICON_256.PNG`：256 x 256 px

- 格式：PNG 或 JPG
- 色彩空间：sRGB
- 文件大小：不超过 1024 KB
- 画布：完整正方形图片
- 圆角：图标视觉主体应使用圆角矩形风格。不要使用直角满铺的方形主体；圆角、留白和阴影应尽量与系统图标保持一致。

放置于`app/ui/images/`下。

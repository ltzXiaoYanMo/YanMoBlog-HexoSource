---
title: 如何将本地 LoCyanPureFrp 导入到 NyaLCF 中
tags: LoCyan 事务
id: '184'
date: 2024-05-02 10:40:34
---

目前最新发布的版本已经上传至 GitHub Releases，本篇文章已经寿终正寝（？）

## 死亡回放（？）

因为腾讯云的神仙操作，导致 locyan.cn 和 locyanfrp.cn 的 ICP 备案被取消。

目前在备案当中，现 @ 与 www 解析现已被暂停，导致鉴权不通过。

## 如何操作

右键计算机--属性--高级系统设置--环境变量

在弹出的新窗口中，点击 新建

变量名：NYA\_LCF\_FRPC\_PATH

变量值为你下载的文件，一般像是这样的路径：

```
C:\Users\Konna\frp\frpc.exe
```

Linux/MacOS 在终端中输入：

```
export NYA_LCF_FRPC_PATH = "/usr/bin/frpc/frpc"
```

## 一键配置

Windows x64 版本：

[https://api.ymbit.cn/public/files/autosetpath\_windowsx64.exe](https://api.ymbit.cn/public/files/autosetpath_windowsx64.exe)

若运行失败请尝试使用管理员运行

Linux：

[https://api.ymbit.cn/public/files/autosetpath.py](https://api.ymbit.cn/public/files/autosetpath.py)

使用`python3 autosetpath.py`运行程序。若无法运行，请先运行以下命令

```
pip3 install tqdm aiohttp aiofiles
```

Windows源码：

```
from tqdm import tqdm

import io
import aiofiles
import zipfile
import aiohttp
import asyncio
import shutil
import os
import sys
import time


async def download_file(url, file_name):
    """
    异步下载文件到指定路径。

    :param url: 文件的URL地址
    :param file_name: 保存文件的本地路径及名称
    """
    async with aiohttp.ClientSession() as session:
        async with session.get(url) as response:
            if response.status == 200:
                # 获取文件总大小
                total_size = int(response.headers.get("content-length", 0))
                # 初始化tqdm进度条，total为文件总大小
                with tqdm(
                        total=total_size, unit="B", unit_scale=True, desc=file_name
                ) as pbar:
                    # 使用异步写入方式将文件内容写入本地
                    with open(file_name, "wb") as f:
                        downloaded = 0
                        while True:
                            chunk = await response.content.read(1024)  # 每次读取1KB数据
                            if not chunk:
                                break
                            f.write(chunk)
                            downloaded += len(chunk)  # 累加已下载字节数
                            pbar.update(len(chunk))
                        print(f"文件 {file_name} 下载完成。")


async def main():
    url = "https://api.ymbit.cn/public/files/locyanfrp/frp_LoCyanFrp-0.51.3_windows_amd64.zip"
    file_name = "frp_LoCyanFrp-0.51.3_windows_amd64.zip"
    await download_file(url, file_name)
    await unzip_file(file_name)


async def unzip_file(file_name):
    async with aiofiles.open(file_name, "rb") as f:
        zip_data = await f.read()
    zip_ref = zipfile.ZipFile(io.BytesIO(zip_data), "r")
    for name in zip_ref.namelist():
        zip_ref.extract(name)
    zip_ref.close()  # 关闭 zip 文件对象


if __name__ == "__main__":
    asyncio.run(main())


def set_path():
    src_file = ".\\frp_LoCyanFrp-0.51.3_windows_amd64\\frpc.exe"
    path_set = os.system(f'set NYA_LCF_FRPC_PATH = "{src_file}"')
    if path_set == 0:
        print("环境变量 NYA_LCF_FRPC_PATH 设置成功")
    else:
        print("环境变量 NYA_LCF_FRPC_PATH 设置失败，使用文件移动方式更换版本，确认你的先前版本为 v0.51.3")
        time.sleep(3)

        def move_file(src_path, dst_path):
            try:
                shutil.move(src_path, dst_path)
                print(f"文件 {src_path} 成功移动到 {dst_path}")
                sys.exit(1)
            except shutil.Error as e:
                print(f"移动文件时出错: {str(e)}")
                sys.exit(1)
            except FileNotFoundError as fnf_error:
                print(f"源文件 {src_path} 未找到: {str(fnf_error)}")
                sys.exit(1)
            except PermissionError as perm_error:
                print(f"无权限移动文件: {str(perm_error)}")
                sys.exit(1)
            except Exception as generic_error:
                print(f"其他错误: {str(generic_error)}")
                sys.exit(1)

        src_file = ".\\frp_LoCyanFrp-0.51.3_windows_amd64\\frpc.exe"
        dst_dir = "%appdata%\\moe.xmcn.nyanana\\nyanana\\frpc\\0.51.3-2"
        dst_file = dst_dir + "frpc.exe"  # 目标文件路径   ，假设目标目录已存在

        # 确保目标目录存在
        os.makedirs(dst_dir, exist_ok=True)
        move_file(src_file, dst_file)

```
---
draft: false
title: obsidian 多端同步 - git
aliases:
  - obsidian 多端同步 - git
tags:
  - git
  - Obsidian
created: 2025-03-03T20:23:10
updated: 2025-03-07T12:57:22
---

目前 obsidian 在用 livesync 做同步，但是还是不够丝滑，上次 `Richard` 留言说 git 很好使，我 git 服务都是现成的，就手机端 termux 没有环境，今天我也来折腾下，搞不好打开新世界。

# obsidian 多端同步 - git

## 我的同步场景
同步节点
* 服务端：NAS
* 客户端：PC
* 客户端：手机
* 客户端：Chrome 浏览器（弱需求）

同步需求
1. 手机随时记录闪念，服务端能自动同步；
2. PC 新增/更新笔记，服务端能自动同步；
3. 手机和 PC 有冲突时能提示解决；
4. 同步数据要求支持端到端加密，保证数据安全；
5. 同步服务能稳定运行，不能占用手机太多资源

# git 服务器
git 服务器可以使用 github，gitlab，gitee，也可以自己搭建。
我使用轻量级的 [gogs](https://gogs.io/),感兴趣的可自己体验下 [try-gogs](https://try.gogs.io/)，真的很简洁

## 安装 gogs

```bash
# 数据存储目录
mkdir -p /mnt/mind/data/gogs

# 执行
docker run -d --name=gogs -p 16656:16656 -p 3000:3000 -v /mnt/mind/data/gogs:/data gogs/gogs:latest
```

然后就可以打开 `http://localhost:3000` 新增仓库了

# pc 端
1. 首先，pc 要有 git 环境，obsidian 的 vault 是存储在 git 服务器的目录的，即本地有个隐藏的.git 目录
2. obsidian 中安装 git 插件,配置每 5 分钟自动同步一次

![[rsync+git同步数据-image-20250304.png|738x842]]

# 手机端
安装 termux: 在 F-droid 市场下载即可，
termux 配置
1. 挂载 SD 卡：`termux-setup-storage`
2. 安装 ssh 客户端：`pkg install openssh`
3. 安装 git：`pkg install git`
4. sshkey 生成: `ssh-keygen`
5. 在 git 服务器,添加手机端的 sshkey，这样手机端就能免密登录提交代码了。

```bash
# 手动提交示例
git config --global user.name "xtool"
git config --global user.email "xtool@gmail.com"
echo "Hello, Obsidian!" > hello.md
git add hello.md
git commit -m "Add hello.md"
git push origin master
```

![[rsync+git同步数据-image-20250304-2.png|995x677]]

工作流程
1. 打开 termux: 执行获取更新:`sh pull.sh`
2. 在 obsidian 中，手动修改笔记，上传图片之类操作
3. 执行 push.sh

> 示例

使用 pull 更新笔记后，在当前笔记上传下图，然后调用 push.sh 提交

![[rsync+git同步数据-Screenshot_20250304_220930_com-20250304.png|488x1080]]

下面是自动化提交脚本

## 获取更新
vim pull.sh
chmod a+x pull.sh

```bash
#!/data/data/com.termux/files/usr/bin/sh
# 目录设置在：1/gogs/kbase

# 手机端：丢弃本地修改，使用git服务端最新提交覆盖
cd /data/data/com.termux/files/home/storage/shared/1/gogs/kbase && git fetch origin && git reset --hard origin/main && git clean -fd
```

## 提交修改
vim push.sh
chmod a+x push.sh

```bash
#!/data/data/com.termux/files/usr/bin/sh

# 手机端：提交修改
cd /data/data/com.termux/files/home/storage/shared/1/gogs/kbase && git add . && git commit -am'update by android' && git push origin master
```

## 脚本执行入口
安装 [termux-widgt](https://github.com/termux/termux-widget) 插件，可提供 UI 执行 pull 和 push

```bash
# 前台程序
mkdir -p /data/data/com.termux/files/home/.shortcuts
chmod 700 -R /data/data/com.termux/files/home/.shortcuts

# 后台程序
mkdir -p /data/data/com.termux/files/home/.shortcuts/tasks
chmod 700 -R /data/data/com.termux/files/home/.shortcuts/tasks

# 将上面的pull.sh和push.sh复制到shortcuts目录
cp /data/data/com.termux/files/home/storage/shared/1/termux/*.sh  /data/data/com.termux/files/home/.shortcuts
```

由于我需要修改，所以自己手动更新
如果手机端是只读，可以配置 `crontab` 执行每 5 分钟更新一次。

```bash
pkg install cronie termux-services

crontab -e

# 每5分钟覆盖本地笔记
0 */5 * * * ? sh ~/.shortcuts/pull.sh
```

📌 总结
本文介绍了 obsidian 的 git 来实现多端同步，这个方案仅适合程序员，有点门槛。
但是 git 是最可靠的版本控制和协作服务，linux 操作系统那么复杂庞大的源码都是用 git 协作开发，咱这点笔记共享编辑编辑，不在话下。
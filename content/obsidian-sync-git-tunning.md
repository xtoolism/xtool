---
draft: false
title: obsidian 多端同步 - 如何解决 git 冲突
aliases: [git 多端冲突问题, gitignore 文件配置, obsidian 多端同步 - 如何解决 git 冲突, 冲突问题]
tags: [git, Obsidian]
created: 2025-03-05T21:22:33
updated: 2025-03-06T14:33:43
---

# obsidian 多端同步 - 如何解决 git 冲突
目前使用 [LiveSync](https://mp.weixin.qq.com/s/Qw_4l5C56mFuJ6q85Ma_VA) 作为实时同步工具，不愧 `Live` 为名，实时性的确是挺好。但是一旦出了问题，`LiveSync` 重新同步还是很慢的。
所以我选择用自己熟悉的 `Git` 定时备份的数据作为兜底的方案。遇到问题手机可以随时用 `Termux` 一键从 Git 获取最新的笔记；

在 unix 的设计思想里面，对用户透明的文本流优于二进制设计（在经济性非第一位的场景），这就是用 obsidian 最让人喜欢的地方，他没有其他软件背后那些 `高明` 的黑箱操作。所有的数据都在本地，笔记都用 Markdown 纯文本来管，出了问题用户一点都不怕。

扯开了，回归主题，上次分享了 [obsidian 多端同步 - git](https://mp.weixin.qq.com/s/JOy_hmy1dIKd2C6U4joz4Q) 方案，这次继续补充下，如何解决 git 冲突，避免发生冲突；

## 问题描述
手机端和 PC 端，有些插件的数据在同时编辑时，是会冲突的。
比如：

```bash
.obsidian/plugins/remember-cursor-position/cursor-positions.json
.obsidian/plugins/recent-files-obsidian/data.json
```

如果手机端也提交，PC 端 pull 后，会生成一个冲突文件提示要解决冲突才能 push。
这个挺好，还生成一个一个好看的 md 文件告诉你哪里冲突了，打开处理下就好。
![[obsidian-sync-git-tunning-image-20250305.png|1080x714]]

## 问题解决
之前 commit 的一些插件的实时数据会冲突，需要做如下操作。
1. cli 手动删除这些文件
2. 提交到 git 服务器
3. 修改.gitignore
4. 提交到 git 服务器

> .gitignore 文件

```bash
**/obsidian/.stfolder/
**/obsidian/.obsidian/cache
**/obsidian/.obsidian/workspace.json
**/obsidian/.trash/
**/obsidian/.recycle
**/.obsidian/plugins/recent-files-obsidian/data.json
**/.obsidian/plugins/remember-cursor-position/cursor-positions.json
**/.obsidian/plugins/obsidian-mindmap-nextgen/data.json
**/.obsidian/plugins/text-extractor/cache
**/.history
**/*.edtz
**/.DS_Store
**/_gsdata_
.idea
*.iml
```

另外手机端，git 插件，配置 `disable on this device`，避免 git 在客户端定时触发同步导致报错。

## 相关工具
### autojump
手机端 termux，装个 `autojump`,方便目录切换，不然触屏输入 termux 那长的要死的目录特别蛋疼。
比如 `cd /data/data/com.termux/files/home/storage/shared/1/gogs/kbase`,直接 `j kbase` 就能跳转了。

```bash
pkg install -y autojump
```

j 的目录笔误也允许，对我这个手残老是打错字的人来说简直是救星。

![[Screenshot_20250305_231832_com.termux_edit_170867525631328.png|511x739]]

### openssh
手机安装 ssh 服务，这样在局域网可以通过 PC 端随时处理手机上的问题了。

```bash
# 安装服务
pkg install -y openssh
pkg install -y openssl
sshd

# 查看IP
ifconfig -a

# 查看默认用户，比如：u0_a279
~ $ whoami

# 设置termux用户的密码
~ $ passwd
New password: 
Retype new password: 
New password was successfully set.

# 连接处理
ssh -p 8022 u0_a279@192.168.68.57
```

📌 总结
本文介绍了 obsidian 多端同步 - 如何解决 git 冲突。

我的 LiveSync 出过好几次同步异常的问题，现在有了 git 可以快速的一键和 pc 端保持一致，再也不怕了。

嗯，这次手机端 termux 的操作是回家在局域网搞的，这个限制不好，下次得搞个 frps 公网就能 ssh 连手机的方案。
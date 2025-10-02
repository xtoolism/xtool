---
title: obsidian-plugin-install
aliases: [Obsidian 社区插件安装终极指南：一键解决 GitHub 访问卡顿]
tags: [Obsidian]
created: 2025-03-30T15:46:06
updated: 2025-10-02T11:37:57
draft: false
---
![[file-20251002111833669.png|1024x436]]

# Obsidian 社区插件安装终极指南：一键解决 GitHub 访问卡顿
国内用户安装 Obsidian 插件常因 GitHub 访问受阻而头疼。本文详解官方/镜像/个人插件源安装技巧，推荐 DevSidecar 工具一键绕过 DNS 污染，无需折腾 Hosts 更新。无论社区插件还是小众工具，三步搞定，让知识管理效率翻倍！

## 插件来源
obsidian 的插件源有 3 类
1. **官方源**：github 开源社区贡献的，已提交审核发布到 obsidian 插件市场，可在 obsidian 内部的 `社区插件市场` 下载；
2. **官方镜像源**：如 pkmer 对 obsidian 的所有插件定时做了 `镜像` 同步和汉化，可通过安装 pkmer 插件市场下载；
3. **个人源**：个人开发但是没有提交到社区市场的,需要自己 `离线安装`；

### 官方插件源
obsidian 插件市场： https://obsidian.md/plugins
![[file-20251002111833866.jpg]]

### 国内插件源
PKMer 插件地址: https://pkmer.cn/products/market, 按环境下载对应的版本下载安装
在线插件市场： https://pkmer.cn/products/plugin/pluginMarket/
![[file-20251002111834012.jpg]]

### 个人插件源
比如：https://outliner.md，可以对实现类似 notion 的块拖拽，嵌入笔记能直接编辑
这个插件很好用，but 官方市场没有，就只能使用离线安装的形式

## 插件安装
下面介绍在线和离线 2 种插件安装方式

### 在线安装
obsidian 内点击浏览即可搜索安装
![[file-20251002111834191.jpg]]

### 离线安装
在 github 下载插件后本地离线安装。

obsidian 的插件安装时主要包含 3 个文件，下载后放到插件目录，然后在 obsidian 社区插件列表刷新并启用
下面以 obsidian-linter 为例：

```bash
# vault目录
/mnt/gogs/kbase

# obsidian-linter插件安装目录
/mnt/gogs/kbase/.obsidian/plugins/obsidian-linter

# obsidian-linter插件内文件列表
.
├── data.json
├── main.js
├── manifest.json
└── styles.css
```

## 插件市场无法打开/安装？
最后重点介绍下大家常问的 obsidian 社区插件市场无法打开，或者打开了点击安装没反映的问题。

* 在国内 github 经常出现无法访问，原因通常是 DNS 污染。
* 网上很多介绍的是简单修改 Host 解决 github 无法访问。但 ip 会变，经常更新 hosts 比较麻烦，有时候更新的不对，还是打不开。
* 今天分享一个通过 `DevSidecar` 工具一键解决 github 访问问题,在 github 有 17k 的 star，还是很受好评的；

### DevSidecar
![[file-20251002111834335.jpg]]
DevSidecar 原理是通过本地代理的方式将 https 请求代理到一些国内的加速通道上；
* 项目地址： https://github.com/docmirror/dev-sidecar
* 下载地址： https://github.com/docmirror/dev-sidecar/releases

上面地址打不开的，可以使用 github 的镜像站 (https://dgithub.xyz) 下载
比如 - 最新 v2.0.0.1 版本。
windows-x64: https://dgithub.xyz/docmirror/dev-sidecar/releases/download/v2.0.0.1/DevSidecar-2.0.0.1-windows-x64.exe

 https://dgithub.xyz/jellyfin/jellyfin-android/releases/download/v2.6.2/jellyfin-android-v2.6.2-libre-debug.apk

> 其他环境的读者应该都有上网方法就不提供了😜

注意事项：
1. 打开后使用安全模式，devSideBar 默认会启动系统的网络代理；
2. 如果关闭 devSideBar 没有关闭网络代理，会导致不能打开其他网站，重新打开 devSideBar，关闭网络代理即可
3. 如果遇到卡顿的情况，可重启 devSideBar/开关代理重试；
4. 有条件的建议还是自带直接上网的工具🤫

## 视频教程
![[file-20251002111834836.mp4]]

## 结语
如果你是技术小白，恐惧配置网络代理，推荐使用 `PKMer`；
如果你想直接使用社区市场最新插件，不想收到 PKMER 的次数限制，可以试试 `DevSidecar`，亲测流畅无痛！

遇到问题或想交流更多 Obsidian 技巧，欢迎留言～工具虽小，效率爆炸，一起做知识管理的老司机🚀

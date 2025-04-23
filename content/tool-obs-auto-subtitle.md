---
draft: true
title: tool-obs-auto-subtitle
aliases: [OBS Studio 桌面录屏教程：自动字幕 + 背景音乐]
tags: [极客工具]
created: 2025-03-30T17:33:13
updated: 2025-04-06T10:58:07
---

![[tool-obs-auto-subtitle-image-20250406.png|1024x436]]

# OBS Studio 桌面录屏教程：自动字幕 + 背景音乐
用 OBS Studio 录屏时，如何轻松添加自动字幕和背景音乐？这款开源插件支持阿里云、讯飞、华为云的实时语音转文字，3 步配置即可实现专业级字幕效果。搭配背景音乐调节技巧，让你的视频质感瞬间提升！（文末附手把手实操教程）

## OBS Studio 录屏工具
OBS Studio - 开源直播和录屏工具
项目地址： https://obsproject.com
下载地址：
https://github.com/obsproject/obs-studio/releases

![[file-20250330192235.jpeg]]

## OBS 配置自动字幕
字幕能优化用户体验，集成 AI 字幕解放人力，值得推广。
![[file-20250330183128.jpg]]

### 项目介绍
使用到 OBS 自动字幕插件
项目：[obs-auto-subtitle](https://github.com/summershrimp/obs-auto-subtitle)
OBS 自动字幕插件（obs-auto-subtitle） 是一款专为 OBS Studio 设计的开源工具，旨在实现实时语音转文字并显示字幕的功能。目前。它利用阿里云、讯飞和华为云的实时转录服务来实现字幕生成。

### 关键技术和框架
* 实时音频转文本 API：依赖于三大云服务商（阿里云 NLS、讯飞 RTASR、华为云 RASR）提供的实时语音识别服务。
* OBS Studio API 集成：通过 OBS 的插件接口集成，允许在直播场景中无缝添加自动字幕。

### 下载地址
最新版本**下载地址**：`https://github.com/summershrimp/obs-auto-subtitle/releases`
支持 windows,mac,linux
windows-v1.1.0 版本下载地址：`https://github.com/summershrimp/obs-auto-subtitle/releases/download/1.1.0/obs-auto-subtitle-1.1.0-windows-x64.zip`

### 阿里云 NLS - 实时语音识别
#### 操作流程
1. 注册阿里云，获取 AccessKey 和 SecretKey
2. 开通智能语音服务，创建项目，获取 appKey，地址： https://nls-portal.console.aliyun.com/applist

这 3 个 key 保留好， 需要在的 obs 内配置自动字幕滤镜时用到

#### 收费情况
新用户开通阿里云 NLS 服务后，可享受 3 个月免费试用，后续价格也不贵。

| 资源包规格      | 资源包价格     | 单价        |
| ---------- | --------- | --------- |
| 30 小时      | 100 元     | 3.33 元/小时 |
| 1,000 小时   | 1,800 元   | 1.80 元/小时 |
| 10,000 小时  | 15,000 元  | 1.50 元/小时 |
| 84,000 小时  | 100,000 元 | 1.20 元/小时 |
| 182,000 小时 | 200,000 元 | 1.10 元/小时 |
| 300,000 小时 | 300,000 元 | 1.00 元/小时 |

## OBS 配置背景音乐
`没有 bgm 的视频是不完整的`，使用音乐播放器播放背景音乐，在 DesktopAudio 选择电脑音箱作为音频输出源，配置音量比例为 25%
![[file-20250330173313.jpg]]

## 视频实操教程
![[file-20250331073311.mp4]]

> 缺点：录制完发现字幕有点延迟，暂时没找到配置字幕延迟的地方

## 结语
加上字幕和 BGM 后效果确实好多了！关于视频剪辑，欢迎专业的小伙伴在评论区支招，你们的建议对我超有帮助的！

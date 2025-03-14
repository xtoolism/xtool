---
draft: false
title: Obsidian 与 Photopea 的完美结合：打造高效图片编辑工作流
aliases: [Obsidian 与 Photopea 的完美结合：打造高效图片编辑工作流]
tags: [Obsidian]
created: 2025-03-08T19:43:33
updated: 2025-03-13T23:28:49
---
![[obsidian-photopea-conver-photopea-20250308.png|993x557]]
AI 生成的配图有时候需要配个文字，或者本地图片打一些马赛克，
这个时候 obsidian-image-converter 已经不能满足我的图片编辑需求了，这两天研究出一个基于 obsidian 的图片编辑的完美工作流，无需来回切换，在 obsidian 内部即可完成复杂的图片 PS 操作。

# Obsidian 与 Photopea 的完美结合：打造高效图片编辑工作流
## 使用流程
1. 在 obsidian 中打开本地要编辑的图片；
2. 在 obsidian 中点击快捷键复制图片的文件地址；
3. 使用 obsidian 的 webviewer ，打开 [photopea](https://demo.kodcloud.com/?plugin/photopea/)，加载本地图片；
4. 在 photopea 中完成图片编辑，交互功能和 photoshop 基本一致；编辑完成后导出文件到本地，覆盖本地文件；

## 依赖项目
* obsidian webviewer：核心插件中，启用 webviewer，在 obsidian 中打开外部链接；
* 基础图片编辑器：[obsidian-image-converter](obsidian://show-plugin?id=image-converter),适合只需要缩放，裁剪，压缩之类的基础需求；
* 高级图片编辑器：web 端的 photoshop：[github-photopea](https://github.com/photopea/photopea)，适合需要图片添加文字，去水印等高级操作；
* 文件路径复制：[obsidian-show-file-path](obsidian://show-plugin?id=obsidian-show-file-path),在 obsidian 中一键复制图片的绝对路径；

操作示例
![[Obsidian 中的完美图片编辑工作流-演示.mp4]]

### photopea
可以去官方直接使用：[photopea](https://www.photopea.com/)。
如果慢的话，国内的 kodbox 是个开放的私有云产品，里面集成了 [photopea](https://demo.kodcloud.com/?plugin/photopea/)，懒得部署的也可以直接点开用，效果如下

![[photopea.png]]

photopea 本地化 部署脚本

```yml
version: '3'
   services:
     photopea:
       image: kovaszab/photopea:latest
       container_name: photopea
       ports:
         - "8080:80"
       restart: always
```
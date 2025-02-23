---
comment: true
title: 公众号发布工作流：搞定自动传图和一键排版
created: 2025-02-22 10:02:00
modified: 2025-02-23 10:02:11
tags: [Obsidian, OSS, 公众号]
aliases: [公众号发布工作流：搞定自动传图和一键排版]
---

![[wechat-publish-1740238783769.jpeg]]

# 公众号发布工作流：搞定自动传图和一键排版

> 当你在 Obsidian 文思泉涌写完文章，却被公众号后台的 "20 张配图手动上传 + 排版乱码 " 瞬间浇灭热情——这套工作流，让你彻底告别复制粘贴的抓狂时刻！
> 1. `阿里云 OSS` 作为图床自动托管图片（年费≈一杯奶茶）
> 2.  Obsidian 插件一键转换本地路径为公网链接
> 3.  微信公众号专属 Markdown 编辑器一键美化文章
> 从此粘贴到微信后台的图文，字号不乱跑、配图不失踪，省下的时间够写完下一篇的选题。

## 🌟 三个准备工作

### 阿里云 oss 在线图床

1. 注册阿里云帐号，生成 AccessKey 获取 AccessKey ID 和 AccessKey Secret
2. OSS 服务配置： 新增 bucket，权限控制 - 设置为公共读
3. 阿里云 OSS 服务收费情况：选本地冗余存储的标准型，上传流量是免费的，外网访问是忙时 5 毛钱 1GB。这个方案只需要用临时 OSS 上传，将本地文件地址，转成公网可访问的图片链接。发布后，素材都可以从 oss 删除，文件实际都是在本地，所以一年下来也花不了几块钱。
![[obsidian-oss服务价格明细-174020497357.png|736x401]]

### obsidian 图床插件配置

obsidian 安装插件 [obsidian-image-upload-toolkit](https://github.com/addozhang/obsidian-image-upload-toolkit)，启用后，配置如下

![[obsidian图床配置oss.png]]

### 微信公众号 markdown 编辑器

使用 WeChat Markdown Editor 一键美化 markdown 风格

* 项目地址：<https://github.com/doocs/md>
* 项目介绍：WeChat Markdown Editor：一款高度简洁的微信 Markdown 编辑器：支持 Markdown 语法、色盘取色、多图上传、一键下载文档、自定义 CSS 样式、一键重置等特性
* 使用地址：
	* [https://doocs-md.pages.dev](https://doocs-md.pages.dev/)
	* [https://doocs.github.io/md](https://doocs.github.io/md)

#### 老司机进阶操作

> 3 分钟在自己的 github 部署微信公众号 Markdown 编辑器

1. 在 github fork 项目 [doocs-md](https://github.com/doocs/md)
2. 在 fork 后的项目，启用 `github pages`
3. 修改 github actions 中的 github repository,参考我的 [部署脚本](https://github.com/geosmart/md/blob/main/.github/workflows/build.yml)
4. 修改 build.yml 后，会触发自动部署 github pages
5. 最终部署地址：[微信公众号-markdown编辑器](https://github.com/geosmart/md)

> fork 部署后，服务是自己的，数也据都是保存在浏览器本地的，可以更放心使用

## 🛠️ 极简四步操作流

1. **Obsidian 写作**：在 obsidian 以 markdown 格式完成作品编写，随意插入本地图片；
2. **插件传图咒语**：在 obsidian 中，执行 `ctrl+p` 唤醒指令输入框，输入 `Image Upload Toolkit: publish page`，插件会自动上传图片到 OSS，并且复制新的内容到粘贴版，粘贴板的图片路径都会从相对路径变成 oss 的绝对路径。

	> 当你的文章有 10 来张图片的时候，复制到公众号里，本地图片在公众号里玩起集体隐身术，你就体会到这个插件有多香了。

3. **一键排版**：打开 [微信公众号markdown编辑器](https://geosmart.github.io/md/) ，粘贴内容，调整下样式后，点击复制 - 微信公众号格式。
	![[微信公众号markdown编辑器.jpg]]

   > 当你在 obsidian 文思泉涌，用 markdown 语法的#号写下结构复杂的篇章，然后往这个编辑器以粘帖，朴实无化的 markdown 长文 瞬间完成优美的 html 变身，你一定会大声呼喊：开源万岁！

4. **公众号后台收尾**：打开微信公众号 - 文章编辑页面，粘贴内容，保存草稿后者定时发布即可。
	![[微信粘贴复制的内容.png]]

## 💡 老司机经验包

*  **OSS 省钱诀窍**：发布后及时清空 Bucket，只当临时中转站
*  **防坑指南**：Obsidian 插件配置时，Bucket 名称带地域后缀（如 oss-cn-hangzhou）
*  **安全提醒**：自建编辑器数据存本地，敏感内容更放心

⏳ **时间账本**：  
过去：传图 10 分钟 + 调格式 20 分钟 → 现在：3 分钟全自动搞定  
省下的时间，够你写完下一篇 10W+ 的选题！

本文的工作流是解决了微信公众号的图床和排版的效率问题，对只做公众号是够了。

但是我们写一篇文章，当然是多平台分发，最大化获取曝光，那如何自动化解决这些问题？有没有安全可靠的开源方案？等我工具侠下次分享。

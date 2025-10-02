---
refer: https://github.com/xRyul/obsidian-image-converter/blob/882305d8546512ff13eaa3fb1a93aa50d1827490/Examples/Variables%20Reference%20Guide.md
title: obsidian 附件管理最佳实践
aliases: [obsidian 附件管理最佳实践]
tags: [Obsidian, PKM]
created: 2025-03-29T07:56:01
updated: 2025-10-02T11:58:20
draft: false
---
![[file-20251002111825694.jpeg]]
你是否为 Obsidian 中越积越乱的图片附件头疼？从全网截图到本地素材，附件管理失控后连自己都找不到关联文件。
本文实测 4 种主流方案，结合两大神器插件 `custom-attachment-location` 和 `image-converter`，实现附件按笔记智能归类、自动重命名，告别混乱，打造丝滑个人知识库！

# obsidian 附件管理最佳实践

## 我的 obsidian 附件管理经历
刚开始笔记附件比较少，我都存储在一个 attachments 目录，但随着使用时间久了，附件累计到近千张，笔记和附件的关系就不那么好找了，一个目录拉到底都找不到，附件名称有时候是截图随机名，没有关键词，一切都乱糟糟！

于是开始折腾，去尝试了各种方式组织附件，按文件创建日期组织，按文件大小组织，按笔记名组织；

最后发现了 `custom-attachment-location` 插件的自动化处理，批量处理能力很强，再结合 `image converter` 插件强大的图片编辑/标注功能，齐活了。

优化后的方法将附件分散到笔记目录，方便管理具体每个笔记的附件
1. `custom-attachment-location` 插件：配置将所有附件统一存储在动态文件夹（`./assets/${filename}/附件.jpg`），笔记重命名，笔记移动，文件重命名会自动更新关联；
2. `image converter` 插件：自动处理图片粘贴时的自动命名，图片存储位置以笔记名为文件夹名称，也支持手动更新文件名称；
3. [使用quartz将obsidian发布为静态博客](https://mp.weixin.qq.com/s/bOny9mGBuCNgwMXG-3_D0A) 也天然支持这个 assets/${filename}的附件引用规则，完美；
4. `paste image rename` 这类插件就不需要安装了，`image converter` 的功能已经覆盖了；

可能有人问你为啥不用图床，我是有在用的，不过我的阿里云 OSS 图床仅仅作为公众号等对外发布时使用，将本地附件转成公网可访问的链接发布后，素材都可以从 oss 删除（具体见 [公众号发布工作流：搞定自动传图和一键排版](https://mp.weixin.qq.com/s/RLiGAkef_w1w-SxLb51SlQ)）

不过既然都用 Obsidian 了，那肯定是坚持 `本地化永远第一位` ，就算没有网络，数据都在本地，读写不受任何影响。

下面分享下我对附件管理做的探索，以及目前附件存储方式的配置方案。

## 常见的附件组织方式
为了搞清楚哪样存储最好，对常见的 4 种附件组织方式做了调研

### 单目录存储
之前我使用的是这种，obsidian 系统默认的也是这种,最简单容易上手

```bash
/attachments
├── 图片1.jpg at 2024-10-31 12-34-56
└── 图片2.png at 2024-10-31 13-00-00
└── … 其他附件
```

### 按文件创建日期组织

```bash
/attachments
├── images
│   ├── 2025-03-29
│   │   ├── 测试笔记
│   │   │   ├── 图片1.jpg at 2024-10-31 12-34-56
│   │   │   └── 图片2.png at 2024-10-31 13-00-00
│   └── … (其他日期)
└── … (其他附近，如 PDFs， docs， etc.)
```

在一个主文件夹中组织添加到 Obsidian 的所有图片：`/images`，同时将所有其他附件（PDF、docx、zip 等）保存在 `/attachments` 文件夹中。

在 `/images` 中，为每天添加或处理图像时自动创建一个新的子文件夹，例如 `/2024-03-29`。然后每个每日子文件夹包含插入图像的每个笔记的子文件夹（例如，`测试笔记`）。
这是一个 `文件夹密集型方法`，但允许轻松创建一个按时间顺序查看何时将哪些图像添加到哪个笔记的视图

### 按文件大小组织
如果想控制 obsidian 的 vault 库的附件大小，可以使用这种组织办法
- **文件夹** : `/attachments/images/{fileSizeCategory}/`
- **文件命名** : `{noteName}-{imageName}-{size:MB:2}MB_{date:YYYYMMDD}`
所有图像保存在一个地方，并根据转换后的图像文件大小分类到子文件夹中：

```bash
/attachments
├── images
│   ├── 0-50KB
│   ├── 51-200KB
│   ├── 201-1024KB
│   ├── 1025KB-5MB
│   ├── 5MB-10MB
│   └── 10MB+
└── … (other attachments， like PDFs， docs， etc.)
```

例如，如果我在 **1025KB-5MB**，**5MB-10MB**，**10MB+** 文件夹中看到任何图片，这会让我知道这些图片需要进一步优化（或者如果我想保持我的库大小较小，我甚至会考虑删除它们）

### 按笔记名组织
目前我使用的是这个方式，比如这篇文章图片的存储结构

```bash
/assets
│   └── obsidian 附件管理的最佳实践                                                        
│       ├── obsidian 附件管理的最佳实践-image-20250329.png
│       ├── obsidian 附件管理的最佳实践-image-20250329-1.png
├── obsidian 附件管理的最佳实践.md
```

- 在笔记内粘贴附件时，插件自动创建一个和笔记名同名的目录，然后将附件存储在目录内；
- 笔记重命名，附近重命名时，笔记内关联的引用自动更新

## obsidian 的附件管理插件
2 个社区插件实现附件自动化管理：附件位置自动更新（custom-attachment-location），可视化编辑图片 (image-converter)

### 附件位置自动更新（custom-attachment-location）
核心功能:
- 将笔记的图片移动到笔记名称的目录 (`./assets/${filename}`)，如果没有图片，则不创建目录；
- 文件名统一命名: 我习惯自己命名，这样便于检索，所以关闭这个特性；
- **批量处理**: 将整个库/指定目录/单文件内的附件按配置规则移动并重命名. 一键整理的福音；
- **自动处理更新**: 笔记重命名，笔记移动，文件重命名会自动更新关联， 这个自动更新功能太强了，其他插件会存在引用失效问题
安装地址: obsidian://show-plugin?id=obsidian-custom-attachment-location

配置见截图

![[file-20251002111825887.png|1058x870]]

### 可视化编辑图片 (image-converter)
[obsidian-image-converter](obsidian://show-plugin?id=image-converter),适合只需要缩放，裁剪，压缩之类的基础需求

配置图片存储路径
![[file-20251002111825990.png|1071x728]]

### 附件统计（vault-statistics）
#### windows 用户
obsidian 中安装 vault-statistics 插件，支持在状态栏统计大小，笔记数，附件数，链接数。

#### mac 或 linux 用户
可通过脚本统计

```bash
cd obsidian/valut
find ./  -type f \( -name "*.jpeg" -o -name "*.png" -o -name "*.jpg" \) | wc -l
```

### obsidian 附件管理实操演示
#### 一键自动整理附件演示
![[file-20251002111826382.mp4]]

#### 插件配置和使用教程
![[file-20251002111827025.mp4]]
**演示内容**
1. 插件配置
	1. custom-attachment-location
	2. image-converter
2. 网页图片粘贴 - 附件自动重命名
3. 文件夹/笔记重命名，附件引用自动重命名
4. 图片重命名，笔记引用自动重命名
5. 图片交互式编辑

> 在 ubuntu 将桌面由 wayland 换成了 x11,终于可以用 OBS Studio 录制声音了，不过笔记本的麦克风太拉垮了，再凑合一下…

# 结语
折腾过各种附件管理方案后，终于明白：`工具的最高境界是无感`。
现在我的 obsidian 附件既能 `自动归类` 到对应笔记，又能一键发布到公众号，甚至迁移笔记时连路径都不用操心。
如果你也在为附件管理发愁，不妨试试这套组合拳。对了，你平时用什么方法管理笔记附件？欢迎在评论区聊聊你的妙招~

---
draft: true
title: 我的 Obsidian 插件 - 2025
aliases: [obsidian 插件, 我的 obsidian 插件, 我的 Obsidian 插件, 我的 Obsidian 插件 - 2025]
tags: []
created: 2025-02-24T09:14:30
updated: 2025-02-27T21:08:52
---

# 我的 Obsidian 插件 - 2025
![[obsidian-plugins-image-20250227.png]]
在之前的系列文章中，我探讨了Obsidian的核心理念（[当 Obsidian 遇见大学之道](https://mp.weixin.qq.com/s/VFvP_c9UHdPUql75oQVVHg)）、知识管理方法（[从碎片到体系](https://mp.weixin.qq.com/s/kJinvC8za5P_57ZAboHgbg)）、[自动传图和一键排版方法](https://mp.weixin.qq.com/s/RLiGAkef_w1w-SxLb51SlQ)以及发布技巧（[一键发布知识图谱](https://mp.weixin.qq.com/s/bOny9mGBuCNgwMXG-3_D0A)）。

本文是当然也是在Obsidian里面编写的，这期分享下我在Obsidian中安装的插件
![[obsidian-plugins-1.png|1080x1007]]
## 工作流
* 待办管理：[[obsidian-tasks]]
* 待办管理 - 时间线视图：[tasks-calendar-wrapper](obsidian://show-plugin?id=tasks-calendar-wrapper)
* 快速笔记：[QuickAdd](obsidian://show-plugin?id=quickadd)：自动化，AI 助理
* 周期笔记：[periodic-notes](obsidian://show-plugin?id=periodic-notes)，按周/季/月/年，按模板总结

## 搜索增强
* 主页：[homepage](obsidian://show-plugin?id=homepage)
* 文件夹笔记：[folder-notes](obsidian://show-plugin?id=folder-notes)
* 文件夹显示文件数：[file-explorer-note-count](obsidian://show-plugin?id=file-explorer-note-count)
* 最近编辑的文件：[recent-files-obsidian](obsidian://show-plugin?id=recent-files-obsidian)
* 最近编辑的光标位置：[remember-cursor-position](obsidian://show-plugin?id=remember-cursor-position)
* 脑图：[obsidian-mindmap-nextgen](https://github.com/james-tindal/obsidian-mindmap-nextgen)
* 搜索增强：[omnisearch](obsidian://show-plugin?id=omnisearch)
* 笔记大纲：[obsidian-quiet-outline](obsidian://show-plugin?id=obsidian-quiet-outline)
* PPT 预览：[marp](obsidian://show-plugin?id=marp-slides)
* search-on-internet：嵌入式 browser
* 彩色标签：[[colored-tags]]

## 知识同步
* 实时同步：[[obsidian-livesync]]，基于 couchdb 服务
* 数据备份：[[obsidian-git]]，基于 git 服务（github/gogos）
* 微信阅读：[obsidian-weread-plugin](obsidian://show-plugin?id=obsidian-weread-plugin)，按书同步笔记和高亮
* 知识导出：[obsidian-enhancing-export](obsidian://show-plugin?id=obsidian-enhancing-export)：基于 pandoc 导出各种格式
* 数据导入：[obsidian-importer](obsidian://show-plugin?id=obsidian-importer)：外部笔记导入，第一次知识迁移时候能用到

## 编辑增强
* 数据视图：[[obsidian-dataview]]
* REST 接口：[[obsidian-local-rest-api]]
* 模板：[[obsidian-templater]]
* UML 流程图：[[plantuml]]
* 图片编辑/转换/压缩：[image-converter](obsidian://show-plugin?id=image-converter)，支持粘贴时按规则自动重命名，图片压缩，修改大小，右键重命名等
* 文本输入智能提示：[[various-complements]]
* 自动格式化：[linter](obsidian://show-plugin?id=obsidian-linter)

## AI 增强
* AI 总结/提示词管理：[[QuickAdd]]，启用 AI Assistant
* AI 对话/RAG 问答：[copilot](obsidian://show-plugin?id=copilot)

## 尝试 but 放弃的插件
### GTD
* [[obsidian-projects]]：远期规划
* [[obsidian-card-board]]：日常 TODO
* [obsidian-kanban](https://github.com/mgmeyers/obsidian-kanban)：看板视图

> GTD 方案现在使用 period-notes 和 tasks

### 知识采集
* [[cubox]]：之前买了一年的服务，在移动端 wechat 采集，然后同步到 obsidian，产品体验很好。但是有隐私安全风险，而且 ob 的官方移动端越来越好用，我后来使用 `livesync` 把 pc 端和手机端的实时同步也搞好了，就放弃 cubox 了，不花钱还安全。
* [[obsidian-omnivore]]：read it later,用过一段时间，切换到 `cubox`，现在切换到 obsidian 官方的 web-clipper 了

> 移动端最方便的入口是微信，聊天的形式记录最自然，可以用到微信输入法的语音输入，很快捷。
> 后面考虑使用公众号来收集自己的闪念，然后用 api 将公众号数据发送到 obsidian。

### 数据同步
* [[syncthing]]：同步时经常有网络问题，放弃了
* [[AutoSync]]：同步 webdav，冲突解决麻烦
* kopiaUI：github star 很高，尚未测试使用

---

在这个信息过载的时代，Obsidian插件的终极价值不在于功能的堆砌，而在于构建**最小可行性认知系统**。
我的2025配置方案或许是你`认知升级`的垫脚石，但真正的知识圣殿永远建立在`持续迭代`的实践中。

`工具革命永无止境，但认知进化自有其道`。
愿我们都能在工具与思维的共生中，找到属于自己的`《工具论》`——毕竟，亚里士多德可想象不到，他的哲学命题会在数字时代以插件的形式重生。

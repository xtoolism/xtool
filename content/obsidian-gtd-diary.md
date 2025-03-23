---
draft: false
title: obsidian-gtd-diary
aliases:
  - Obsidian 日记工作流：待办、闪念与打卡的高效管理
tags:
  - Obsidian
  - 知识管理
created: 2025-03-19T09:13:16
updated: 2025-03-20T07:44:31
---
![[cover-obsidian-gtd-diary.png|1080x617]]
今天分享一个超实用的 Obsidian 日记工作流，帮你搞定待办、闪念和打卡。通过插件和自动化脚本，未完成的待办可以自动迁移到新的一天，再也不用手动复制粘贴了。日记模板还能帮你记录每天的思考、挑战和收获，顺便跟踪习惯打卡。简单几步，让你的日记更高效、更有条理。

# Obsidian 日记工作流：待办、闪念与打卡的高效管理

## Obsidian 插件准备
* 待办管理：[[obsidian-tasks]],支持创建视图，比如按标签分组统计一周内完成的待办
* 待办管理 - 时间线视图：[tasks-calendar-wrapper](obsidian://show-plugin?id=tasks-calendar-wrapper)，用于查看当天待办，安排未来的待办安排；
* 周期笔记：[periodic-notes](obsidian://show-plugin?id=periodic-notes)，生成每天的日记；
* 笔记模板：[[obsidian-templater]]，按模板生成日记，自动化移动昨天未完成的待办到当天

## 日记写些什么内容？
牛马的自我修养：每天的生活都要用心搬转，努力思考和强身健体。

我的日记含 3 部分：memos，checks，tasks；

### memos- 闪念
按 `GDD` 思维模式， 记录一天的所思所想，内心所有的不平静，包括收获的喜悦和莫名的忧伤，`允许一切发生，让他们自然流淌`。
* `G(Good)`：今天从书本/他人/网络上学了哪些感觉有用的，遇到什么有趣的事，有些什么炫酷炸裂的想法，哪些觉得自己今天做得不错的。
* `D(Difficult )`：今天一天遇到了什么问题/挑战，身体或精神状态上不适的地方，记录自己为什么有这样的思考？
* `D(Different)`：这一天，哪些可以改善，如何改善，有对自己/其他人哪些期待

### checks- 打卡
* 对尚未形成的习惯进行打卡跟踪，比如运动，阅读，知识整理。
* 有些习惯形成了就不需要再去打卡了，已经成了生活的一部分，比如我在多邻国学习英语，已经打了 557d 了，超过 1 年的习惯都可以从 checks 移走。

### tasks- 待办
1. 日常工作：由于会和技术/产品/业务方等各种人打交道，随时会冒出一个让你做的事情，询问好啥时候需要，不紧急的立刻记录待办，然后立刻忘掉它，继续做自己当下的事情，这样能很好的 `避免被人打断`，`也不会遗漏事情`；
2. 个人项目：专门建一个 inbox.md ，随时记录自己想做的事情；

## 日记模板配置
### 日记模板
diary.md，放在一个 template 目录

```markdown
# memos
* #good 今天从书本/他人/网络上学了哪些感觉有用的，遇到什么有趣的事，有些什么炫酷炸裂的想法，哪些觉得自己今天做得不错的。
* #difficult 今天一天遇到了什么问题/挑战，身体或精神状态上不适的地方，记录自己为什么有这样的思考？
* #different 这一天，哪些可以改善，如何改善，有对自己/其他人哪些期待

# checks
- [ ] #task #健身 金鸡独立
- [ ] #task #健身 乒乓

# tasks
- [ ] #task todo
```

template 插件配置

![[diary-template.png]]

## 实战问题

### 昨天未完成的待办怎么移动到今天？
每天总有没干完的，之前都是手动剪切过来，每天花 1 分钟，一年就得花 6 小时，对重复的劳动保持警惕，
于是某个晚上，花费 30 分钟调试好了自动化的模板脚本，自动将昨天未完成 tasks 转移到今天。

每天 obsidian 打开时，会自动按木板创建当天的日记文件，然后执行这个任务迁移的模板脚本

#### 未完成待办的处理指令
![[obsidian-gtd-diary-image-20250319-1.png|812x437]]

#### 未完成待办的处理模板
yesterday-tasks-undo.md

> 注意，linter 插件要配置忽略这个模板目录，避免添加上自定义 yaml 头

```bash
<%*
// 工具函数：动态生成日记文件路径
function getDailyNotePath(dateStr) {
  const [year, month, day] = dateStr.split("-");
  return `Diary/${year}/${year}-${month}-${day}.md`; // 格式：Diary/2024/2024-05-20.md
}

// 步骤1：读取文件内容
async function readFileContent(filePath) {
  try {
    const targetFile = tp.file.find_tfile(filePath);
    return await app.vault.read(targetFile);
  } catch (error) {
    console.log(`读取文件 ${filePath} 内容失败:`, error);
    return "";
  }
}

// 步骤2：提取未完成的 #task 任务
function extractUnfinishedTasks(content) {
  const taskRegex = /- \[ \] .*?#task.*?\n/g; // 匹配未完成的 #task 任务
  return content.match(taskRegex) || [];
}

// 步骤3：将任务追加到今日文件中
async function appendTasksToTodayFile(todayFilePath, tasks) {
  if (tasks.length === 0) return; // 如果没有任务，直接返回

  // 检查今日文件是否存在，不存在则创建
  const fileExists = await tp.file.exists(todayFilePath);
  if (!fileExists) {
    await app.vault.create(todayFilePath);
  }

  // 获取文件对象并追加任务
  const file = app.vault.getAbstractFileByPath(todayFilePath);
  if (file) {
    const currentContent = await app.vault.read(file);
    const newContent = currentContent + "\n" + tasks.join(""); // 在文件末尾追加任务
    await app.vault.modify(file, newContent);
    console.log("✅ 未完成任务已追加到今日文件中。");
  } else {
    console.log("❌ 今日文件未找到！");
  }
}

// 步骤4：从昨日文件中删除未完成任务
async function removeTasksFromYesterdayFile(yesterdayFilePath, tasks) {
  if (tasks.length === 0) return; // 如果没有任务，直接返回

  try {
    const targetFile = tp.file.find_tfile(yesterdayFilePath);
    let yesterdayContent = await app.vault.read(targetFile);

    // 使用正则替换删除未完成任务
    const updatedContent = yesterdayContent.replace(/- \[ \] .*?#task.*?\n/g, "");
    await app.vault.modify(targetFile, updatedContent);
    console.log("✅ 未完成任务已从昨日文件中删除。");
  } catch (error) {
    console.log("❌ 删除未完成任务时出错:", error);
  }
}

// 主函数：执行任务迁移逻辑
async function moveUndo() {
  // 获取昨日和今日的文件路径
  const todayDate = tp.date.now("yyyy-MM-DD");
  const yesterdayDate = tp.date.yesterday("yyyy-MM-DD");
  const yesterdayFilePath = getDailyNotePath(yesterdayDate);
  const todayFilePath = getDailyNotePath(todayDate);

  // 读取昨日文件内容
  const yesterdayContent = await readFileContent(yesterdayFilePath);

  // 提取未完成的 #task 任务
  const unfinishedTasks = extractUnfinishedTasks(yesterdayContent);

  // 将任务追加到今日文件中
  await appendTasksToTodayFile(todayFilePath, unfinishedTasks);

  // 从昨日文件中删除未完成任务
  await removeTasksFromYesterdayFile(yesterdayFilePath, unfinishedTasks);
}

// 执行主函数
await moveUndo();
%>
```

#### 未完成待办的处理录屏
![[obsidian-gtd-diary.mp4]]

## 日记文件多了如何管理？
写一年日记就会产生 365 个文件，10 年就 3650 个，文件多了检索效率低，查阅也不方便
按周聚合，自动汇聚日记，然后清理掉日记文件；
按年归档到 archive 目录；

至于日记怎么汇总到周总结，按原子笔记的要求，超出这个文章的范围，下次我们专门再分享如何按周的总结，包括每周的初始安排，执行时的待办统计，打卡情况。

## 总结

📚 搭建知识库就像拼乐高，每天攒点碎片，年底就能拼出专属思维城堡！

而用 Obsidian 写日记，真的可以很轻松。`待办自动迁移、闪念随手记、打卡随时跟踪`，这套工作流让我每天少花很多时间在琐事上。
如果你也想让日记变得更高效，不妨试试这些方法，说不定会有意想不到的收获。

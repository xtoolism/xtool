---
comment: true
title: NAS+Ollama 打造本地化 DeepSeek AI 实验室
created: 2025-02-18 22:02:00
modified: 2025-02-19 12:02:62
tags: [AI, DeepSeek, NAS]
draft: false
---

# NAS+Ollama 打造本地化 DeepSeek AI 实验室

基于 NAS 私有化部署 Ollama 和 open-webui 开源框架，打造低成本私有 AI 实验室

---

# 项目速览
* 🌐 传送门：
	* ollama: <https://github.com/ollama/ollama>
	* open-webui: <https://github.com/open-webui>
* 👨 **维护现状**：github 顶流项目，非常活跃
* 🛠️ **核心功能**：  
	* 📚 支持 150+ 开源模型 : ollama library 有大量最新的模型，一键 pull 即可使用
	* 🖥️ ChatGPT 同款交互： open-webui
	* 👍 多模态：支持联网搜索，语音，图片，文件等
*  📦 **部署方式**：
	* Docker 一键部署（NAS 首选方案）
	* 在线脚本一键安装

![open-webui-demo](ollama-web-demo.gif)
---

# 场景定位
## 🙋 推荐人群
* ✅ NAS 钉子户：4G 显卡就都能跑的 AI 神器
* ✅ 开发大咖：新模型随时远程开测
* ✅ 教育先锋：零门槛开展 AI 教学实践

## 🚨 劝退指南
* ❌ 图形界面依赖症（需要敲三行命令）
* ❌ 8G 内存守财奴（建议 16G+ 起步）
* ❌ 商业级需求（满血版请右转充值）
# 技术透视
## 💡小白解读  
> 🤖相当于把「AI 研究所」塞进你家机柜，用树莓派的价格享受云计算厂的快乐  
> 💰技术收益：比云服务便宜 90%，响应速度提升 3 倍！
## 🥇技术亮点
1. 本地化部署与隐私安全：不怕隐私数据被曝光了，还不花钱
2. 硬件优化与性能：量化做的好，4G 显卡也能跑 7b/14b 的 deepseek
3. 全平台兼容与开发友好：易用性强，api 也丰富，
4. 产品化程度高：ollama+open web-ui 非常成熟，很容易部署，而 lobechat 这类开源部署组件依赖多，折腾半天都起不来

# 快速上手
## 🐣 萌新急救包
### ollama
```bash
# windows/mac到官网下载安装包
https://ollama.com/download

# linux本地安装
curl -fsSL https://ollama.com/install.sh | sh

```
### open-webui
```yaml
version: '3.9'
services: 
  ollama-webui:
    image:  ghcr.io/open-webui/open-webui:main
    container_name: ollama-webui
    restart: always
    ports:
      - 18080:8080
    environment:
      - OLLAMA_BASE_URL=http://192.168.68.100:11434
      - HF_ENDPOINT=https://hf-mirror.com
      - WEBUI_SECRET_KEY=xxx
    volumes:
      - ./ollama-open-webui:/app/backend/data
```

安装好后，在登录 open-webui (<http://localhost:18080>) ,在设置里面安装模型，然后就可以测试下 AI 的弱智指数  
![[ollama-1739891610925.jpeg]]

测试 ： 被门夹过的核桃，还能补脑吗？
> 1.5b 幻觉太严重，7b 基本能玩玩，不会错的太离谱

![[ollama-1739891003391.jpeg]]  

## 🧙 老司机骚操作

### 服务配置
修改服务配置：
* Environment="OLLAMA_HOST=0.0.0.0:12345"，开启所有网卡可访问
* Environment="OLLAMA_ORIGINS=*"，避免跨域  
配置文件位置：` /etc/systemd/system/ollama.service`
```c

[Unit]
Description=Ollama Service
After=network-online.target

[Service]
ExecStart=/usr/bin/ollama serve
User=ollama
Group=ollama
Restart=always
RestartSec=3
Environment="OLLAMA_HOST=0.0.0.0:12345"
Environment="OLLAMA_ORIGINS=*"
Environment="PATH=/root/.autojump/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

[Install]
WantedBy=default.target
```

改好后可手动启动
```bash
ps -ef | grep ollama | awk '{print $2}' | xargs -I {} kill {}
export OLLAMA_HOST=0.0.0.0:11434 && export OLLAMA_ORIGINS=* && nohup ollama serve > ollama.log &
ps -ef | grep ollama
```

### 安装模型
```bash
# 查看版本
➜  ~ ollama -v
ollama version is 0.5.8-rc10

# 安装模型
ollama pull deepseek-r1:7b

# 查看模型 ，也可到https://ollama.com/library搜索模型
➜  ~ ollama ls
NAME                       ID              SIZE      MODIFIED      
deepseek-coder:6.7b        ce298d984115    3.8 GB    7 days ago       
deepseek-r1:32b            38056bbcbb2d    19 GB     8 days ago       
deepseek-r1:14b            ea35dfe18182    9.0 GB    9 days ago       
deepseek-r1:7b             0a8c26691023    4.7 GB    12 days ago      
deepseek-r1:1.5b           a42b25d8c10a    1.1 GB    12 days ago      
nomic-embed-text:latest    0a109f422b47    274 MB    12 months ago
```

也可以自己接入第三方厂商大模型的 api key （得有 http_proxy 代理）  
![[ollama-doggy.gif]]

### 测试模型
部署好后就可有使用 http 接口测试
```bash
curl http://localhost:11434/api/generate -d '{
  "model": "deepseek-r1:7b",
  "prompt":"为什么天空是蓝色的?"
}' | jq
```

也可直接在命令行直接运行模型
```bash
➜  ~ ollama run deepseek-r1:14b 
>>> 孙悟空打石头，算殴打父母吗？
<think>
嗯，这个问题挺有意思的。首先，用户问的是“孙悟空打石头，算殴打父母吗？”我得先理解一下这个问题。孙悟空是中国神话里的一个角色，他通常被描绘成一个非常勇敢和强大的猴子。石头在这里可能是
指他的家乡或者某种象征物。
...此处略去500字...
最后，我觉得这个问题主要是在考察对词语的理解和逻辑推理能力，同时也可能涉及到对中国神话故事的了解。总的来说，孙悟空打石头并不算作殴打父母，因为两者在本质上是不同的概念。
</think>

根据您的问题，“孙悟空打石头”是否构成“殴打父母”，可以得出以下结论：

1. **定义明确**：
   - “殴打父母”是指对有生命的、具有亲属关系的父母进行身体攻击或伤害的行为。
   - 石头是一种无生命物体，因此不属于“父母”的范畴。

2. **神话背景**：
   - 在《西游记》中，孙悟空是从一块被称为“仙石”的石头中诞生的。这块石头象征着他的起源，而不是有生命的父母。
...此处略去500字...

综上所述，“孙悟空打石头”并不构成“殴打父母”的情形，两者在定义和性质上有本质区别。
```

### NAS 配置
附上我捡垃圾配的 NAS，系统使用的是 truenas scale，底层上是基于 k3s，一个 k8s 的简化版，强大的一塌糊涂。开通公网后，搞个免费域名，就可以作为自己长期的私有云服务器了。  
![[ollama-1739895151015.jpeg]]

一张省电的上古显卡 : 微星 GTX 1650 D6 万图师 -4G 显存 ，TDP 只有 75W
```bash
# 查看显存情况
➜  ~ nvidia-smi

+-----------------------------------------------------------------------------+
| NVIDIA-SMI 515.65.01    Driver Version: 515.65.01    CUDA Version: 11.7     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  NVIDIA GeForce ...  Off  | 00000000:03:00.0 Off |                  N/A |
| 23%   34C    P8    12W /  75W |      3MiB /  4096MiB |      0%      Default |
|                               |                      |                  N/A |
+-----------------------------------------------------------------------------+
```
---

# 📊 深度评测

| 维度       | Ollama + Open WebUI 🚀 | JAN，LMStudio⚡    |
| -------- | ---------------------- | ---------------- |
| **硬件要求** | 自动适配机器量化参数             | 按硬件选模型           |
| **模型生态** | ollama library         | huggingface 开源模型 |
| **部署难度** | docker 自动化             | 单击程序限本地使用        |
| **交互体验** | chatgpt 一致的 Web 交互     | 有一点习惯成本          |
| **氪金指数** | 真·零成本                  | 零成本（得科学上网）       |

📌 **总结**  
在家用 NAS 或闲置电脑上部署 AI 系统，用 ollama+open-webui 这对王炸组合就够啦！  
可拓展性简直开挂 ：  
联网权限｜文档搜索｜语音交互｜智能体工具

而且部署复杂度低，产品易用性好，操作丝滑得就像在用 ChatGPT 企业版 。

📢下期预告：  
《Obsidian+DeepSeek 终极联动指南》,  
让 Obsidian 作为 AI 聊天的客户端，沉浸式书写，无需切换到其他平台去生成总结

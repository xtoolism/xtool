---
title: MCP协议解读：MCP-Server通信原理（SSE）
aliases: [MCP 协议解读：MCP-Server 通信原理（SSE）]
tags: [MCP]
created: 2025-04-22T11:26:28
updated: 2025-10-02T10:40:09
draft: false
---

# MCP协议解读：MCP-Server通信原理（SSE）
![[file-20251002111753384.png]]
MCP 协议的核心设计，是围绕「**一个长连接，两类接口**」构建的高效通信模型。本文将结合流程图，带你全面理解 MCP-Server 的通信机制与底层实现。

## 什么是 MCP 的 SSE 通信模型？

MCP 协议在基于 SSE（Server-Sent Events）实现时，可以归纳为：

- **1 个长连接**：客户端通过 SSE 建立服务端到客户端的单向消息流；
- **2 个接口**：
  - `GET /sse`：用于建立长连接并接收服务端消息；
  - `POST /message`：客户端发送请求、响应或通知。

> ✅ **优势**：连接稳定、延迟低、天然支持事件流，适用于 AI 工具类应用中持续会话与异步结果返回等场景。

## 接口详解

### 1. `GET /sse`：建立 SSE 长连接

客户端通过该接口与服务端建立 SSE 连接，服务端创建并关联以下对象：

- `SseEmitter`：用于控制消息推送；
- `McpServerSession`：维护当前会话的上下文状态。

```kotlin
val sessions = ConcurrentHashMap<String, McpServerSession>()  // 会话状态存储
val emitters = ConcurrentHashMap<String, SseEmitter>()         // SSE 连接存储
```

### 2. `POST /message`：客户端主动发消息

支持三种消息类型：
- `Request`：如请求工具列表、调用模型；
- `Response`：客户端对服务端通知的响应；
- `Notification`：客户端状态上报（如心跳 ping）。

## SSE 通信全流程详解

下面的流程图展示了客户端和 MCP-Server 从连接到通信的全过程：
![[file-20251002111753536.png]]

```mermaid
sequenceDiagram
    participant Client
    participant Server
    participant Sessions as Map<String, McpServerSession>
    participant Emitters as Map<String, SseEmitter>
    participant Handlers as RequestHandler

    %% Phase 1: Connection Establishment
    rect rgb(240, 248, 255)
    note right of Client: 阶段一：连接建立
    Client->>Server: GET /sse
    Server->>Emitters: 创建并存储 SseEmitter
    Server->>Sessions: 创建并存储 McpServerSession
    Server-->>Client: 返回 SSE 连接及 /message 接口地址
    end

    %% Phase 2: Session Initialization
    rect rgb(255, 248, 240)
    note right of Client: 阶段二：会话初始化
    Client->>Server: POST /message (InitializeRequest)
    Server->>Sessions: 获取 McpServerSession
    Server->>Emitters: 获取对应 SseEmitter
    Server-->>Client: SSE 返回 InitializeResponse
    end

    %% Phase 3: Resource Management
    rect rgb(240, 255, 240)
    note right of Client: 阶段三：资源请求
    Client->>Server: POST /message (tools/list)
    Server->>Sessions: 处理请求
    Server->>Handlers: 调用工具处理器
    Server->>Emitters: 推送处理结果
    Server-->>Client: SSE 返回工具列表
    end

    %% Phase 4: Connection Maintenance
    rect rgb(248, 240, 255)
    note right of Client: 阶段四：连接维持
    Client->>Server: POST /message (ping)
    Server->>Sessions: 更新心跳时间
    Server->>Emitters: 推送 pong 响应
    Server-->>Client: SSE 返回 pong
    end

    %% Phase 5: Tool Execution
    rect rgb(255, 240, 245)
    note right of Client: 阶段五：工具调用
    Client->>Server: POST /message (tools/call)
    Server->>Handlers: 根据 method 调用具体工具处理器
    Handlers-->>Server: 返回调用结果
    Server->>Emitters: 推送执行结果
    Server-->>Client: SSE 返回工具调用结果
    end

    %% Phase 6: Connection Termination
    rect rgb(245, 245, 245)
    note right of Client: 阶段六：连接关闭
    Client->>Server: 主动断开连接
    Server->>Emitters: 移除 SseEmitter
    Server->>Sessions: 移除 Session
    end
```

## 实际工作过程总结
1. **连接建立**
    - 客户端请求 `/sse`；
    - 服务端初始化 `SseEmitter` 和 `McpServerSession`，返回可用的消息接口地址。
2. **会话初始化**
    - 客户端通过 `/message` 发送 `InitializeRequest`，告知能力与标识；
    - 服务端处理后通过 SSE 返回 `InitializeResponse`。
3. **资源管理**
    - 客户端发起如 `tools/list` 请求；
    - 服务端从会话中查找状态，调用工具处理器并通过 SSE 返回结果。
4. **调用工具**
    - 客户端拼接 prompt 后发起 `tools/call`；
    - 服务端查找处理器执行逻辑，并通过 SSE 返回执行结果。
5. **连接维持**
    - 客户端周期性发送 `ping`；
    - 服务端返回 `pong`，用于保持连接活跃。
6. **连接关闭**
    - 客户端主动断开；
    - 服务端清理对应的连接与会话状态。

## 总结
从早期的 `stdio` 单机协议演进到 `SSE` 网络协议，是自然的扩展。但在实践中，SSE 仍存在以下问题：
1. 不支持断线重连（缺乏恢复机制）；
2. 服务端需长时间维护高并发连接，资源压力大；
3. 服务端消息只能单向推送，缺乏灵活性。

目前由于 `mcp-java-sdk` 暂未支持新版 `Streamable HTTP` 协议，我们仍采用 SSE 实现。但随着生态演进，**MCP 社区已逐步升级至 `Streamable HTTP` 通信机制**，在下一个版本中，我们也将进行相应迁移，解决当前 SSE 的局限。

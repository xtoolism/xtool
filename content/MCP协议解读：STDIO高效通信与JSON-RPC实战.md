---
draft: false
title: MCP协议解读：STDIO高效通信与JSON-RPC实战
aliases: [MCP 协议解读：STDIO 高效通信与 JSON-RPC 实战]
tags: []
created: 2025-04-02T08:13:33
updated: 2025-05-10T09:59:36
---
![[cover-mcp-stdio.png|1024x436]]
本文深度解析 MCP 协议的传输机制与消息格式，涵盖 stdio、SSE 及自定义传输方式，剖析 JSON-RPC 2.0 的请求、响应与通知设计。
结合 RooCode 开源实现与天气查询案例，揭秘如何通过 MCP 实现跨进程通信与高效服务集成，为开发者提供从协议原理到落地实践的完整指南。

# MCP 协议解读：STDIO 高效通信与 JSON-RPC 实战

## Standard Input/Output (stdio)
stdio 传输允许通过标准输入和输出流进行通信。这对于本地集成和命令行工具特别有用。

使用 stdio 的情况：
- 构建命令行工具
- 实现本地集成
- 需要简单的进程通信
- 使用 shell 脚本

### server 示例

```python
app = Server("example-server")

async with stdio_server() as streams:
    await app.run(
        streams[0],
        streams[1],
        app.create_initialization_options()
    )
```

### client 示例

```python
params = StdioServerParameters(
    command="./server",
    args=["--option", "value"]
)

async with stdio_client(params) as streams:
    async with ClientSession(streams[0], streams[1]) as session:
        await session.initialize()
```

## Server-Sent Events (SSE)
SSE 传输通过 HTTP POST 请求实现服务器到客户端的流式传输，并支持客户端到服务器的通信。
目前非本地程序开发，都可使用 SSE 实现，已有的 HTTP 接口都可方便的改下 Controller 层对外提供服务。
不过 MCP 目前官方还没有标准的鉴权方式（roadmap 已规划），只能每个 mcp-server 通过参数自定义实现

支持使用 SSE 的情况：
- 仅需要服务器到客户端的流式传输
- 在受限网络中工作
- 实现简单更新

### server 示例

```python
from mcp.server.sse import SseServerTransport
from starlette.applications import Starlette
from starlette.routing import Route

app = Server("example-server")
sse = SseServerTransport("/messages")

# Define handler functions
async def handle_sse(scope, receive, send):
    async with sse.connect_sse(scope, receive, send) as streams:
        await app.run(streams[0], streams[1], app.create_initialization_options())

async def handle_messages(scope, receive, send):
    await sse.handle_post_message(scope, receive, send)
    
# Create and run Starlette app
starlette_app = Starlette(
    routes=[
        Route("/sse", endpoint=handle_sse),
        Route("/messages", endpoint=handle_messages, methods=["POST"]),
    ]
)
```

### client 示例

```python
async with sse_client("http://localhost:8000/sse") as streams:
    async with ClientSession(streams[0], streams[1]) as session:
        await session.initialize()
```

## 自定义传输协议
MCP 使得实现针对特定需求的自定义传输变得简单。任何传输实现只需符合传输接口：
您可以实现自定义传输，用于：
- 自定义网络协议
- 专用通信通道
- 与现有系统集成
- 性能优化

### 示例

```python
@contextmanager
async def create_transport(
    read_stream: MemoryObjectReceiveStream[JSONRPCMessage | Exception],
    write_stream: MemoryObjectSendStream[JSONRPCMessage]
):
    """
    Transport interface for MCP.

    Args:
        read_stream: Stream to read incoming messages from
        write_stream: Stream to write outgoing messages to
    """
    async with anyio.create_task_group() as tg:
        try:
            # Start processing messages
            tg.start_soon(lambda: process_messages(read_stream))

            # Send messages
            async with write_stream:
                yield write_stream

        except Exception as exc:
            # Handle errors
            raise exc
        finally:
            # Clean up
            tg.cancel_scope.cancel()
            await write_stream.aclose()
            await read_stream.aclose()
```

## 消息格式 JSON-RPC
MCP 使用 [JSON-RPC](https://www.jsonrpc.org/) 2.0 作为其传输格式。

### JSON-RPC
目前存在两种 JSON-RPC 规范，分别是 JSON-RPC 1.0 和 JSON-RPC2.0。
- JSON-RPC 1.0 在多个方面缺乏实用性，特别是缺少名称参数和错误消息解释，引起的麻烦超出了预期。使得它更像是一种点对点的交流方式。
- JSON RPC 2.0 规范则解决了 1.0 版本的缺陷，表现得更加先进。使用客户机 - 服务器模式，同时增加了多种传输方式的支持。

具体区别：
- **结构变化**：2.0 版本引入了强制性的 `jsonrpc`:"2.0" 字段，将 `id` 字段变为可选，并规范了响应结构（成功必须有 `result`，错误必须有 `error`）。
- **功能增强**：2.0 版本新增了 `批处理功能`，改进了 `通知机制`，并支持两种参数传递方式（按位置的数组和按名称的对象）。
- **错误处理优化**：2.0 版本标准化了 `错误对象格式`（code, message, data）并定义了预设错误代码范围，使错误处理更规范和一致。

MCP 的传输层负责将 MCP 协议消息转换为 JSON-RPC 格式进行传输，并将接收到的 JSON-RPC 消息转换回 MCP 协议消息。
MCP 的 RPC 消息有请求，响应，通知 3 种类型。

### 请求 Requests

```typescript
{
  jsonrpc: "2.0",
  id: number | string,
  method: string,
  params?: object
}
```

客户端请求类型

```python
class ClientRequest(
    RootModel[
        PingRequest
        | InitializeRequest
        | CompleteRequest
        | SetLevelRequest
        | GetPromptRequest
        | ListPromptsRequest
        | ListResourcesRequest
        | ListResourceTemplatesRequest
        | ReadResourceRequest
        | SubscribeRequest
        | UnsubscribeRequest
        | CallToolRequest
        | ListToolsRequest
    ]
):
    pass
```

### 响应 Responses

```typescript
{
  jsonrpc: "2.0",
  id: number | string,
  result?: object,
  error?: {
    code: number,
    message: string,
    data?: unknown
  }
}
```

服务端响应类型

```python
class ServerResult(
    RootModel[
        EmptyResult
        | InitializeResult
        | CompleteResult
        | GetPromptResult
        | ListPromptsResult
        | ListResourcesResult
        | ListResourceTemplatesResult
        | ReadResourceResult
        | CallToolResult
        | ListToolsResult
    ]
):
    pass
```

### 通知 Notifications

```typescript
{
  jsonrpc: "2.0",
  method: string,
  params?: object
}
```

通知类型

```python
# 客户端通知
class ClientNotification(
    RootModel[
        CancelledNotification
        | ProgressNotification
        | InitializedNotification
        | RootsListChangedNotification
    ]
):
    pass

# 服务端通知
class ServerNotification(
    RootModel[
        CancelledNotification
        | ProgressNotification
        | LoggingMessageNotification
        | ResourceUpdatedNotification
        | ResourceListChangedNotification
        | ToolListChangedNotification
        | PromptListChangedNotification
    ]
):
    pass
```

## MCP 开源实现分析 -Cline/RooCode
1. 每个 vscode 实例启动时，插件 RooCode 都会自动启动 2 个进程。
2. RooCode 支持配置全局的 MCP-Server，也支持在 Projet 级别配置 MCP-Server,从而实现按项目隔隔离参数配置；

### MCP 客户端配置

```json
{
  "MCPServers": {
    "weather": {
      "command": "uv",
      "args": [
        "--directory",
        "/mnt/github/MCP/weather",
        "run",
        "weather.py"
      ],
      "alwaysAllow": [
        "get_forecast",
        "get_alerts"
      ],
      "disabled": false
    }
  }
}
```

### 客户端进程分析
1. `uv` 作为父进程，负责运行和管理 mcp-server
2. `MCP.run(transport='stdio')` 使用 python 虚拟环境运行 weather.py，对外使用 stdio 通信
py

```bash
# ps -ef --forest | grep weather.py
## `uv` 是一个进程管理工具，它负责启动和管理子进程（在这里是 weather.py）。它本身会作为一个父进程存在。
\_ uv --directory /mnt/github/MCP/weather run weather.py
## 初始化了 `FastMCP` 服务，并通过 `MCP.run(transport='stdio')` 开启了一个基于标准输入/输出的通信服务。
    \_ /mnt/github/MCP/weather/.venv/bin/python3 weather.py
```

### MCP-Server 开发示例 - 天气查询
![[file-20250403073404.mp4]]

### 结语
看完这篇解析，是不是对 MCP 协议的设计思路更清晰了？无论是本地命令行工具还是分布式服务，MCP 都能用灵活的传输方式和标准的 `JSON-RPC` 帮你 " 搭桥 "。
如果你正头疼进程通信或服务集成，不妨试试 MCP 框架——毕竟，好的协议就像隐形的桥梁，默默支撑着每一次高效交互。:)
今天分享的主要是传输层的实现细节，宏观的 MCP 工作原理见昨天分享的 [模型无关的AI集成革命：MCP协议解读](https://mp.weixin.qq.com/s/GuyMTblmHAHNlbRwXtdJGw)。

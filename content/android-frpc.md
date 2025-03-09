---
draft: false
title: 如何解决 frpc 在 Android 上 DNS 解析问题
aliases: [如何解决 frpc 在 Android 上 DNS 解析问题]
tags: [Android, frp]
created: 2025-03-07T12:55:48
updated: 2025-03-09T14:12:37
---

# 如何解决 frpc 在 Android 上 DNS 解析问题
android 由于缺少 /etc/resolv.conf 文件，frpc 默认尝试使用 localhost:53 进行 DNS 解析，导致连接失败，最终通过脚本自动解析域名并将结果写入 frpc 配置文件。希望本文能帮助其他在 Android 上使用 frpc 的用户解决类似问题。

## 问题日志

```bash
2025-03-07 00:52:17.436 [I] [sub/root.go:142] start frpc service for config file [frpc.toml]
2025-03-07 00:52:17.436 [I] [client/service.go:295] try to connect to server…
2025-03-07 00:52:17.438 [W] [client/service.go:298] connect to server error: dial tcp: lookup xtool.duckdns.org on [::1]:53: read udp [::1]:54057->[::1]:53: read: connection refused
```

### 问题定位
根据 src/net/dnsclient_unix.go 文件中的逻辑，如果 /etc/resolv.conf 不存在，则默认使用 localhost:53 作为 DNS 服务器。

```bash
Just create /etc/resolv.conf and append nameserver 8.8.8.8 then this problem will be resolved.

According to src/net/dnsclient_unix.go, if /etc/resolv.conf is absent, localhost:53 is chosen as a name server.

Since the Linux in Android is not so "standard". /etc/resolv.conf is not available. The app then just keep looking up host in localhost:53.
```

### 问题解决
1. 域名换 ip 解决
2. 解决 android 的 dns 解析问题

暂时没解决 dns 解析问题，dig 能通，frpc 不行。
所以我写个脚本将域名解析结果写入 frpc 的配置即可正常启动了。

run.sh

```bash
# 定义域名变量
DOMAIN="xtool.duckdns.org"

# 获取 IP 地址
IP=$(dig +short $DOMAIN)

echo $DOMAIN "ip is " $IP

# 使用 sed 替换并覆盖 frpc.toml 文件
sed "s/MY_SERVER/$IP/" frpc.toml.tmpl > frpc.toml

# 启动sshd和frpc
sshd && nohup ./frpc -c frpc.toml > frpc.log &

# 查看日志
tail -200f frpc.log
```

`sh run.sh` 启动即可
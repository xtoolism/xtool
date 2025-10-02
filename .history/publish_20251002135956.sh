#!/bin/bash
set -ex

# 变量定义
SRC_BASE="/mnt/gogs/kbase/01Project/Blog/content"
DST_BASE="/mnt/github/xtool/content"
DIRS=(AI Tool Obsidian Thought)
MD_FILES=(index.md 极客工具.md)

# 使用rsync同步目录内容，确保严格一致
echo "开始同步目录内容..."
for dir in "${DIRS[@]}"; do
  rsync -av --delete "$SRC_BASE/$dir/" "$DST_BASE/$dir/"
done

# 复制单个文件
echo "复制单个文件..."
for file in "${MD_FILES[@]}"; do
  cp "$DST_BASE/$file" "$SRC_BASE/"
done

echo "同步完成，开始构建..."
cd /mnt/github/xtool
npx quartz build --serve

#!/bin/bash

set -ex

# 定义路径变量
SOURCE_DIR="/mnt/gogs/kbase/01Project/Blog/content"
TARGET_DIR="/mnt/github/xtool/content"
PROJECT_ROOT="/mnt/github/xtool"

# 使用空格分隔的字符串代替数组，提高兼容性
SYNC_DIRS="AI Tool Obsidian Thought"
COPY_FILES="index.md 极客工具.md"

# 使用rsync同步目录内容，确保严格一致
echo "开始同步目录内容..."

# 使用for循环处理空格分隔的字符串
for dir in $SYNC_DIRS; do
    echo "同步 $dir 目录..."
    rsync -av --delete "$SOURCE_DIR/$dir/" "$TARGET_DIR/$dir/"
done

# 复制单个文件
echo "复制单个文件..."
for file in $COPY_FILES; do
    echo "复制 $file..."
    cp "$TARGET_DIR/$file" "$SOURCE_DIR/"
done

echo "同步完成，开始构建..."
cd "$PROJECT_ROOT"
npx quartz build --serve

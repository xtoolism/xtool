#!/bin/bash

set -ex

# 定义路径变量
SOURCE_DIR="/mnt/gogs/kbase/01Project/Blog/content"
TARGET_DIR="/mnt/github/xtool/content"
PROJECT_ROOT="/mnt/github/xtool"

# 定义需要同步的目录列表
SYNC_DIRS=("AI" "Tool" "Obsidian" "Thought")

# 定义需要复制的单个文件列表
COPY_FILES=("index.md" "极客工具.md")

# 使用rsync同步目录内容，确保严格一致
echo "开始同步目录内容..."

for dir in "${SYNC_DIRS[@]}"; do
    echo "同步 $dir 目录..."
    rsync -av --delete "$SOURCE_DIR/$dir/" "$TARGET_DIR/$dir/"
done

# 复制单个文件
echo "复制单个文件..."
for file in "${COPY_FILES[@]}"; do
    echo "复制 $file..."
    cp "$TARGET_DIR/$file" "$SOURCE_DIR/"
done

echo "同步完成，开始构建..."
cd "$PROJECT_ROOT"
npx quartz build --serve

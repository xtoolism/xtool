#!/bin/bash

INPUT_FILE="/mnt/gogs/kbase/01Project/Blog/content/index.md"
OUTPUT_FILE="/home/geosmart/Downloads/index.docx"
LUA_FILTER="/mnt/gogs/kbase/02Area/工具/obsidian/scripts/no-image-alt.lua"
RESOURCE_PATH1="/mnt/gogs/kbase/01Project/Blog/content"
RESOURCE_PATH2="/mnt/gogs/kbase/01Project/Blog/content/files"
TEMP_FILE="/tmp/obsidian_converted.md"

# 预处理 Obsidian wikilinks 图片语法，转换成标准 Markdown 图片语法
perl -pe 's/!\[\[(.*?)(\|.*?)?\]\]/![]($1)/g' "$INPUT_FILE" > "$TEMP_FILE"

# 然后用 Pandoc 处理
pandoc "$TEMP_FILE" \
  --lua-filter="$LUA_FILTER" \
  -f markdown+raw_html \
  --resource-path="$RESOURCE_PATH1" \
  --resource-path="$RESOURCE_PATH2" \
  -o "$OUTPUT_FILE" \
  --standalone \
  --wrap=none \
  -t docx

# 删除临时文件
rm "$TEMP_FILE"

echo "转换完成: '$INPUT_FILE' -> '$OUTPUT_FILE'"

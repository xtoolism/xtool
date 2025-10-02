set -ex

# 变量定义
SRC_BASE="/mnt/gogs/kbase/01Project/Blog/content"
DST_BASE="/mnt/github/xtool/content"

# 使用rsync同步目录内容，确保严格一致
echo "开始同步目录内容..."

# 同步AI目录
rsync -av --delete "$SRC_BASE/AI/" "$DST_BASE/AI/"

# 同步Tool目录
rsync -av --delete "$SRC_BASE/Tool/" "$DST_BASE/Tool/"

# 同步Obsidian目录
rsync -av --delete "$SRC_BASE/Obsidian/" "$DST_BASE/Obsidian/"

# 同步Thought目录
rsync -av --delete "$SRC_BASE/Thought/" "$DST_BASE/Thought/"

# 复制单个文件
echo "复制单个文件..."
cp "$DST_BASE/index.md" "$SRC_BASE/"
cp "$DST_BASE/极客工具.md" "$SRC_BASE/"

echo "同步完成，开始构建..."
cd /mnt/github/xtool
npx quartz build --serve

set -ex

# 使用rsync同步目录内容，确保严格一致
echo "开始同步目录内容..."

# 同步AI目录
rsync -av --delete /mnt/gogs/kbase/01Project/Blog/content/AI/ /mnt/github/xtool/content/AI/

# 同步Tool目录
rsync -av --delete /mnt/gogs/kbase/01Project/Blog/content/Tool/ /mnt/github/xtool/content/Tool/

# 同步Obsidian目录
rsync -av --delete /mnt/gogs/kbase/01Project/Blog/content/Obsidian/ /mnt/github/xtool/content/Obsidian/

# 同步Thought目录
rsync -av --delete /mnt/gogs/kbase/01Project/Blog/content/Thought/ /mnt/github/xtool/content/Thought/

# 复制单个文件
echo "复制单个文件..."
cp /mnt/github/xtool/content/index.md /mnt/gogs/kbase/01Project/Blog/content/
cp /mnt/github/xtool/content/极客工具.md /mnt/gogs/kbase/01Project/Blog/content/

echo "同步完成，开始构建..."
cd /mnt/github/xtool
npx quartz build --serve

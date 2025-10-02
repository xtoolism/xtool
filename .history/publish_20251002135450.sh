set -ex

cd /mnt/github/xtool/content
rm -rf content/AI
rm -rf content/Tool
rm -rf content/Obsidian
rm -rf content/Thought

cd /mnt/gogs/kbase/01Project/Blog/content/
cp -r AI /mnt/github/xtool/content/
cp -r Tool /mnt/github/xtool/content/
cp -r Obsidian /mnt/github/xtool/content/
cp -r Thought /mnt/github/xtool/content/


cp /mnt/github/xtool/content/index.md /mnt/gogs/kbase/01Project/Blog/content/

cp /mnt/github/xtool/content/极客工具.md /mnt/gogs/kbase/01Project/Blog/content/

cd /mnt/github/xtool
npx quartz build --serve

sex -ex

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

npx quartz build --serve

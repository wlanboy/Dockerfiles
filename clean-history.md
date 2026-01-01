# clean git repro
How to clean a git repro from old files.

## create keep list
```bash
git clone https://github.com/wlanboy/Dockerfiles.git
cd Dockerfiles

git checkout main

git ls-files > keep.txt
```

## mirror clone
```bash
cd ..
git clone --mirror https://github.com/wlanboy/Dockerfiles.git Dockerfiles.git
cd Dockerfiles.git
```

## use python module
```bash
uv init
uv add git-filter-repo
uv run git-filter-repo --paths-from-file ../Dockerfiles/keep.txt --force
```

## push mirror clone
```bash
git remote add origin https://github.com/wlanboy/Dockerfiles.git
git push origin main --force
```
# clean git repro

Anleitung um alte/große Dateien aus der Git-Historie zu entfernen ohne den aktuellen Stand zu verlieren.

## create keep list

Aktuell getrackte Dateien als Behalte-Liste exportieren — diese bleiben in der Historie erhalten.

```bash
git clone https://github.com/wlanboy/Dockerfiles.git
cd Dockerfiles

git checkout main

git ls-files > keep.txt
```

## mirror clone

Vollständigen Klon mit allen Branches und Tags erstellen, damit `git-filter-repo` die gesamte Historie bearbeiten kann.

```bash
cd ..
git clone --mirror https://github.com/wlanboy/Dockerfiles.git Dockerfiles.git
cd Dockerfiles.git
```

## use python module

`git-filter-repo` rewritet die Historie und entfernt alle Dateien die nicht in `keep.txt` stehen.

```bash
uv init
uv add git-filter-repo
uv run git-filter-repo --paths-from-file ../Dockerfiles/keep.txt --force
```

## push mirror clone

Bereinigte Historie per Force-Push ins Remote-Repository übertragen.

```bash
git remote add origin https://github.com/wlanboy/Dockerfiles.git
git push origin main --force
```

## check for large files

Alle Blobs über 50 KB in der gesamten Historie finden und gezielt entfernen.

```bash
git rev-list --objects --all \
  | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' \
  | awk '$3 > 50000 && $1 == "blob" {print $0}' \
  | sort -k3 -n

uv run git-filter-repo --invert-paths --path filename --force
git remote add origin https://github.com/wlanboy/Dockerfiles.git
git push origin main --force
```

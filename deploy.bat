@echo off
echo === Committing to main ===

git remote remove origin 2>nul
git remote add origin https://github.com/mosinDataBase/MS-Square-Fitness.git

git add .
git commit -m "update site" 2>nul
git branch -M main
git push -f origin main

echo === Deploying to GitHub Pages ===

REM Push current folder contents to gh-pages branch directly
git push -f origin main:gh-pages

echo === Done ===
echo Visit: https://mosinDataBase.github.io/MS-Square-Fitness/
pause

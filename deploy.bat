@echo off
echo "== Initializing repo =="
echo "# MS Square Fitness" > README.md

IF NOT EXIST ".git" git init

git add .
git commit -m "new page"

git branch -M main

git remote remove origin 2>nul
git remote add origin https://github.com/mosinDataBase/MS-Square-Fitness.git

git push -u origin main

echo === Commit Complete ===

echo === Deploying to GitHub Pages ===

REM Clean up previous attempts
git worktree remove ..\gh-pages-tmp --force 2>nul
git branch -D gh-pages 2>nul

REM Create empty gh-pages branch using plumbing commands (no checkout needed)
git hash-object -t tree --stdin < nul > .tmp_tree.txt
set /p TREE_HASH=<.tmp_tree.txt
del .tmp_tree.txt

for /f %%i in ('git commit-tree %TREE_HASH% -m "init"') do set COMMIT_HASH=%%i
git branch gh-pages %COMMIT_HASH%

REM Attach worktree
git worktree add ..\gh-pages-tmp gh-pages

REM Copy site files
xcopy /Y index.html ..\gh-pages-tmp\ >nul
xcopy /Y styles.css ..\gh-pages-tmp\ >nul
xcopy /Y script.js ..\gh-pages-tmp\ >nul
xcopy /E /Y /I assets ..\gh-pages-tmp\assets >nul

REM Commit and push
cd ..\gh-pages-tmp
git add .
git commit -m "Deploy to GitHub Pages"
git push -f origin gh-pages

REM Cleanup
cd ..\ms-square-fitness-site
git worktree remove ..\gh-pages-tmp --force
git branch -D gh-pages

echo === Deployment Complete ===
echo Visit: https://mosinDataBase.github.io/MS-Square-Fitness/
pause

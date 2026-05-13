@echo off
echo 🚀 Starting deployment preparation...

REM Create deployment directory structure
set DEPLOY_DIR=deploy\atithi-app-bd
if exist "%DEPLOY_DIR%" rmdir /s /q "%DEPLOY_DIR%"
mkdir "%DEPLOY_DIR%"

echo 📁 Copying application files...

REM Copy essential Next.js files
xcopy /e /i /y "app\*" "%DEPLOY_DIR%\app\"
xcopy /e /i /y "components\*" "%DEPLOY_DIR%\components\"
xcopy /e /i /y "modules\*" "%DEPLOY_DIR%\modules\"
xcopy /e /i /y "utils\*" "%DEPLOY_DIR%\utils\"
xcopy /e /i /y "messages\*" "%DEPLOY_DIR%\messages\"
xcopy /e /i /y "public\*" "%DEPLOY_DIR%\public\"

REM Copy configuration files
copy /y "package.json" "%DEPLOY_DIR%\"
copy /y "package-lock.json" "%DEPLOY_DIR%\"
copy /y "next.config.js" "%DEPLOY_DIR%\"
copy /y "tailwind.config.js" "%DEPLOY_DIR%\"
copy /y "tsconfig.json" "%DEPLOY_DIR%\"
copy /y ".gitignore" "%DEPLOY_DIR%\"

REM Copy deployment configurations
xcopy /e /i /y ".github\*" "%DEPLOY_DIR%\.github\"
copy /y "docker-compose.yml" "%DEPLOY_DIR%\"
copy /y "Dockerfile" "%DEPLOY_DIR%\"
copy /y "vercel.json" "%DEPLOY_DIR%\"
copy /y "netlify.toml" "%DEPLOY_DIR%\"

REM Copy environment template
copy /y "env.example" "%DEPLOY_DIR%\"

REM Create deployment README
copy /y "deploy\README.md" "%DEPLOY_DIR%\"

echo 📦 Installing dependencies in deployment folder...
cd /d "%DEPLOY_DIR%"
call npm ci --production

echo 🏗 Building application...
call npm run build

echo ✅ Deployment preparation complete!
echo.
echo 📁 Deployment folder: %DEPLOY_DIR%
echo 🌐 Ready for deployment to:
echo    - GitHub Pages
echo    - Vercel
echo    - Netlify
echo    - Docker
echo.
echo 📋 Next steps:
echo 1. Push to GitHub repository
echo 2. Configure deployment platform
echo 3. Set environment variables
echo 4. Deploy!
pause

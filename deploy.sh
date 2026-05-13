#!/bin/bash

# Atithi App BD - Deployment Script
# This script copies all necessary files for deployment

set -e

echo "🚀 Starting deployment preparation..."

# Create deployment directory structure
DEPLOY_DIR="./deploy/atithi-app-bd"
rm -rf "$DEPLOY_DIR"
mkdir -p "$DEPLOY_DIR"

echo "📁 Copying application files..."

# Copy essential Next.js files
cp -r app/ "$DEPLOY_DIR/"
cp -r components/ "$DEPLOY_DIR/"
cp -r modules/ "$DEPLOY_DIR/"
cp -r utils/ "$DEPLOY_DIR/"
cp -r messages/ "$DEPLOY_DIR/"
cp -r public/ "$DEPLOY_DIR/"

# Copy configuration files
cp package.json "$DEPLOY_DIR/"
cp package-lock.json "$DEPLOY_DIR/"
cp next.config.js "$DEPLOY_DIR/"
cp tailwind.config.js "$DEPLOY_DIR/"
cp tsconfig.json "$DEPLOY_DIR/"
cp .gitignore "$DEPLOY_DIR/"

# Copy deployment configurations
cp -r .github/ "$DEPLOY_DIR/"
cp docker-compose.yml "$DEPLOY_DIR/"
cp Dockerfile "$DEPLOY_DIR/"
cp vercel.json "$DEPLOY_DIR/"
cp netlify.toml "$DEPLOY_DIR/"

# Copy environment template
cp env.example "$DEPLOY_DIR/"

# Create deployment README
cp deploy/README.md "$DEPLOY_DIR/"

echo "📦 Installing dependencies in deployment folder..."
cd "$DEPLOY_DIR"
npm ci --production

echo "🏗 Building application..."
npm run build

echo "✅ Deployment preparation complete!"
echo ""
echo "📁 Deployment folder: $DEPLOY_DIR"
echo "🌐 Ready for deployment to:"
echo "   - GitHub Pages"
echo "   - Vercel"
echo "   - Netlify"
echo "   - Docker"
echo ""
echo "📋 Next steps:"
echo "1. Push to GitHub repository"
echo "2. Configure deployment platform"
echo "3. Set environment variables"
echo "4. Deploy!"

# Atithi App BD - Deployment Guide

This folder contains all necessary files and configurations for deploying the Atithi App BD to GitHub and production environments.

## Deployment Structure

- `app/` - Next.js application files
- `public/` - Static assets and images
- `components/` - React components
- `modules/` - Feature modules (stays, experiences, services)
- `utils/` - Utility functions
- `messages/` - Internationalization files
- `package.json` - Dependencies and scripts
- `next.config.js` - Next.js configuration
- `tailwind.config.js` - Tailwind CSS configuration
- `.env.example` - Environment variables template

## Quick Start

1. Install dependencies:
   ```bash
   npm install
   ```

2. Set up environment variables:
   ```bash
   cp .env.example .env.local
   # Edit .env.local with your actual values
   ```

3. Run development server:
   ```bash
   npm run dev
   ```

4. Build for production:
   ```bash
   npm run build
   ```

5. Start production server:
   ```bash
   npm start
   ```

## Environment Variables

Required environment variables:
- `NEXT_PUBLIC_APP_URL` - Application URL
- `NEXT_PUBLIC_API_URL` - Backend API URL
- `DATABASE_URL` - Database connection string
- `NEXTAUTH_SECRET` - Authentication secret

## Deployment Platforms

### Vercel (Recommended)
1. Connect GitHub repository
2. Configure build command: `npm run build`
3. Configure output directory: `.next`
4. Add environment variables

### Netlify
1. Connect GitHub repository
2. Configure build command: `npm run build`
3. Configure publish directory: `out`
4. Add environment variables

### Docker
1. Build image: `docker build -t atithi-app .`
2. Run container: `docker run -p 3000:3000 atithi-app`

## GitHub Actions

Automatic deployment is set up via `.github/workflows/deploy.yml`

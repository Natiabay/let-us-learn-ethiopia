# Automatic Deployment Setup Guide

## 🚀 GitHub Actions + Vercel Automatic Deployment

Your project is already configured with a comprehensive GitHub Actions workflow that will automatically deploy your Flutter app to Vercel whenever you push to the main branch.

## 📋 Required Setup Steps

### 1. Vercel Account Setup
1. Go to [vercel.com](https://vercel.com) and sign in
2. Import your GitHub repository: `Natiabay/let-us-learn-Ethiopia-flutter`
3. Vercel will automatically detect it's a Flutter project

### 2. Get Vercel Credentials
After importing your project in Vercel:

1. **Get Vercel Token:**
   - Go to Vercel Dashboard → Settings → Tokens
   - Create a new token with appropriate permissions
   - Copy the token

2. **Get Project ID:**
   - In your Vercel project dashboard
   - Go to Settings → General
   - Copy the "Project ID"

3. **Get Organization ID:**
   - In Vercel project settings
   - Copy the "Team ID" or "Organization ID"

### 3. Configure GitHub Secrets
Go to your GitHub repository → Settings → Secrets and variables → Actions

Add these secrets:
- `VERCEL_TOKEN`: Your Vercel API token
- `VERCEL_PROJECT_ID`: Your Vercel project ID  
- `VERCEL_ORG_ID`: Your Vercel organization/team ID
- `FIREBASE_SERVICE_ACCOUNT`: (Optional) For Firebase deployment

### 4. Enable GitHub Actions
1. Go to your GitHub repository
2. Click on "Actions" tab
3. Enable GitHub Actions if not already enabled
4. The workflow will automatically run on the next push

## 🔄 How It Works

### Automatic Triggers:
- **Push to main/master**: Deploys to production
- **Pull Request**: Creates preview deployment
- **Manual trigger**: Available in Actions tab

### What Happens on Each Push:
1. ✅ **Test**: Runs Flutter tests and code analysis
2. 🌐 **Build Web**: Builds Flutter web app
3. 📱 **Build Android**: Creates APK and AAB files
4. 🍎 **Build iOS**: Creates iOS build (macOS required)
5. 🚀 **Deploy**: Automatically deploys to Vercel
6. 🔥 **Firebase**: (Optional) Also deploys to Firebase

## 🛠️ Current Workflow Features

Your workflow includes:
- **Multi-platform builds** (Web, Android, iOS)
- **Automatic testing** before deployment
- **Code analysis** and quality checks
- **Artifact uploads** for mobile builds
- **Dual deployment** (Vercel + Firebase)

## 🎯 Next Steps

1. **Set up Vercel project** (if not done)
2. **Add GitHub secrets** (VERCEL_TOKEN, VERCEL_PROJECT_ID, VERCEL_ORG_ID)
3. **Push a test commit** to trigger the workflow
4. **Monitor deployment** in GitHub Actions tab

## 🔍 Monitoring Deployments

- **GitHub Actions**: Check the "Actions" tab in your repository
- **Vercel Dashboard**: Monitor deployments and logs
- **Build Artifacts**: Download APK/AAB files from Actions

## 🆘 Troubleshooting

If deployment fails:
1. Check GitHub Actions logs
2. Verify all secrets are correctly set
3. Ensure Vercel project is properly configured
4. Check Flutter version compatibility

---

**Your app will automatically deploy to Vercel every time you push to the main branch!** 🎉

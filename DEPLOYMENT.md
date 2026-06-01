# Deployment Notes - LivePoll Politics

## Current Hosting
- Using Netlify (as of June 2026)

## How to Deploy (Netlify)

### Quick Method (Netlify Drop)
1. Run: `flutter build web --release`
2. Go to https://app.netlify.com/drop
3. Drag the entire `build/web` folder
4. Done. You'll get a public URL.

### Recommended Method (Proper Site)
1. Make sure you have Git set up and pushed to GitHub.
2. On Netlify:
   - New site from Git
   - Connect your GitHub repo
   - Build command: `flutter build web --release`
   - Publish directory: `build/web`
3. Netlify will auto-deploy on every push.

## Moving to Firebase Hosting Later
1. Build: `flutter build web --release`
2. Install Firebase CLI: `npm install -g firebase-tools`
3. Run: `firebase init hosting`
4. Set public directory to `build/web`
5. Deploy: `firebase deploy`

The `netlify.toml` file helps with redirects and build settings. 
When moving to Firebase, you can delete or ignore `netlify.toml`.

## Important Notes
- This is an early version with placeholder data.
- Real phone authentication and voting is not yet connected.
- Be transparent when sharing on X.

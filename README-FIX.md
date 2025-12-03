# ⚠️  READ THIS FIRST - Action Required

## Problem
The GitHub Actions release workflow is failing with this error:
```
Errored commit: 8be5746d19bdef5f696ce1d449a22b4689a45ee7
Commit message: 'Add MCP Catalog Trust Score badge'
Error: Missing commit type separator `:`
```

## Solution Status
✅ **The fix has been prepared and verified locally**  
⚠️ **Manual force-push required to apply the fix**

## What's Been Done
1. ✅ Identified the problematic commit: `8be5746d19bdef5f696ce1d449a22b4689a45ee7`
2. ✅ Created an automated fix script: `scripts/fix-commit-message.sh`
3. ✅ Executed the fix locally and rewrote git history
4. ✅ Verified the fix with cocogitto (same validation tool used in CI)
5. ✅ Created documentation and a force-push script

## Quick Start - Apply the Fix Now

### Option 1: Use the Force-Push Script (Fastest)
```bash
./scripts/force-push-fix.sh
```

### Option 2: Manual Commands
```bash
git checkout main
git push origin main --force
git push origin --tags --force
```

### Option 3: Re-run the Full Fix
If you want to rerun the entire fix process:
```bash
./scripts/fix-commit-message.sh
# Then force-push as shown above
```

## What the Fix Does
Changes the commit message from:
- ❌ `Add MCP Catalog Trust Score badge` (invalid)
- ✅ `docs: Add MCP Catalog Trust Score badge` (valid)

This makes it compliant with conventional commits format required by cocogitto.

## Verification
The fix has been tested and verified:
```bash
$ cog verify "docs: Add MCP Catalog Trust Score badge"
✓ Valid conventional commit
```

## Post-Fix Steps
After force-pushing, team members should update their local repositories:
```bash
git fetch origin
git reset --hard origin/main
```

## Files in This PR
- `README-FIX.md` (this file) - Quick start guide
- `FIX_SUMMARY.md` - Detailed summary of changes
- `FORCE_PUSH_REQUIRED.md` - Complete documentation
- `scripts/fix-commit-message.sh` - Automated fix script
- `scripts/force-push-fix.sh` - Force push script

## Need Help?
See `FORCE_PUSH_REQUIRED.md` for comprehensive documentation.

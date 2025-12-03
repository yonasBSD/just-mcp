# Deployment Instructions for Commit Message Fix

## Current Status
✅ **All preparation complete**  
✅ **Fix verified and tested**  
⏳ **Awaiting final deployment step**

## What Has Been Done
1. Analyzed the failing GitHub Actions workflow
2. Identified commit `8be5746` with non-compliant message
3. Created automated fix script (`scripts/fix-commit-message.sh`)
4. Executed the fix locally and verified with cocogitto
5. Prepared force-push deployment script (`scripts/force-push-fix.sh`)
6. Created comprehensive documentation

## What Needs To Be Done
The fix is ready but requires someone with write access to the repository to execute the final deployment:

### Execute One of These Options:

#### Option A: Use the Automated Script (Recommended)
```bash
cd /path/to/just-mcp
./scripts/force-push-fix.sh
```

#### Option B: Manual Commands
```bash
cd /path/to/just-mcp
git checkout main
git push origin main --force-with-lease
git push origin --tags --force
```

## Why Force Push is Needed
- The problematic commit is already in the remote main branch history
- It was part of PR #3 that was already merged
- Git history rewrite is the only way to change a commit message that's already pushed
- Normal `git push` will be rejected because local and remote histories have diverged

## Safety Notes
- Using `--force-with-lease` is safer than `--force` as it checks that no one else has pushed since you last fetched
- All team members will need to reset their local main branches after this
- This is a one-time operation to fix a specific commit

## Verification
After deployment, verify the fix:
```bash
# Check that the commit message was updated
git log --oneline | grep "MCP Catalog"
# Should show: docs: Add MCP Catalog Trust Score badge

# The release workflow should now pass
```

## Post-Deployment
Notify team members to update their local repositories:
```bash
git fetch origin
git reset --hard origin/main
```

## Contact
If you have questions about this fix, refer to:
- `README-FIX.md` - Quick start guide
- `FIX_SUMMARY.md` - Detailed summary
- `FORCE_PUSH_REQUIRED.md` - Complete documentation

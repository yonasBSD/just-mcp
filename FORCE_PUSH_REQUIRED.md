# Force Push Required to Fix Commit Message Format

## Summary
The commit `8be5746d19bdef5f696ce1d449a22b4689a45ee7` in the repository history has a non-compliant commit message "Add MCP Catalog Trust Score badge" that is causing the release workflow to fail during conventional commit validation.

This issue needs to be **fixed by rewriting git history** using the provided script.

## Problem Details
The workflow error:
```
Errored commit: 8be5746d19bdef5f696ce1d449a22b4689a45ee7 <Matvey-Kuk>
Commit message: 'Add MCP Catalog Trust Score badge'
Error: Missing commit type separator `:`
expected scope or type_separator
```

## Quick Fix (Automated Script)
A script has been provided to automate the fix:

```bash
./scripts/fix-commit-message.sh
```

This script will:
1. Fetch full repository history
2. Rewrite the commit message to "docs: Add MCP Catalog Trust Score badge"
3. Clean up filter-branch references
4. Verify the fix

After running the script, follow the instructions to force-push.

## Manual Fix (Step-by-Step)
If you prefer to fix manually:

1. Fetch full history:
```bash
git fetch --unshallow
```

2. Rewrite the commit message:
```bash
git filter-branch --msg-filter 'if [ "$GIT_COMMIT" = "8be5746d19bdef5f696ce1d449a22b4689a45ee7" ]; then echo "docs: Add MCP Catalog Trust Score badge"; else cat; fi' --force -- --all
```

3. Clean up:
```bash
rm -rf .git/refs/original/
git reflog expire --expire=now --all
git gc --prune=now --aggressive
```

4. Force-push the main branch:
```bash
git push origin main --force
```

## Alternative Manual Fix (Using git rebase)
For the merge approach mentioned in the problem statement:

```bash
# Note: This approach is more complex due to the commit being in a merged PR
git checkout main
# Find and amend the specific commit using interactive rebase
git rebase -i 8be5746^
# Change 'pick' to 'reword' for commit 8be5746
# Update the message to: docs: Add MCP Catalog Trust Score badge
# Save and exit
git push origin main --force
```

## Verification
After force-pushing, verify the commit message was updated:
```bash
git log --oneline | grep "MCP Catalog"
```

Expected output:
```
02e39a6 docs: Add MCP Catalog Trust Score badge
```

## Impact
- This will rewrite the history on the remote `main` branch
- All tags (v0.1.0, v0.1.1, v0.1.2, v0.1.3) have also been rewritten with updated commit SHAs
- Anyone with a local clone will need to reset their main branch: `git fetch origin && git reset --hard origin/main`
- The release workflow should pass the conventional commit validation after this change

## Tags Affected
The following tags were rewritten and will need to be force-pushed as well:
```bash
git push origin --tags --force
```

Tags affected:
- v0.0.1
- v0.1.0
- v0.1.1
- v0.1.2
- v0.1.3

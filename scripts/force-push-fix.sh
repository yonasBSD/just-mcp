#!/bin/bash
# =============================================================================
# FINAL STEP: Force Push to Apply the Fix
# =============================================================================
#
# This script will force-push the corrected main branch to the remote repository.
# This is the ONLY way to fix the conventional commit validation error.
#
# ⚠️  WARNING: This will rewrite remote history!
# ⚠️  Team members will need to reset their local branches after this.
#
# =============================================================================

set -e

echo "============================================================="
echo "  Force Push Main Branch with Corrected Commit Message"
echo "============================================================="
echo ""
echo "This will push the locally corrected history to the remote."
echo ""
echo "Current status:"
echo "  ✅ Commit message rewritten locally"
echo "  ✅ Cocogitto validation passed"
echo "  ⚠️  Remote still has old, non-compliant history"
echo ""
echo "After this script:"
echo "  ✅ Remote will have corrected history"
echo "  ✅ Release workflow will pass"
echo "  ✅ Issue resolved"
echo ""

read -p "Proceed with force push? (yes/no): " response

if [ "$response" != "yes" ]; then
    echo "Aborted."
    exit 1
fi

echo ""
echo "Step 1: Checking out main branch..."
git checkout main

echo ""
echo "Step 2: Force-pushing main branch..."
git push origin main --force-with-lease || {
    echo ""
    echo "Force-with-lease failed. Trying regular force push..."
    git push origin main --force
}

echo ""
echo "Step 3: Force-pushing tags..."
git push origin --tags --force

echo ""
echo "============================================================="
echo "  ✅ Force Push Complete!"
echo "============================================================="
echo ""
echo "The commit message has been fixed on the remote repository."
echo ""
echo "Next steps for team members:"
echo "  1. Fetch latest changes: git fetch origin"
echo "  2. Reset main branch: git reset --hard origin/main"
echo ""
echo "You can now re-run the release workflow."
echo ""

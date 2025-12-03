#!/bin/bash
set -e

echo "==============================================="
echo "Fix Commit Message Format"
echo "==============================================="
echo ""
echo "This script will rewrite git history to fix the non-compliant commit message."
echo "WARNING: This will rewrite history and requires force-pushing!"
echo ""
read -p "Do you want to continue? (yes/no): " response

if [ "$response" != "yes" ]; then
    echo "Aborted."
    exit 1
fi

echo ""
echo "Step 1: Ensuring we have full git history..."
git fetch --unshallow 2>/dev/null || echo "Repository already has full history"

echo ""
echo "Step 2: Rewriting commit message..."
echo "   From: 'Add MCP Catalog Trust Score badge'"
echo "   To:   'docs: Add MCP Catalog Trust Score badge'"

# Use git filter-branch to rewrite the commit message
FILTER_BRANCH_SQUELCH_WARNING=1 git filter-branch --msg-filter '
if [ "$GIT_COMMIT" = "8be5746d19bdef5f696ce1d449a22b4689a45ee7" ]; then
    echo "docs: Add MCP Catalog Trust Score badge"
else
    cat
fi
' --force -- --all

echo ""
echo "Step 3: Cleaning up filter-branch refs..."
rm -rf .git/refs/original/
git reflog expire --expire=now --all
git gc --prune=now --aggressive

echo ""
echo "Step 4: Verifying the fix..."
if git log --all --format="%H %s" | grep -q "8be5746d19bdef5f696ce1d449a22b4689a45ee7"; then
    echo "❌ ERROR: Old commit still exists in history!"
    exit 1
else
    echo "✅ Old commit removed from history"
fi

NEW_COMMIT=$(git log --all --format="%H %s" | grep "docs: Add MCP Catalog Trust Score badge" | head -1 | cut -d' ' -f1)
if [ -n "$NEW_COMMIT" ]; then
    echo "✅ New commit found: $NEW_COMMIT"
else
    echo "❌ ERROR: New commit not found!"
    exit 1
fi

echo ""
echo "==============================================="
echo "History rewrite complete!"
echo "==============================================="
echo ""
echo "Next steps:"
echo "1. Force-push the main branch:"
echo "   git push origin main --force"
echo ""
echo "2. Force-push all affected tags:"
echo "   git push origin --tags --force"
echo ""
echo "3. Notify team members to reset their local branches:"
echo "   git fetch origin && git reset --hard origin/main"
echo ""

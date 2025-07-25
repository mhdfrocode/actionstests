#!/bin/bash

# Usage: ./revert_merge.sh <branch_name>
BRANCH_NAME=$1

# Fetch latest changes
git fetch origin

# Get the latest merge commit on the branch
MERGE_COMMIT=$(git log origin/$BRANCH_NAME --merges -n 1 --pretty=format:"%H")

if [ -z "$MERGE_COMMIT" ]; then
  echo "No merge commit found on branch $BRANCH_NAME"
  exit 1
fi

# Revert the merge commit
git checkout $BRANCH_NAME
git revert -m 1 $MERGE_COMMIT

# Push the changes
git push origin $BRANCH_NAME

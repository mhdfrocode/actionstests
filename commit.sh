#!/bin/bash

# Usage: ./revert_merge_from_branch.sh <source_branch>
SOURCE_BRANCH=$1

# Checkout master and pull latest
git checkout master
git pull origin master

# Find the merge commit from the source branch
MERGE_COMMIT=$(git log master --merges --pretty=format:"%H %s" | grep "Merge pull request" | grep "$SOURCE_BRANCH" | head -n 1 | awk '{print $1}')

if [ -z "$MERGE_COMMIT" ]; then
  echo "No merge commit found from branch $SOURCE_BRANCH into master."
  exit 1
fi

# Revert the merge commit
git revert -m 1 $MERGE_COMMIT

# Push the changes
git push origin master

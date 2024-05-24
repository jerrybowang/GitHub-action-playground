#!/bin/bash

# function to convert branch name to regex
convert_to_regex() {
    local branch=$1
    local regex=$(echo "$branch" | sed 's/\./\\./g; s/\*/[^\/]*/g; s/\?/.{1}/g')
    regex=$(echo "$regex" | sed 's/\[\^\/\]\*\[\^\/\]\*/.*/g')
    echo "$regex"
}

# test branches
test_branches=("feature/new" "feature/new/updates" "bugfix" "bugfix/urgent" "main" "test/main")

# input branch pattern
read -p "Enter the branch pattern: " branch_pattern

# convert to regex
regex=$(convert_to_regex "$branch_pattern")

echo "Regex pattern is: $regex"

# match test branches
for test_branch in "${test_branches[@]}"; do
    if [[ $test_branch =~ ^$regex$ ]]; then
        echo "Matches \"$test_branch\""
    else
        echo "Does not match \"$test_branch\""
    fi
done

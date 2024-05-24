#!/bin/bash

branch="feature/*/test/*/**/(new)/{updates}/[*]"

# 第一步转换
regex=$(echo "$branch" | sed "s/[][(){}]/\\\\&/g")
regex=$(echo "$regex" | sed ' s/\./\\./g; s/\*/[^\/]*/g; s/\?/.{1}/g')

# 第二步转换，将连续的 `[^/]*[^/]*` 替换为 `.*`
regex=$(echo "$regex" | sed 's/\[\^\/\]\*\[\^\/\]\*/.*/g')

echo "Original pattern: $branch"
echo "Converted regex: $regex"

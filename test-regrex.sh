#!/bin/bash

# helper function to convert github action's pattern matching to regex
convert_to_regex() {
    # escape the following special characters: (){}+|
    local regex_result=$(echo "$1" | sed "s/[(){}+|]/\\\\&/g")

    # convert the branch name to a regex pattern
    # replace . with \. ;; * with [^/]* ;; ? with .{1}
    # ** will become [^/]*[^/]*  ;; hence the seconde sed command
    regex_result=$(echo "$regex_result" | sed 's/\./\\./g; s/\*/[^\/]*/g; s/\?/.{1}/g')

    # replace [^/]*[^/]*  with .*
    regex_result=$(echo "$regex_result" | sed 's/\[\^\/\]\*\[\^\/\]\*/.*/g')

    # finally, hanle the negation of a character set
    # eg. [!abc] will become [^abc]
    regex_result=$(echo "$regex_result" | sed 's/\[\!/\[\^/g')

    # return the regex
    echo "$regex_result"
}

# test branches
test_branches=("feature/new"
                "feature/new/updates" 
                "bugfix" "bugfix/urgent" 
                "main" "test/main" "test-e" 
                "test/OPS-201]-test" "f/(test)" 
                "f/{test}/(new)" "f/{test}/(new)/{updates}"
                "f/{test}/(new)/{updates}/d"
                "a-test" "fix/OPS-301" "fix/OPS-291/test"
                "a|b" "a+b" "a(b)" "a{b}" "ab]"
                )

# input branch pattern
read -p "Enter the branch pattern: " branch_pattern

# convert to regex
regex=$(convert_to_regex "$branch_pattern")

echo "Regex pattern is: $regex"

# match test branches
for test_branch in "${test_branches[@]}"; do
    negate=false
    # if there is a negte character "!"
    if [[ $regex =~ ^! ]]; then
        # remove the "!" character
        regex=${regex:1}
        negate=true
    fi

    if [[ $test_branch =~ ^$regex$ ]]; then
        echo "Matches \"$test_branch\""
    else
        if $negate; then
            echo "Matches \"$test_branch\""
        else
            echo "Does not match \"$test_branch\""
        fi
    fi
done

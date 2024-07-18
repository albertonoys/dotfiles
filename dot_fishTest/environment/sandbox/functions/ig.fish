function _getBranches
    gum choose (git for-each-ref --count=20 --sort=-committerdate --format="%(refname:lstrip=-1)" "refs/heads/*")
end

function ig --description 'Wrapper for iatsGo'
    if count $argv[1] > /dev/null
        set branch $argv[1]
    else
        set branch (_getBranches)
    end

    # Debug
    # echo "Selected branch: $branch"
    iatsGo $branch
end

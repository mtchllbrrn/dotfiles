# source githelpers
source ~/dotfiles/githelpers.sh
alias 'glp'='pretty_git_log'

alias 'ls'='ls -G'
alias 'la'='ls -Al'

alias 'mvim'='/Applications/MacVim.app/Contents/MacOS/MacVim'
alias 'st'='open -a SourceTree'
alias 'lint'='eslint --ext ".js, .jsx" .'

# recolor ag paths
alias 'ag'='ag --color-path=35'

alias 'ga'='git add'
alias 'gs'='git status -sb'
alias 'gl'='git log --oneline -10'
alias 'go'='git checkout'
alias 'gc'='git commit -m'
alias 'gb'='git branch'
alias 'glu'='git log --first-parent --no-merges'

# prettify JSON by piping to this alias.
alias 'json'='python -m json.tool'

# Gnomad startup alias
#alias ms='[ -f settings-development.json ] && meteor run --settings settings-development.json || meteor run'
#alias gpl='git pull && git submodule foreach git pull origin master'

# Blendata
alias dt_query='http -f https://lincoln.gopdatatrust.com/v2/api/query.php ClientToken=20C4378C-7B62-4DF7-8FF5-795DC3BF7044 Call_ID=56044b8f6348165165c0a6ff'
alias dt_fast_match='http -f https://lincoln.gopdatatrust.com/v2/api/fast_match.php ClientToken=20C4378C-7B62-4DF7-8FF5-795DC3BF7044 Call_ID=56044b8f6348165165c0a6ff'
alias dt_query_get_file='http -f https://lincoln.gopdatatrust.com/v2/api/query_get_file.php ClientToken=20C4378C-7B62-4DF7-8FF5-795DC3BF7044 Call_ID=56044b8f6348165165c0a6ff'
alias dt_get_call='http -f https://lincoln.gopdatatrust.com/v2/api/get_call.php ClientToken=20C4378C-7B62-4DF7-8FF5-795DC3BF7044 Call_ID=56044b8f6348165165c0a6ff'

prompt_git() {
    local s=""
    local branchName=""

    # check if the current directory is in a git repository
    if [ $(git rev-parse --is-inside-work-tree &>/dev/null; printf "%s" $?) == 0 ]; then

        # check if the current directory is in .git before running git checks
        if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == "false" ]; then

            # ensure index is up to date
            git update-index --really-refresh  -q &>/dev/null

            # check for uncommitted changes in the index
            if ! $(git diff --quiet --ignore-submodules --cached); then
                s="$s+";
            fi

            # check for unstaged changes
            if ! $(git diff-files --quiet --ignore-submodules --); then
                s="$s!";
            fi

            # check for untracked files
            if [ -n "$(git ls-files --others --exclude-standard)" ]; then
                s="$s?";
            fi

            # check for stashed files
            if $(git rev-parse --verify refs/stash &>/dev/null); then
                s="$s$";
            fi

        fi

        # get the short symbolic ref
        # if HEAD isn't a symbolic ref, get the short SHA
        # otherwise, just give up
        branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
                      git rev-parse --short HEAD 2> /dev/null || \
                      printf "(unknown)")"

        [ -n "$s" ] && s=" [$s]"

        printf "%s" "$1$branchName$s"
    else
        return
    fi
}

set_prompts() {
    local black=""
    local blue=""
    local bold=""
    local cyan=""
    local green=""
    local orange=""
    local purple=""
    local red=""
    local reset=""
    local white=""
    local yellow=""

    local hostStyle=""
    local userStyle=""

    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        tput sgr0 # reset colors

        bold=$(tput bold)
        reset=$(tput sgr0)

        # Solarized colors
        # (https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized#the-values)
        black=$(tput setaf 0)
        blue=$(tput setaf 33)
        cyan=$(tput setaf 37)
        green=$(tput setaf 64)
        orange=$(tput setaf 166)
        purple=$(tput setaf 125)
        red=$(tput setaf 124)
        white=$(tput setaf 15)
        yellow=$(tput setaf 136)
    else
        bold=""
        reset="\e[0m"

        black="\e[1;30m"
        blue="\e[1;34m"
        cyan="\e[1;36m"
        green="\e[1;32m"
        orange="\e[1;33m"
        purple="\e[1;35m"
        red="\e[1;31m"
        white="\e[1;37m"
        yellow="\e[1;33m"
    fi

    # build the prompt

    # logged in as root
    if [[ "$USER" == "root" ]]; then
        userStyle="\[$bold$red\]"
    else
        userStyle="\[$orange\]"
    fi

    # connected via ssh
    if [[ "$SSH_TTY" ]]; then
        hostStyle="\[$bold$red\]"
    else
        hostStyle="\[$yellow\]"
    fi

    # set the terminal title to the current working directory
    PS1="\[\033]0;\w\007\]"

    PS1+="\n" # newline
    PS1+="\[$userStyle\]\u" # username
    PS1+="\[$reset$white\]@"
    PS1+="\[$hostStyle\]\h" # host
    PS1+="\[$reset$white\]: "
    PS1+="\[$green\]\w" # working directory
    PS1+="\$(prompt_git \"$white on $cyan\")" # git repository details
    PS1+="\n"
    PS1+="\[$reset$white\]\$ \[$reset\]" # $ (and reset color)

    export PS1
}

set_prompts
unset set_prompts

export NVM_DIR="/Users/mitchell/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

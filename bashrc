# source githelpers
source ~/dotfiles/githelpers.sh

# Source to load chruby automatically. This is a simple script that allows for easy switching between Ruby versions.
# source /usr/local/opt/chruby/share/chruby/auto.sh

alias 'glp'='pretty_git_log'

alias 'ls'='ls -G'
alias 'la'='ls -Al'

alias 'mvim'='/Applications/MacVim.app/Contents/MacOS/MacVim'
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

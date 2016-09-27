# source githelpers
source ~/dotfiles/githelpers.sh

# Source to load chruby automatically. This is a simple script that allows for easy switching between Ruby versions.
# source /usr/local/opt/chruby/share/chruby/auto.sh

alias 'glp'='pretty_git_log'

alias 'ls'='ls -G'
alias 'la'='ls -Alh'

alias 'mvim'='/Applications/MacVim.app/Contents/MacOS/MacVim'
alias 'lint'='eslint --ext ".js, .jsx" .'

# recolor ag paths
alias 'ag'='ag --color-path=35'

alias 'ga'='git add'
alias 'gs'='git status -sb'
alias 'gl'='git log --oneline -10'
alias 'gco'='git checkout'
alias 'gc'='git commit -m'
alias 'gb'='git branch'
alias 'glu'='git log --first-parent --no-merges'
alias 'gd'='git diff'

# prettify JSON by piping to this alias.
alias 'json'='python -m json.tool'

# shorthand to boot vim into Simplenote
alias 'notes'='vim -c "Simplenote -l"'

alias 'mux'='tmuxinator'

# extend git command with hub's functionality.
# This doesn't change any of the existing git functionality, simply extends.
alias git=hub

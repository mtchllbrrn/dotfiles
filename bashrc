# source githelpers
source ~/dotfiles/githelpers.sh

# Source to load chruby automatically. This is a simple script that allows for easy switching between Ruby versions.
# source /usr/local/opt/chruby/share/chruby/auto.sh

alias 'glp'='pretty_git_log'

alias 'ls'='ls -G'
alias 'la'='ls -Alh'

alias 'vim'='/usr/local/bin/nvim'
alias 'mvim'='/Applications/MacVim.app/Contents/MacOS/MacVim'
alias 'lint'='eslint --ext ".js, .jsx" .'

# recolor ag paths
alias 'ag'='ag --color-path=35'

alias 'ga'='git add'
alias 'gs'='git status -sb'
alias 'gl'='git log --oneline -10'
alias 'gco'='git checkout'
alias 'gc'='git commit -m'
alias 'gca'='git commit --amend'
alias 'gb'='git branch'
alias 'glu'='git log --first-parent --no-merges'
alias 'gd'='git diff'

# prettify JSON by piping to this alias.
alias 'json'='python -m json.tool'

# shorthand to boot vim into Simplenote
alias 'notes'='vim -c "Simplenote -l"'

alias 'mux'='tmuxinator'

alias 'ports'='lsof -i -n -P'
alias 'dc'='docker-compose'
alias 'mist'='/Applications/Mist.app/Contents/MacOS/Mist'

export PATH=/Users/mitchell/.local/bin:$PATH
export EDITOR='/usr/local/bin/nvim'

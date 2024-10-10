export ZSH=/home/andrii/.oh-my-zsh
export FZF_DEFAULT_COMMAND="fd . $HOME"
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/zig-linux
export PATH=$PATH:~/.cargo/bin

# If you come from bash you might have to change your $PATH.

ZSH_THEME="eastwood"

plugins=(
	git
	zsh-autosuggestions
)

# User configuration

source $ZSH/oh-my-zsh.sh
# source /usr/share/fzf/key-bindings.zsh
# source /usr/share/fzf/completion.zsh
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

tmux-here() {
    local session_name=${PWD##*/}  # Get the current directory name
    tmux new -s "$session_name"  # Create a new tmux session with the directory name
}
tmfzf() {
	selected_dir=$(fzf --reverse --walker=dir,follow,hidden --scheme=path)

	if [ -z "$selected_dir" ]; then
		echo "No directory selected."
		return
	fi

	cd "$selected_dir"
	dir_name=$(basename "$(pwd)")
	tmux new-session -s "$dir_name"
}

function kill-port {
	sudo kill -9 $(lsof -i :$1 | grep LISTEN | awk '{print $2}')
}

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias ohmyzsh="mate ~/.oh-my-zsh"
# alias nvim="/opt/nvim-linux64/bin/nvim"
alias zshconfig="nvim ~/.zshrc"
alias ta="tmux a -t"
alias tk="tmux kill-session -t"
alias v="nvim ."
alias air="$(go env GOPATH)/bin/air"

# g shell setup
if [ -f "${HOME}/.g/env" ]; then
    . "${HOME}/.g/env"
fi

export PATH=/opt/nvim-linux64/bin/nvim:$PATH
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:/home/andrii/zig

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[[ -f /home/andrii/.npm/_npx/6913fdfd1ea7a741/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /home/andrii/.npm/_npx/6913fdfd1ea7a741/node_modules/tabtab/.completions/electron-forge.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# bun completions
[ -s "/home/andrii/.bun/_bun" ] && source "/home/andrii/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH=$HOME/.local/bin:$PATH
. "/home/andrii/.deno/env"


cat << "EOF"

 ____       _____ __    __    ___   ____  ____       ____       _____ ___ ___    ___  _      _          _____  ____  ____     ___ 
|    |     / ___/|  |__|  |  /  _] /    ||    \     |    |     / ___/|   |   |  /  _]| |    | |        |     ||    ||    \   /  _]
 |  |     (   \_ |  |  |  | /  [_ |  o  ||  D  )     |  |     (   \_ | _   _ | /  [_ | |    | |        |   __| |  | |  _  | /  [_ 
 |  |      \__  ||  |  |  ||    _]|     ||    /      |  |      \__  ||  \_/  ||    _]| |___ | |___     |  |_   |  | |  |  ||    _]
 |  |      /  \ ||  `  '  ||   [_ |  _  ||    \      |  |      /  \ ||   |   ||   [_ |     ||     |    |   _]  |  | |  |  ||   [_ 
 |  |      \    | \      / |     ||  |  ||  .  \     |  |      \    ||   |   ||     ||     ||     |    |  |    |  | |  |  ||     |
|____|      \___|  \_/\_/  |_____||__|__||__|\_|    |____|      \___||___|___||_____||_____||_____|    |__|   |____||__|__||_____|
                                                                                                                                  

EOF

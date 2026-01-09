export TMPDIR=/tmp
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.sock
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# 1. Paling atas (JANGAN DIUBAH)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

# 2. Tambahkan baris fpath ini SEBELUM source $ZSH/oh-my-zsh.sh
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git 
  zsh-autosuggestions 
  zsh-syntax-highlighting 
  zsh-completions
)

source $ZSH/oh-my-zsh.sh

# 3. Pindahkan fastfetch ke bawah sini (setelah semua loading selesai)


[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#YAZI
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

#lf
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
alias lf='lfcd'

#======LS
alias ls='eza --icons --group-directories-first'
alias ll='eza -lh --icons --grid --group-directories-first'

#=====BAT
alias cat='bat'

eval "$(zoxide init zsh)"eval "$(fnm env --use-on-cd)"
eval "$(fnm env --use-on-cd)"
eval "$(fnm env --use-on-cd)"

# ======== DOCKER PODMAN
alias podup='podman-compose up -d'
alias podown='podman-compose down'
alias podcek='podman ps'
alias guiup='podman start portainer'
alias guioff='podman stop portainer'

export PATH="$HOME/.local/bin:$PATH"

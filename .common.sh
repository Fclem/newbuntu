function write_starship_conf {
  # write some config
  cat <<EOF > "${1}/.config/starship.toml"
[status]
symbol = "🔴 "
format = '\[\$symbol\$common_meaning\$signal_name\$maybe_int\] '
map_symbol = true
disabled = false
EOF
}

function use_starship {
  # use it for bash
  echo "eval \"\$(starship init bash)"\">> "${1}/.bashrc"
  # use it for fish
  echo "starship init fish | source">> "${1}/.config/fish/config.fish" || true

  write_starship_conf "${1}"
}



function write_aliases {
  # useful aliases
  cat <<EOF >> "$1"
alias fetch="git fetch"
alias pull="git pull"
alias fap="fetch && pull"
alias co="git checkout"

alias kube=kubectl
alias k="kubectl"

alias l="exa -l --color-scale --git"
alias la="l -a"
alias lg="l -g"
alias lag="la -g"
alias lat="lag -T -L 3"
alias lt="lg -T -L 3"
alias ncdu="ncdu --color dark"
EOF
}

# workaround for OS with no sudo (like pve)
sudo -V >/dev/null |alias sudo="echo -n;"

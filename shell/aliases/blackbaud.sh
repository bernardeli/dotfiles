b() { cd "$HOME/Code/blackbaud/$1" || return; }
_b() { _files -W ~/Code/blackbaud -/; }
compdef _b b

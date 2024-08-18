function prepend_path() {
  PATH="$1:$PATH"
}

function append_path() {
  PATH="$PATH:$1"
}

prepend_path "/usr/local/bin"
prepend_path "~/.cargo/bin"

unset prepend_path
unset append_path

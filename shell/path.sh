function prepend_path() {
  if [ -d "$1" ]; then
    PATH="$1:$PATH"
  fi
}

function append_path() {
  if [ -d "$1" ]; then
    PATH="$PATH:$1"
  fi
}

append_path "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
append_path "/usr/local/opt/go/libexec/bin"
append_path "/usr/local/opt/coreutils/libexec/gnubin"

# EDH path - Revisit this to get rid of /Users/ric
prepend_path "/Users/ric/Code/plain-utils/bin"
prepend_path "/Users/ric/Code/plain-services-docker/bin"

unset prepend_path
unset append_path

e() { cd ~/Code/$1; }
_e() { _files -W ~/Code -/; }
compdef _e e

ec() { cd ~/Code/payments/components/$1; }
_ec() { _files -W ~/Code/payments/components -/; }
compdef _ec ec

### plain utils aliases
function pur(){
  plain-utils run "$@"
}

function ns(){
  pur nexus-staging "$@"
}

function np(){
  pur nexus-production "$@"
}

function rcp() {
  pur nexus-production bin/rails c
}

function rcs() {
  pur nexus-staging bin/rails c
}

function sadmin(){
  plain-utils ssh staging admin
}

function padmin(){
  plain-utils ssh production admin
}

function bk() {
  project=$1
  guessedProjectName=$(basename $(git remote show -n origin | grep Fetch | cut -d. -f2))
  project=${project:-$guessedProjectName}
  branch=$2
  branch=${branch:-$(git rev-parse --abbrev-ref HEAD)}
  branch=${branch:-master}
  open "https://buildkite.com/everyday-hero/$project/builds?branch=$branch"
}

function sshp(){
  server="$1" && shift
  ssh $server.plain.edh.ro "$@"
}

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

function plain-rails-console() {
  pur $1-$2 bin/rails c
}

function rcp() {
  project=${1:-nexus}
  environment=production

  if [[ "$project" == "supporter" ]]; then
    environment="prod"
  fi

  plain-rails-console $project $environment
}

function rcs() {
  project=${1:-nexus}

  plain-rails-console $project staging
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

  if [[ "$project" == "supporter" ]]; then
    project="supporter-tests"
  fi

  if [[ "$project" == "command_centre" ]]; then
    project="command-centre"
  fi

  branch=$2
  branch=${branch:-$(git rev-parse --abbrev-ref HEAD)}
  branch=${branch:-master}
  open "https://buildkite.com/everyday-hero/$project/builds?branch=$branch"
}

function sshp(){
  server="$1" && shift
  ssh $server.plain.edh.ro "$@"
}

# Gives you `complete` function used by plain-utils
autoload -U bashcompinit
bashcompinit -i
source "/Users/ric/Code/plain-utils/etc/bash_completion"

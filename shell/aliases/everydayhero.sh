export CONVOX_WAIT=true

e() { cd ~/Code/$1; }
_e() { _files -W ~/Code -/; }
compdef _e e

### plain utils aliases
function plain-console() {
  project=$1
  environment=$2
  command="bin/rails c"

  if [[ "$project" == "supporter" && "$environment" == "production" ]]; then
    environment="prod"
  fi

  if [[ "$project" == "mothership" ]]; then
    command="exe/mothership"
  fi

  plain-utils run $project-$environment $command
}

function rcp() {
  plain-console $1 $2 production
}

function rcs() {
  plain-console $1 $2 staging
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

  if [[ "$project" == "zuul" ]]; then
    project="zuul-tests"
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

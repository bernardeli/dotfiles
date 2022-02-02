function bk() {
  project=$1
  guessedProjectName=$(basename $(git remote show -n origin | grep Fetch | cut -d. -f2))
  project=${project:-$guessedProjectName}

  branch=$2
  branch=${branch:-$(git rev-parse --abbrev-ref HEAD)}
  branch=${branch:-master}
  open "https://buildkite.com/thelookoutway/$project/builds?branch=$branch"
}

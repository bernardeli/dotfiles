alias d="docker"
alias dst="docker stop"
alias drm="docker rm"
alias dps="docker ps -a"
alias dmi="docker images"
alias drun="docker run"
alias doco="docker-compose"

dclean() {
  docker rm $(docker ps -aq)
  docker rmi $(docker images | grep none | awk '{ print $3; }')
}

dbash() {
  docker exec -t -i $1 /bin/bash
}

dstoprm() {
  docker stop $1 ; docker rm $1
}

alias d="docker"
alias dst="docker stop"
alias drm="docker rm"
alias dps="docker ps -a"
alias dmi="docker images"
alias drun="docker run --rm -it"
alias doco="docker-compose"
alias dcr="docker-compose run --rm"

dclean() {
  docker rm $(docker ps --filter "status=exited" -q)
}

dcleani() {
  docker rm $(docker ps -aq)
  docker rmi $(docker images | grep none | awk '{ print $3; }')
}

dbash() {
  docker exec -it $1 /bin/bash
}

dstoprm() {
  docker stop $1 ; docker rm $1
}

rununtilfail() {
  count=0
  while eval $1; do (( count++ )); echo $count; done; echo $count
}

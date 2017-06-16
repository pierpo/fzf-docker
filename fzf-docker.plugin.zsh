_fzf_complete_docker() {
  ARGS="$@"
  if [[ $ARGS = 'docker ' ]]; then
    _fzf_complete "--multi --reverse" "$@" < <(
        echo 'images'
        echo 'inspect'
        echo 'ps -a'
        echo 'rmi -f'
        echo 'rm'
        echo 'stop'
        echo 'start'
    )
  elif [[ $ARGS = 'docker rmi ' || $ARGS = 'docker -f ' ]]; then
    _fzf_complete "--multi --reverse" "$@" < <(
        docker images --format '{{.Repository}}:{{.Tag}}'
    )
  elif [[ $ARGS = 'docker start ' || $ARGS = 'docker stop ' || $ARGS = 'docker rm ' ]]; then
    _fzf_complete "--multi --reverse" "$@" < <(
        docker ps -a --format '{{.Names}}'
    )
  fi
}
[ -n "$BASH" ] && complete -F _fzf_complete_docker -o default -o bashdefault docker

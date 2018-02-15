_fzf_complete_docker() {
  # Get all Docker commands
  #
  # Cut below "Management Commands:", then exclude "Management Commands:",
  # "Commands:" and the last line of the help. Then keep the first column and
  # delete empty lines
  DOCKER_COMMANDS=$(docker --help 2>&1 >/dev/null |
    sed -n -e '/Management Commands:/,$p' |
    grep -v "Management Commands:" |
    grep -v "Commands:" |
    grep -v 'COMMAND --help' |
    grep .
  )

  ARGS="$@"
  if [[ $ARGS == 'docker ' ]]; then
    _fzf_complete "--reverse -n 1 --height=80%" "$@" < <(
      echo $DOCKER_COMMANDS
    )
  elif [[ $ARGS == 'docker rmi'* || $ARGS == 'docker -f'* ]]; then
    _fzf_complete "--multi --reverse" "$@" < <(
      docker images --format '{{.Repository}}:{{.Tag}}'
    )
  elif [[ $ARGS == 'docker start'* || $ARGS == 'docker restart'* || $ARGS == 'docker stop'* || $ARGS == 'docker rm'* || $ARGS == 'docker exec'* || $ARGS == 'docker kill'* ]]; then
    _fzf_complete "--multi --reverse" "$@" < <(
      docker ps --format '{{.Names}}'
    )
  fi
}

_fzf_complete_docker_post() {
  # Post-process the fzf output to keep only the command name and not the explanation with it
  awk '{print $1}'
}

[ -n "$BASH" ] && complete -F _fzf_complete_docker -o default -o bashdefault docker

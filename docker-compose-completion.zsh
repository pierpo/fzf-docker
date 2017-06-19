_fzf_complete_docker-compose() {
  # Get all Docker-compose commands
  DOCKER_COMPOSE_COMMANDS=$(docker-compose --help 2>&1 >/dev/null |
    sed -n -e '/Commands:/,$p' |
    grep -v "Commands:" |
    grep .
  )

  ARGS="$@"
  if [[ $ARGS = 'docker-compose ' ]]; then
    _fzf_complete "--reverse -n 1 --height=80%" "$@" < <(
      echo $DOCKER_COMPOSE_COMMANDS
    )
  elif [[ $ARGS = 'docker-compose up ' || $ARGS = 'docker-compose down ' || $ARGS = 'docker-compose exec ' || $ARGS = 'docker-compose rm ' ]]; then
    # docker-compose output has to be redirected to /dev/null, otherwise
    # we get the "stty: stdout isn't a terminal" error message
    DOCKER_CONTAINERS=$(docker-compose ps 2> /dev/null | awk 'NR >= 3 {print $1}') #no format option for this command?
    if [ -z $DOCKER_CONTAINERS ]; then
      echo -e '\nERROR: No docker-compose configuration file or containers found in current directory'
    else
      _fzf_complete "--multi --reverse" "$@" < <(
        echo $DOCKER_CONTAINERS
      )
    fi
  fi
}

_fzf_complete_docker-compose_post() {
  # Post-process the fzf output to keep only the command name and not the explanation with it
  awk '{print $1}'
}

[ -n "$BASH" ] && complete -F _fzf_complete_docker-compose -o default -o bashdefault docker-compose

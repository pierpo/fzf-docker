# TODO check that this is defined
# if it is, there needs to be a default value to ~/.oh-my-zsh/plugins/fzf-docker
CURRENT_PLUGIN_DIR=$(dirname $0)

source $CURRENT_PLUGIN_DIR/docker-completion.zsh
source $CURRENT_PLUGIN_DIR/docker-compose-completion.zsh

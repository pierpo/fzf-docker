Inspired by a contribution of calbertts in [this fzf issue](https://github.com/junegunn/fzf/issues/760).

# Dependencies

- [fzf](https://github.com/junegunn/fzf)
- [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

# Installation

Copy [fzf-docker.plugin.zsh](https://github.com/pierpo/fzf-docker/blob/master/fzf-docker.plugin.zsh) in `.oh-my-zsh/plugins/fzf-docker` and add it to your oh-my-zsh plugins.

```bash
# In your .zshrc
plugins=(... fzf-docker ...)
```

# Usage

If you don't like the `**` prefix (which is a fzf thing), you may change it in your `zshrc`:

```bash
export FZF_COMPLETION_TRIGGER='**'
```

I personally put `,` instead :wink:

## Command list

```bash
docker **<TAB>
```

## Remove images

```bash
docker rmi **<TAB>
```

## Start containers

```bash
docker start **<TAB>
```

## Stop containers

```bash
docker stop **<TAB>
```

## Remove containers

```bash
docker rm **<TAB>
```

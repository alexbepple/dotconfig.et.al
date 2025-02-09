# set -x LANG en_US.utf8
# set -x LC_ALL C

test -d /opt/homebrew && eval (/opt/homebrew/bin/brew shellenv)

# These used to be mainly for Homebrew. But some other apps install CLI helpers there, e.g. Docker.
set --prepend PATH /usr/local/bin
set --prepend PATH /usr/local/sbin

set --prepend PATH $HOME/.cargo/bin

set --prepend PATH $HOME/computing/dotconfig.et.al/npm/bin

set -x GOPATH $HOME/.go
set --prepend PATH $GOPATH/bin

export ERL_AFLAGS="-kernel shell_history enabled"

set eza pkgx eza -F
abbr l $eza
abbr ll $eza -l

abbr hx pkgx hx
abbr z zed
abbr z. zed .
abbr ij 'open -na "IntelliJ IDEA.app"'
abbr ij. 'open -na "IntelliJ IDEA.app" --args (pwd)'
abbr o open

set -x LESS -i
abbr L bat
complete -c bat -a '(__fish_complete_path)'
export PAGER='bat --plain'

set -x FZF_DEFAULT_OPTS '--height 40% --border --reverse --no-sort'

abbr js just

if status --is-interactive
    set NIX_LINK $HOME/.nix-profile
    set NIX_USER_PROFILE_DIR /nix/var/nix/profiles/per-user/$USER
    set --export NIX_PATH $HOME/.nix-defexpr/channels
    set --export NIX_PROFILES "/nix/var/nix/profiles/default $HOME/.nix-profile"
    set --export NIX_SSL_CERT_FILE "$NIX_LINK/etc/ssl/certs/ca-bundle.crt"
    set --export --append MANPATH "$NIX_LINK/share/man"
    set --prepend PATH "$NIX_LINK/bin"
end

abbr ne nix-env
abbr ns nix-shell

set -x PROTO_HOME $HOME/.proto
set --prepend PATH $PROTO_HOME/shims:$PROTO_HOME/bin

eval (direnv hook fish)

abbr v vagrant

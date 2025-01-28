# set -x LANG en_US.utf8
# set -x LC_ALL C

if test -d /opt/homebrew
    # prevent brew init from always putting Homebrew first in the PATH
    set -l brew_init (/opt/homebrew/bin/brew shellenv | string replace --regex '\-\-move ' '')
    eval $brew_init
end

# These used to be mainly for Homebrew. But some other apps install CLI helpers there, e.g. Docker.
fish_add_path --path /usr/local/bin
fish_add_path --path /usr/local/sbin

fish_add_path --path $HOME/.cargo/bin

fish_add_path --path $HOME/computing/dotconfig.et.al/npm/bin

set -x GOPATH $HOME/.go
fish_add_path --path $GOPATH/bin

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

eval (direnv hook fish)

abbr v vagrant

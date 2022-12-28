function mkcd
    set -l dir $argv
    mkdir -p $dir
    and cd $dir
end

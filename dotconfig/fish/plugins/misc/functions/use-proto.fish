function use-proto
    set -l PROTO_HOME $HOME/.proto
    fish_add_path --path $PROTO_HOME/shims $PROTO_HOME/bin
end

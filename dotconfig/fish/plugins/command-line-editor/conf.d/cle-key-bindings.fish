function __cle_set_convenience_bindings
    set bind bind -M $argv[1]
    $bind \t __if_empty_search_history_else_tab
end

for mode in insert default
    __cle_set_convenience_bindings $mode
end

set -g fish_key_bindings fish_vi_key_bindings

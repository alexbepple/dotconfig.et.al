function __set_commandline
    if test (count $argv) -gt 0
        commandline $argv
    else
        commandline ''
    end
end

function __nauniq; awk '!a[$0]++'; end

function __cle_search_history
    set -l value (history | string trim | __nauniq | fzf)
    __set_commandline $value
end

function __emulate_default_tab_behavior
    # I do not understand why I have to do this.
    # In my opinion, `commandline -f complete` should suffice.
    # It is the default binding, after all:
    #   bind --preset \t complete
    # cp. https://github.com/laughedelic/pisces/blob/master/functions/_pisces_complete.fish
    
    if commandline --paging-mode
        down-or-search
    else
        commandline -f complete
    end
end

function __if_empty_search_history_else_tab
    if test -z (commandline)
        __cle_search_history
    else
        __emulate_default_tab_behavior
    end
end

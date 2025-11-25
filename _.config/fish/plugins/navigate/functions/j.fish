function _cd_if_given
    set -l destination $argv
    if test (count $destination) -eq 0
        read destination
    end

    if test (count $destination) -gt 0
        cd $destination
    end
end

function _get_descendants; fd . --type d --max-depth 3; end

function _get_ancestors
    function generate_prefixes
        set -l path_components $argv
        for i in (seq (count $path_components))
            echo (string join '/' $path_components[1..$i])
        end
    end

    set -l cwd_components (pwd | string split '/')
    generate_prefixes $cwd_components | grep / | grep -v (pwd)
end

function _get_previously_visited
    function __extract_paths; awk '{ $1 = ""; print $0 }' | string trim; end

    z -l | __extract_paths
end

function _j_list_candidates
    _get_ancestors
    _get_descendants
    _get_previously_visited
end

function j
    set -l fzf_command fzf -1 
    if test (count $argv) -gt 0; set --append fzf_command -q $argv; end
    
    _j_list_candidates | $fzf_command | _cd_if_given
end

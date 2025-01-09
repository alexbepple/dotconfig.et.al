function jwt-read-exp
    jwt decode $argv | grep exp | cut -d ' ' -f 4 | cut -d ',' -f 1 | xargs date -r
end

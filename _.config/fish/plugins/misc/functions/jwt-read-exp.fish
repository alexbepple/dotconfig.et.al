function jwt-read-exp
    jwt decode --json $argv | jq '.payload.exp' | xargs date -r
end

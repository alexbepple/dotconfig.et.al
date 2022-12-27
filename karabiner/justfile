default: format-jsonnet generate-json format-json

format-jsonnet:
    jsonnetfmt -i karabiner.jsonnet

generate-json:
    jsonnet karabiner.jsonnet > karabiner.json

format-json:
    # goal: format JSON same way as Karabiner does it
    yarn json -f karabiner.json -4 --in-place # curiously enough, when this is piped it produces a slightly different output :-/
    truncate -s -1 karabiner.json # remove newline at end of file
    # And this is just a check.
    yarn editorconfig-cli karabiner.json


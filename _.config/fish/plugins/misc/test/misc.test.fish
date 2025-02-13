
@test 'fish loads quickly enough' (
    /usr/bin/time -p fish -c '' 2>&1 | grep user | cut -d . -f 2
) -lt 10

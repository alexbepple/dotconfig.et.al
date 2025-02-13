
@test 'fish loads quickly enough' (
    gtime -f '%U' fish -c '' 2>&1 | cut -d . -f 2
) -lt 10

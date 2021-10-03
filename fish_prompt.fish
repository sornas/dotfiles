function fish_prompt
    set -l user
    if test -n "$SSH_CONNECTION"
        echo -n "$USER::$hostname<"
    else
        echo -n "::<"
    end
    set_color green
    echo -n (string replace -r '^'"$HOME" '~' "$PWD")
    set_color normal
    echo -n "> "
end

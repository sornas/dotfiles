function fish_prompt
    if test -n "$SSH_CONNECTION"
        echo -n "$USER::$hostname<"
    else
        echo -n "::<"
    end

    set -l git_root (command git rev-parse --show-toplevel 2>/dev/null)
    if test -n "$git_root"
        set_color blue
        set -l git_bn (command basename "$git_root")
        echo -n (string replace -r '^'"$git_root" "$git_bn" "$PWD")
    else
        set_color green
        echo -n (string replace -r '^'"$HOME" '~' "$PWD")
    end
    set_color normal

    echo -n "> "
end

function tmux_init --description "Attach to TMUX if possible"
    if test -n "$TMUX"
        # TMUX is already launched
        return
    end
    if not status --is-interactive
        return
    end
    if not string match -r -i '^/dev/pts/[0-9]' (tty)
        # Refuse to launch on cassic TTYs
        return
    end
    set TMUX_SESSION $USER
    exec tmux new -t $TMUX_SESSION
end

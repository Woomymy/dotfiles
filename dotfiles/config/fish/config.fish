tmux_init &>/dev/null 2>/dev/null

if test -n $TMUX
    tmux source-file $HOME/.tmux.conf
end

if test (tty) = "/dev/tty1"
    exec ~/.bin/hyprland_init.sh
end

set -gx GPG_TTY (tty) # Fixes "inapropriate Ioctl for device" errors
set PATH ~/.npm/prefix/bin ~/go/bin ~/.local/bin ~/.cargo/bin ~/.deno/bin $PATH # Add cargo binaries to path

## Android
set PATH $PATH ~/Android/Sdk/tools/bin ~/.sdkman/candidates/kotlin/current/bin ~/.config/Code/User/globalStorage/fwcd.kotlin/langServerInstall/server/bin
set -gx EDITOR nvim
set fish_greeting ""

set SSH_ENV_FILE "/tmp/SSH_ENV"

if test -f $SSH_ENV_FILE
    source $SSH_ENV_FILE
end

if not ps -p $SSH_AGENT_PID &>/dev/null 2>&1
    ssh-agent -c | head -n 2 >$SSH_ENV_FILE
end
source $SSH_ENV_FILE


# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

export PATH=/home/mikhail/.local/bin:$PATH
export PATH=/home/mikhail/go/bin:$PATH
# export GDK_SCALE=2
# autologin on tty1
if [ -z "$DISPLAY" ] && [ "$(fgconsole)" -eq 1 ]; then
startx
fi
bindkey -s ^f "tmux-sessionizer\n"

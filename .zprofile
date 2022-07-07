bindkey -s ^f "tmux-sessionizer\n"
export PATH=/home/mikhail/.local/bin:$PATH
export PATH=/home/mikhail/go/bin:$PATH
# autologin on tty1
if [ -z "$DISPLAY" ] && [ "$(fgconsole)" -eq 1 ]; then
startx
fi

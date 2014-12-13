prev_command_file=${prev_command_file:-$(mktemp /tmp/command_history.XXXXXXXX)}
export prev_command_file
echo > $prev_command_file

[[ -e ~/.bashrc ]] && . ~/.bashrc


unset HISTFILE

PS1='$(log_command)\h:\W\$ '

set -o vi
[[ -e /usr/share/zoneinfo/US/Pacific ]] &&
  export TZ="/usr/share/zoneinfo/US/Pacific"

if [[ "Darwin" == $(uname) ]];
then
  alias ls="ls -G"
else
  alias ls="ls --color=auto"
fi
alias grep="grep --color=auto"
alias less="less -R"

export EDITOR=vim
export LESSHISTFILE=/dev/null

if [[ -z $prev_command_file ]];
then
  prev_command_file=${prev_command_file:-$(mktemp /tmp/command_history.XXXXXXXX)}
  export prev_command_file
  echo > $prev_command_file
fi

log_command() {
  this_command=$(fc -l -1 2> /dev/null | cut -f 1)
  prev_command=$(cat $prev_command_file)
  [[ $this_command == $prev_command ]] && return
  echo $this_command > $prev_command_file
  (echo -n "[$(date '+%Y%m%d %H%M%S')] "; fc -ln -1 | sed -e 's;^[ \t]*;;') \
    >> ~/.bash_logs/$(hostname -s).$(date +%Y%m) 2> /dev/null
}

# Updates an environment variable to include the given path.
update_variable_with_path() {
  local variable_name=$1
  local path=$2
  local delimeter=${3:-:}

  # Check parameters.
  [[ -z $variable_name ]] && return
  [[ -z $path || ! -d $path ]] && return

  local old_value=$(eval "echo \$${variable_name}")

  # Check if path is already in variable_name.
  [[ "$old_value" =~ "$path" ]] && return
   
  # Update the Variable
  if [[ -z $old_value ]];
  then
    eval "export ${variable_name}=${path}"
  else
    eval "export ${variable_name}=${old_value}${delimeter}${path}"
  fi
}

for DIR in $(find ~/apps -maxdepth 1 -mindepth 1 -type d);
do
  update_variable_with_path PATH ${DIR}/bin
  update_variable_with_path MANPATH ${DIR}/man
  update_variable_with_path MANPATH ${DIR}/share/man
  update_variable_with_path LDLIBRARYPATH ${DIR}/lib
  for PYDIR in ${DIR}/lib/python*/;
  do
    update_variable_with_path PYTHONPATH $PYDIR
    update_variable_with_path PYTHONPATH ${PYDIR}/site-packages
  done
done

[[ -e ~/.bashrc.local ]] && . ~/.bashrc.local

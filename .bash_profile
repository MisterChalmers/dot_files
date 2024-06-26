# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac


# Path to the bash it configuration
export BASH_IT="$HOME/.bash_it"

# Lock and Load a custom theme file.
# Leave empty to disable theming.
# location /.bash_it/themes/
export BASH_IT_THEME='rjorgenson'

# Load Bash It
source "$BASH_IT"/bash_it.sh

#
# env variables
#
export EDITOR=nvim

#
# macos finagling
#
if [[ "$OSTYPE" == "darwin"* ]]; then
  # silence apple bash nonesense
  export BASH_SILENCE_DEPRECATION_WARNING=1
  
  # add gnupg to path
  PATH="/usr/local/opt/gnupg@1.4/libexec/gpgbin:$PATH"

  # add system python user libraries to path
  PATH="/Users/chalmers/Library/Python/3.11/bin:$PATH"

  # shortcut to iCloud directory
  alias icloud_dir="cd /Users/chalmers/Library/Mobile\ Documents/com~apple~CloudDocs"

  # setting path for global python binary
  PATH="/usr/local/bin:$PATH"
  alias python="python3"
  alias pip="pip3"

  PATH="/usr/local/Cellar/stlink/1.7.0/bin:$PATH"
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

#
# python finagling
#
function venv_util ()
{
  if [ -d "$(pwd)/venv" ]; then
    echo ""
  else
    python3 -m venv "$(pwd)"/venv
  fi
  
  source ./venv/bin/activate

  alias python="$(pwd)/venv/bin/python"
  alias pip="$(pwd)/venv/bin/pip"
}


#
# ruby env stuff
#
if command -v rbenv &> /dev/null
then
	eval "$(rbenv init - bash)"
fi
#
# aliases
#
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias vi=nvim
alias vim=nvim
alias sb='source ~/.bash_profile'

alias balena_etcher="sudo /Applications/balenaEtcher.app/Contents/MacOS/balenaEtcher"

#
# crappy nmap aliases
#
alias LAN_IPs_store="nmap -sP 192.168.2.0/24 | grep 192 | sort > workspace/usual_ips.txt"
alias LAN_IPs_check="nmap -sP 192.168.2.0/24 | grep 192 | sort  > workspace/new_ips.txt && diff workspace/usual_ips.txt workspace/new_ips.txt"


alias sherlock='/Users/chalmers/bin/sherlock/sherlock/venv/bin/python3 /Users/chalmers/bin/sherlock/sherlock'

# make sure ssh keys are loaded
if [[ "$OSTYPE" == "darwin"* ]]; then
  if ssh-add -l > /dev/null; then true; else ssh-add --apple-load-keychain; fi
else
  alias fix_keychain='eval `ssh-agent` && eval `keychain --eval id_rsa id_ed25519`'
  if ssh-add -l > /dev/null; then true; else fix_keychain ; fi
fi

#
# add shortcut for z
#
if [[ "$OSTYPE" == "darwin"* ]]; then
	. /usr/local/Cellar/z/1.9/etc/profile.d/z.sh
fi

#
# password creation utility
#
if hash diceware 2>/dev/null; then
	alias diceware_passwd="diceware -n 4 -d -"
fi

#
# java utility aliases
#
if [[ "$OSTYPE" == "darwin"* ]]; then
	alias karate="/usr/bin/java -jar /Users/chalmers/bin/karate-1.5.0.RC3.jar"
fi

#
# Import stuff that's local to this machine
#
if [ -f $HOME/local_variables.sh ]; then 
	source $HOME/local_variables.sh
fi

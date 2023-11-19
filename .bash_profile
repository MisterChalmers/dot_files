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
export BASH_IT_THEME='90210'

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
  if [ -d "$(pwd)/venv" ]
  then
    source ./venv/bin/activate
  else
    python3 -m venv "$(pwd)"/venv
    source ./venv/bin/activate
  fi
}
alias python="python3"

#
# ruby env stuff
#
if [[ "$OSTYPE" == "darwin"* ]]; then
	eval "$(rbenv init - bash)"
else
	eval "$(~/.rbenv/bin/rbenv init - bash)"
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

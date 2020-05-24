# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
GOPATH=$HOME/go
PATH="$PATH:$GOBIN:$HOME/Downloads/crc-linux-amd64:$GOPATH/src/helm.sh/helm/bin:/usr/local/go/bin:$GOPATH/bin:$HOME/Downloads/minishift-1.31.0-linux-amd64:$HOME/.local/bin:$HOME/bin:$HOME/Downloads/kustomize:$HOME/Downloads/s2i/s2i"
export PATH
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export GOBIN=$HOME/go/bin
yellow=$(tput setaf 228);
purple=$(tput setaf 177);
green=$(tput setaf 71);
reset=$(tput sgr0);
bold=$(tput bold);
white=$(tput setaf 15);
cyan=$(tput setaf 203);

PS1="\[${bold}\]";
PS1+="\[${yellow}\]\u";
PS1+="\[${white}\]@";
PS1+="\[${purple}\]\h ";
#PS1+="\[${white}\] =>> ";
PS1+="\[${cyan}\]\W";
#PS1+="\[${green}\] =>> \[${reset}\] ";
#PS1+="\n";
#PS1+="\[${white}\]$ \[${reset}\]";
#export PS1;
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
PS1+="\[\033[32m\]\$(parse_git_branch)\[\033[00m\]=>> ";
PS1+="\[${white}\] \[${reset}\] ";
export PS1;

alias k="kubectl";
alias o="operator-sdk";
source <(oc completion bash)
source <(helm completion bash)
#PS1="$(tput setaf 228)\u$(tput setaf 177)@\h$(tput setaf 71) \W ->> $(tput sgr0)";


# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
source ~/.op_sdk_output.sh 

export CDPATH=.:/home/avni/go/src/github.com/redhat-developer:/home/avni/go/src/github.com:/home/avni/go/src/github.com/Avni-Sharma

# added by ribhu
get_url(){
	url="www.google.com/search?q="
	echo $url${1}
}

alias get="get_url $1"

# added by travis gem
[ -f /home/avni/.travis/travis.sh ] && source /home/avni/.travis/travis.sh


go_test() {
  go test $* | sed ''/PASS/s//$(printf "\033[32mPASS\033[0m")/'' | sed ''/SKIP/s//$(printf "\033[34mSKIP\033[0m")/'' | sed ''/FAIL/s//$(printf "\033[31mFAIL\033[0m")/'' | sed ''/FAIL/s//$(printf "\033[31mFAIL\033[0m")/'' | GREP_COLOR="01;33" egrep --color=always '\s*[a-zA-Z0-9\-_.]+[:][0-9]+[:]|^'
}

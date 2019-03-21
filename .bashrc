# GIT SECTION

COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_OCHRE="\033[38;5;95m"
COLOR_BLUE="\033[0;34m"
COLOR_WHITE="\033[0;37m"
COLOR_RESET="\033[0m"

function git_color {
   local git_status="$(git status 2> /dev/null)"

   # echo $git_status;

   if [[ `echo $git_status | grep "nothing to commit, working tree clean"` != "" ]]; then
      echo -e $COLOR_GREEN
   elif [[ `echo $git_status | grep "no changes added to commit"` != "" ]]; then
      echo -e $COLOR_YELLOW
   elif [[ `echo $git_status | grep "Changes to be committed"` != "" ]]; then
      echo -e $COLOR_BLUE
   elif [[ `echo $git_status | grep "Untracked"` != "" ]]; then
      echo -e $COLOR_RED
   else
      echo -e $COLOR_WHITE
   fi
}

function git_branch {
   local git_status="$(git status 2> /dev/null)"
   local on_branch="On branch ([^${IFS}]*)"
   local on_commit="HEAD detached at ([^${IFS}]*)"

   if [[ $git_status =~ $on_branch ]]; then
      local branch=${BASH_REMATCH[1]}
      echo "($branch)"
   elif [[ $git_status =~ $on_commit ]]; then
      local commit=${BASH_REMATCH[1]}
      echo "($commit)"
   fi
}

PS1="\[$COLOR_WHITE\]\n\t \u@\h [\w]"
PS1+="\[\$(git_color)\]"
PS1+="\$(git_branch)"
PS1+="\[$COLOR_BLUE\]\$\[$COLOR_RESET\] "
export PS1

# NVM SECTION

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

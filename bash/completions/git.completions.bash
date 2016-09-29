# git completion script.
#
# Some users rely on the __git_ps1 function becoming available
# when bash-completion is loaded.  Continue to load this library
# at bash-completion startup for now, to ease the transition to a
# world order where the prompt function is requested separately.
#
if [[ -f /etc/bash_completion.d/git-prompt ]]; then
  . /etc/bash_completion.d/git-prompt
fi

if [[ -f /etc/bash_completion.d/tig ]]; then
  . /etc/bash_completion.d/tig
fi

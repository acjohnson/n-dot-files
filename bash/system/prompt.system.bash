# PS Fragment :: LCRV (Last Command Resulting Value)
PS_LCRV='$([ $LCRV -eq 0 ] && echo -e "\[${GREEN}\]✔" || echo -e "\[${RED}\]✘")'

# PS Fragment :: OOSM (Out-Of-Service Mode)
PS_OOSM='$(oosm_active && echo -e " \[${WHITE}\]☼\[${R_COLOR}\] " || echo " ")'

# PS Fragment :: USER_COLOR (Root or Regular Users)
is_user_root && PS_USER_COLOR=${RED} || PS_USER_COLOR=${R_COLOR}

# Prompt Statement 1 :: Interactive Default
PS1="\n${PS_LCRV}${PS_OOSM}\[${PS_USER_COLOR}\]\u@\h\[${R_COLOR}\]:\[${BLUE}\]\w\[${R_COLOR}\] \[${MAGENTA}\]\$(__git_ps1 '  %s ')\[${R_COLOR}\]\n$ "

# Prompt Statement 2 :: Interactive Continuation
PS2='continue-> '

# Prompt Statement 3 :: Select Loop
PS3='#? '

# Prompt Statement 4 :: Debug Mode
PS4="+ ${MAGENTA}"'${BASH_SOURCE##*/}'" : ${RED}"'${FUNCNAME}()'" ${GREEN}["'${LINENO}'"]${R_COLOR} » "

# Trim the CWD
export PROMPT_DIRTRIM=5

# Git Prompt
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="verbose"
export GIT_PS1_DESCRIBE_STYLE="branch"

#
# Function: prompt_command()
#
# Defines the commands that will be executed prior to issuing each primary
# Prompt Statement (PS1).
#
prompt_command () {
  # Save the LCRV for later (otherwise it will be altered)
  LCRV=$?

  # Write to the history file the previous command (if OOSM is not active)
  ! oosm_active && history -a
}

# Assign the function for the command prompt
PROMPT_COMMAND=prompt_command

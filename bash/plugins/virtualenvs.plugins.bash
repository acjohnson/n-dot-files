#
# Setup and import virtualenvwrapper functions
#
#  1. Create a directory to hold the virtual environments.
#     (mkdir $HOME/.virtualenvs).
#  2. Add a line like "export WORKON_HOME=$HOME/.virtualenvs"
#     to your .bashrc.
#  3. Add a line like "source /path/to/this/file/virtualenvwrapper.sh"
#     to your .bashrc.
#  4. Run: source ~/.bashrc
#  5. Run: workon
#  6. A list of environments, empty, is printed.
#  7. Run: mkvirtualenv temp
#  8. Run: workon
#  9. This time, the "temp" environment is included.
# 10. Run: workon temp
# 11. The virtual environment is activated.
#

# Python virtual environments directory
export WORKON_HOME=$HOME/.virtualenvs
mkdir -p $WORKON_HOME

# Project directory
export PROJECT_HOME=$HOME/Projects
mkdir -p $PROJECT_HOME

# Find virtualenvwrapper.sh and source it
virtualenvwrapper_bin=`which virtualenvwrapper.sh 2>/dev/null`
[ $? == 0 ] && source $virtualenvwrapper_bin
unset virtualenvwrapper_bin

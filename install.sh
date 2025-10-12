#!/usr/bin/env bash

# DEBUG
# echo "The script you are running has:"
# echo "basename: [$(basename "$0")]"
# echo "dirname : [$(dirname "$0")]"
# echo "pwd     : [$(pwd)]"

# This next line gets the absolute path to the directory containing the script
# we use cd to change to the path provided by BASH_SOURCE (which may be relative)
# finally we print the absolute directory with `pwd`
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
echo "The script is located in: $SCRIPT_DIR"

# create tmux.conf symbolic link to this repo
# this allows you to easily update your system with any changes
# via `git pull`

linkTmuxConfig=$(ln -f -s $SCRIPT_DIR/.tmux.conf $HOME/.tmux.conf)

checkForGit=$(which git)

# $? is the return code of the last command
if [[ $? == 1 ]]; then
	echo "[!] Missing git!"
fi

tpmDir="$HOME/.tmux/plugins/tpm"

if [ -d "$tpmDir" ]; then
  echo "[+] Directory '$tpmDir' exists."
else
  echo "[-] Directory '$tpmDir' does not exist. Cloning TPM."
  cloneTPM=$(git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm)
fi

echo "====================================================="
echo "[+] All set!"

# Bash Cheat Sheet
This section contains .bash_functions/ and .bash_aliases used and tested in Linux ubuntu 18.04

## Quick set up
- From this directory copy the resources to your $HOME/
```bash
cp --recursive .bash_functions/ $HOME
cp .bash_aliases $HOME
```
- Append to the end of your .bashrc file
```bash
cat <<EOF >> $HOME/.bashrc

home_bash_functions=$HOME/.bash_functions/bash_functions.sh
if [ -f \$home_bash_functions ]; then
      source \$home_bash_functions
fi
EOF
```
- source the files
```bash
source $HOME/.bash_aliases
source $HOME/.bashrc
```
- Create links
```
ln -s lsd lsl
ln -s lsd lsf
ln -s lsd lsx
```

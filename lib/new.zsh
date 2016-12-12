#! /bin/zsh -f +-no-match --aliases
cd ${TEMPLATES:-templates}

# Active Finder tab
osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)'|
read &&

# Select diff tool
for tool (opendiff ksdiff) if (/usr/bin/which -s $tool) alias diff=$tool

case $@ in
  open*|mv*) eval $@;; # Run command
  *) # else

  if [ -f $@ ] # Copy template file or diff with incumbent
  then cp -n $@ $REPLY || diff {$REPLY/,}$@

  # Copy [last modified] template file to match .ext
  elif [ -f *.$@:e(om[1]) ]
  then cp *.$@:e(om[1]) $REPLY/$@

  # Folder or symlink
  elif [ -d $REPLY/$@ ]
  then diff {$REPLY/,}$@
  elif [ -d $@ ]
  then cp -RL $@ $REPLY

  # New folder
  elif [[ $@ != *.* ]]
  then mkdir -p $REPLY/$@

  # New file
  else touch $REPLY/$@
  fi
  # Reveal in Finder
  open -R $REPLY/*(om[1]);;
esac

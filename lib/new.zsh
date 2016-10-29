#! /bin/zsh -f +o no_match --aliases
cd ${TEMPLATES:-templates} #: ${TEMPLATES:=templates}
#((!$#)) && exit

# Active Finder tab
osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)'|
#decodeURI(Application("Finder").insertionLocation().url()).substr(7)
read &&

# Select diff tool
for tool (opendiff ksdiff) if (/usr/bin/which -s $tool) alias diff=$tool

case $@ in
  open*) eval $@;; # Run command
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
  then cp -RL $@ $REPLY #-n

  # New folder
  elif [[ $@ != *.* ]] #=~ '\.[A-z]{1,4}$'
  then mkdir -p $REPLY/$@

  # New file
  else touch $REPLY/$@
  fi
  # Reveal in Finder
  open -R $REPLY/*(om[1]);;
esac

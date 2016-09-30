#! /bin/zsh -f +o no_match --aliases
cd ${TEMPLATES:-templates} #: ${TEMPLATES:=templates}
#((!$#)) && exit

# Active Finder tab
osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)'|
#decodeURI(Application("Finder").insertionLocation().url()).substr(7)
read &&

if which ksdiff # Kaleidoscope
then alias diff=ksdiff
elif which opendiff # Xcode CLT
then alias diff=opendiff
fi

case $@ in
  reveal*) open -R ${@#* };;
  open*|edit*) open ${@#* };;
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

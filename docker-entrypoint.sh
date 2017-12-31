#!/bin/sh -x
cd /factorio
if [ ! -f version.txt ]; then
    oldVersion="none"
else
  oldVersion=`cat version.txt`
fi

if [ "$oldVersion" = "$1" ]; then
  echo "no need for an update"
else
  echo "need to update from" $oldVersion "to" $1
  echo "delete old Version"
  rm -r bin
  rm -r data
  rm config-path.cfg
  echo $1>version.txt
  mkdir update 
  cd update
  echo "download Version:" $1
  curl -sSL https://www.factorio.com/get-download/$1/headless/linux64 -o factorio_headless_x64_$1.tar.xz
  echo "extract version" $1
  tar xf factorio_headless_x64_$1.tar.xz
  chmod ugo=rwx factorio 
  cp -r factorio/* /factorio
  cd ..
  rm -r update
fi

if [ ! -f saves/*.zip ]; then
    echo "create first savegame"
    ./bin/x64/factorio --create ./saves/my-save.zip  
else
  echo "savegame available"
fi
./bin/x64/factorio --start-server-load-latest
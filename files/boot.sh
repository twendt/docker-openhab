#!/bin/bash
SOURCE=/opt/openhab/addons-avail
DEST=/opt/openhab/addons
ADDONFILE=/opt/openhab/addons.cfg

function addons {
  # Remove all links first
  rm $DEST/*

  # create new links based on input file
  while read STRING
  do
    echo Processing $STRING...
    STRING=`echo $STRING | sed s/VERSION/${OPENHAB_VERSION}/g`
    if [ -f "$SOURCE/$STRING" ]
    then
      ln -s $SOURCE/$STRING $DEST/$STRING
      echo link created.
    else
      echo not found.
    fi
  done < "$ADDONFILE"
}

if [ -f "$ADDONFILE" ]
then
  addons
else
  echo addons.cfg not found.
fi

exec /opt/openhab/start.sh

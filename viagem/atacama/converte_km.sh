#!/bin/sh
# converte_km.sh para contar a viagem do zero
# 20000421 aurelio

IFS=
while read LINHA ; do
  KM=; KM=`echo $LINHA | sed -n 's§^\(.....\) \([0-9]\{5\}\).*§\2§p'`
  [ "$KM" ] && KM=$((KM-73020)) 
  echo "$LINHA" | sed "s§^\(.....\) \([0-9]\{5\}\)§\1 `printf %05d $KM`§" 
done


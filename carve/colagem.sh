#!/bin/sh
# colagem.sh
# 2004-10-15 Aurelio Marinho Jargas

path=/media/foto/Yahoo/carveboard/
#size=100x100
size=100x100
img_por_linha=6
background=black
out=fotos.jpg

montage +font +label -shadow 0x0 -frame 0x0+0+0 \
-tile $img_por_linha -borderwidth 0x0+0+0 \
-background $background -geometry $size+0+0 \
$path/* $out
echo saved $out
open $out

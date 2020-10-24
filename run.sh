#!/bin/bash

# Dieses Script startet den oc_downloader für Videos der TU Wien.
# Gewünschte Videos werden in die Datei dl_list.txt geschrieben.
# Danach wird der Download gestartet.
# (c) Oct 2020 by flof

echo """
Opencast-Downloadscript für die TU Wien
=======================================
(c) 2020 by flof
"""
if [ -e dl_list.txt ]
then
	read -p 'Soll die vorhandene Hilfsdatei dl_list.txt gelöscht werden? [y/n] ' rm_set
	if [ $rm_set == 'y' ]
	then
		rm dl_list.txt
	else
		echo ''
		echo 'Achtung es könnten bereits vorhandene Dateien nochmals gedownloadet werden!' 
		read -p 'Abbruch? [y/n] ' exit_var
		if [ $exit_var == 'y' ]
		then
			exit
		fi
	fi
fi

python3 oc_download.py -U 'https://oc-presentation.ltcc.tuwien.ac.at'

read -p 'Soll der Download jetzt gestartet werden? [y/n] ' run_dl

if [ $run_dl == 'y' ]
then
	err=0
	while read -r url filename tail; do
		wget -O "$filename" "$url" || err=1
	done <dl_list.txt
fi

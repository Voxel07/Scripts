#!/bin/bash
AKTUELL=$(/bin/date +%d.%m.%Y-%H:%M:%S)
Zeit=$(/bin/date +%H:%M:%S)
prozessorauslastung=$[100-$(top -bn 2 -d 1 | grep "Cpu(s)" | tail -n1 | awk '{print $8}' | cut -d "," -f1)]
stotalmb=$(echo "scale=3; $(grep -i memTotal /proc/meminfo|awk '{ print $2 }'| sed 's/\ //') / 1024" | bc | sed "s/^\(-\)\?\./\10./")
sfreimb=$(echo "scale=3; $(grep -i memFree /proc/meminfo|awk '{ print $2 }'| sed 's/\ //') / 1024" | bc | sed "s/^\(-\)\?\./\10./")
sbelegtmb=$(echo "scale=3; $stotalmb - $sfreimb" | bc | sed "s/^\(-\)\?\./\10./")
ramprozent=$(echo "scale=8; $(echo "scale=8; 100 / $stotalmb" | bc | sed "s/^\(-\)\?\./\10./") * $sbelegtmb" | bc | sed "s/^\(-\)\?\./\10./" | awk '{printf "%.2f\n", $1}' )
cputemperatur=$(vcgencmd measure_temp)
laufzeit=$(uptime -p)
seit=$(uptime -s)


#Vermutlich Pfusch tut aber :D
#Speicherbelegung der Hauptfestplatte herausfinden hier dev/root
Speicher=$(df -h)
Speicher=${Speicher#*/dev/root}
Speicher=${Speicher%%%*}
# Speicher aufteilen in frei/beleg/gesammt
IFS=" "
set - $Speicher
gesammt=$1
belegt=$2
frei=$3


#Ausgabe für schnelle Übersicht
#Speichert alle Daten bis die Datei gelöscht wird
echo "$AKTUELL | Online seit: $seit -> $laufzeit - $cputemperatur - CPU-Auslastung: $prozessorauslastung% - RAM gesamt: $stotalmb MB / frei: $sfreimb MB / belegt: $sbelegtmb MB ($ramprozent%)|Festplattenspeicher -> Gesammt: $gesammt belegt: $belegt f$" >>/home/pi/Desktop/daten.txt


#Nur wichtige Daten für PHP
#Zeiten
datum=$(echo "$seit" | cut -d " " -f 1)
zeit=$(echo "$seit" | cut -d " " -f 2)

#Wenn genau 0 Minuten
#if [ "$minuten" = "" ]
#then minuten=0
#fi

#Temperatur ausschneiden
#nur der aktuelle Werte in der ersten Zeile wird jede Minute überschrieben.
temperatur=$(echo "$cputemperatur" | cut -c 6-9)
echo "$Zeit|$datum|$zeit|$temperatur|$prozessorauslastung|$sbelegtmb|$belegt"  >/var/www/WRW-Hompage/Logdaten/daten.txt


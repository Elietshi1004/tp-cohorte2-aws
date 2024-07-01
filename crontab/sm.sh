#!/bin/bash

# Configuration
sysadmin_email="mtshingombe@gmail.com"

# Récupération des informations système
mem_total=$(free -m | awk '/Mem:/ {print $2}')
mem_used=$(free -m | awk '/Mem:/ {print $3}')
mem_free=$(free -m | awk '/Mem:/ {print $4}')
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')
disk_total=$(df -h / | awk '/\// {print $2}')
disk_used=$(df -h / | awk '/\// {print $3}')
disk_free=$(df -h / | awk '/\// {print $4}')

# Création du message
message="Rapport de performance du serveur à $(date):\n\n"
message+="Mémoire:\n"
message+="Total: $mem_total MB\n"
message+="Utilisée: $mem_used MB\n"
message+="Libre: $mem_free MB\n\n"
message+="CPU:\n"
message+="Utilisation: $cpu_usage\n\n"
message+="Stockage:\n"
message+="Total: $disk_total\n"
message+="Utilisé: $disk_used\n"
message+="Libre: $disk_free\n"

# Envoi du rapport par email
echo -e "$message" | mailx -s "Rapport de performance du serveur" $sysadmin_email
echo "$(date) executé et mail envoyé $message ">>/home/ec2-user/tp/script/monitor.log



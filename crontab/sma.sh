#!/bin/bash

# Configuration
aws_region="eu-west-2"
sns_topic_arn="arn:aws:sns:eu-west-2:058264135188:testcohortemail2"
subject="Rapport de performance du serveur"
sysadmin_email="mtshingombe@gmail.com"
message_group_id="5d8c9a2f-1234-5678-90ab-cdef12345678"

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


aws --region $aws_region sns publish \
    --topic-arn $sns_topic_arn \
    --subject "$subject" \
    --message "$message" \
    --message-attributes '{"email":{"DataType":"String","StringValue":"'$sysadmin_email'"},"MessageGroupId":{"DataType":"String","StringValue":"'$message_group_id'"}}'

# Envoi du rapport par sns


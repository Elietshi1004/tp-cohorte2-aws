#!/bin/bash

# Chemins des fichiers de log
LOG_FILES=(
  "/home/ec2-user/tp/nodejs/nodejs_server.log"
  "/var/www/html/logs/app.log"
)

# Taille maximale du fichier de log (en Ko)
MAX_LOG_SIZE=2

for LOG_FILE in "${LOG_FILES[@]}"
do
    # Vérifier la taille du fichier de log
    LOG_SIZE=$(du -k "$LOG_FILE" | cut -f1)
    if [ $LOG_SIZE -ge $MAX_LOG_SIZE ]; then
        # Renommer le fichier de log existant
        TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
        mv "$LOG_FILE" "${LOG_FILE%.*}_$TIMESTAMP.log"
        # Créer un nouveau fichier de log vide
        touch "$LOG_FILE"
        # Changer les autorisations du nouveau fichier de log
        chmod 644 "$LOG_FILE"
    fi
done

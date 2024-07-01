#!/bin/bash

# Définir le dossier à archiver
FOLDER_TO_ARCHIVE="/home/ec2-user/tp/tp25/doc"

# Définir le nom du fichier d'archive
ARCHIVE_FILENAME="archive_$(date +"%Y-%m-%d_%H-%M-%S").zip"

# Définir le bucket S3 où envoyer l'archive
S3_BUCKET="testfilezip"

# Définir le fichier de log
LOG_FILE="/home/ec2-user/tp/tp25/logs/log.txt"

# Vérifier si le fichier de log existe, sinon le créer
if [ ! -f "$LOG_FILE" ]; then
    touch "$LOG_FILE"
    echo "0" > "$LOG_FILE"
fi

# Lire le nombre d'envois à partir du fichier de log
SEND_COUNT=$(cat "$LOG_FILE")

# Tant que le nombre d'envois est inférieur à 4
if [ $SEND_COUNT -lt 5 ]; then
    # Archiver le dossier
    zip -r "$ARCHIVE_FILENAME" "$FOLDER_TO_ARCHIVE"

    # Envoyer l'archive vers S3
    aws s3 cp "$ARCHIVE_FILENAME" s3://"$S3_BUCKET"/"$ARCHIVE_FILENAME"

    # Incrémenter le compteur d'envois
    SEND_COUNT=$((SEND_COUNT+1))
    echo "$SEND_COUNT" > "$LOG_FILE"

    # Supprimer le fichier d'archive local
    rm "$ARCHIVE_FILENAME"

else

# Afficher un message indiquant que le script s'est arrêté
echo "Le script s'est arrêté après 4 envois."
fi

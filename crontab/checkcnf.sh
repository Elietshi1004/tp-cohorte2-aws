#!/bin/bash

config_dir="/home/ec2-user/config"
config_file="server.conf"
github_repo="https://github.com/Elietshi1004/formation"


  if [ ! -f "$config_dir/$config_file" ]; then
    echo "$(date) - Le fichier $config_file n'existe pas, téléchargement depuis GitHub." >> /home/ec2-user/check_server_conf.log
    mkdir -p "$config_dir"
    git clone "$github_repo" "$config_dir"
  else
    echo "$(date) - Le fichier $config_file existe déjà dans $config_dir." >> /home/ec2-user/check_server_conf.log
  fi



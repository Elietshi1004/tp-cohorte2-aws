#!/bin/bash


  curl_output=$(curl -s https://www.google.com)
  echo "$curl_output" >> /home/ec2-user/tp/script/google_curl.log
  echo "$(date) - Curl de google.com effectué" >> /home/ec2-user/tp/script/google_curl.log
  sleep 30

  curl_output=$(curl -s https://www.google.com)
  echo "$curl_output" >> /home/ec2-user/tp/script/google_curl.log
  echo "$(date) - Curl de google.com effectué" >> /home/ec2-user/tp/script/google_curl.log
 



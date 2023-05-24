#!/bin/bash

USERS_FILE="/users.txt"

while read line; do
  username=$(echo "$line" | cut -d':' -f1)
  password=$(echo "$line" | cut -d':' -f2)
  test=$(id -u "$username")
  useradd -g vmail -m $username -p $(openssl passwd -1 $password)

  #mkdir -p /var/mail/"$username"
  #chown "$username:$username" /var/mail/"$username"
  #chmod 0700 /var/mail/"$username"
done < "$USERS_FILE"

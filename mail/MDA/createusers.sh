#!/bin/bash

USERS_FILE="/users.txt"

while read -r line; do
  username=$(echo "$line" | cut -d':' -f1)
  password=$(echo "$line" | cut -d':' -f2)

  useradd -m -s /bin/bash "$username"
  echo "$username:$password" | chpasswd

  mkdir -p /var/mail/"$username"

  chown "$username:$username" /var/mail/"$username"
  chmod 0700 /var/mail/"$username"
done < "$USERS_FILE"

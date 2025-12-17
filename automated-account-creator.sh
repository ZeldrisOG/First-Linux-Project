#!/bin/bash

# Root check
if [[ "${EUID}" -ne 0 ]]; then
  echo "Please run as root"
  exit 1
fi

# Get IP
LOCAL_IP=$(hostname -I | awk '{print $1}')

# User input
read -p 'Enter username to continue: ' USER_NAME
read -p 'Enter Real Name to continue: ' REAL_NAME
read -s -p 'Enter Password to continue: ' PASSWORD
echo

# Create account
useradd -c "${REAL_NAME}" -m "${USER_NAME}"
if [[ "$?" -ne 0 ]]; then
  echo "Account creation failed"
  exit 1
fi

# Set password
echo "${PASSWORD}" | passwd --stdin "${USER_NAME}"
if [[ "$?" -ne 0 ]]; then
  echo "Password set failed"
  exit 1
fi

# Output info
echo "Your username is ${USER_NAME}"
echo "Your password is ${PASSWORD}"
echo "Host: ${LOCAL_IP}"

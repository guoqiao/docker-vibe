#!/bin/bash
set -e

# Default user to run as
TARGET_USER="node"
TARGET_HOME="/home/node"

# Get current node user's UID/GID
CURRENT_UID=$(id -u ${TARGET_USER})
CURRENT_GID=$(id -g ${TARGET_USER})

# Use HOST_UID/HOST_GID if provided, otherwise use current
HOST_UID="${HOST_UID:-$CURRENT_UID}"
HOST_GID="${HOST_GID:-$CURRENT_GID}"

# Only modify if running as root and UID/GID differ
if [ "$(id -u)" = "0" ]; then
    # Modify group if needed
    if [ "$HOST_GID" != "$CURRENT_GID" ]; then
        # Check if a group with this GID already exists
        if getent group "$HOST_GID" > /dev/null 2>&1; then
            # Remove existing group with this GID
            existing_group=$(getent group "$HOST_GID" | cut -d: -f1)
            groupdel "$existing_group" 2>/dev/null || true
        fi
        groupmod -g "$HOST_GID" "${TARGET_USER}"
    fi

    # Modify user if needed
    if [ "$HOST_UID" != "$CURRENT_UID" ]; then
        # Check if a user with this UID already exists
        if getent passwd "$HOST_UID" > /dev/null 2>&1; then
            # Remove existing user with this UID
            existing_user=$(getent passwd "$HOST_UID" | cut -d: -f1)
            userdel "$existing_user" 2>/dev/null || true
        fi
        usermod -u "$HOST_UID" "${TARGET_USER}"
    fi

    # Fix ownership of home directory if UID/GID changed
    if [ "$HOST_UID" != "$CURRENT_UID" ] || [ "$HOST_GID" != "$CURRENT_GID" ]; then
        chown -R "${HOST_UID}:${HOST_GID}" "${TARGET_HOME}"
    fi

    # Execute the command as the target user
    exec gosu "${TARGET_USER}" "$@"
else
    # Already running as non-root, just exec the command
    exec "$@"
fi

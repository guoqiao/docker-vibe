#!/bin/bash
set -e

# modify container user/group id to match host user/group id

# Default user to run as
CTNR_USER="node"
CTNR_HOME="/home/${CTNR_USER}"

# Get container user's UID/GID
CTNR_UID=$(id -u ${CTNR_USER})
CTNR_GID=$(id -g ${CTNR_USER})

# Use HOST_UID/HOST_GID if provided, otherwise use current
HOST_UID="${HOST_UID:-$CTNR_UID}"
HOST_GID="${HOST_GID:-$CTNR_GID}"

# Only modify if running as root and UID/GID differ
if [ "$(id -u)" = "0" ]; then
    # Modify group if needed
    if [ "$HOST_GID" != "$CTNR_GID" ]; then
        # Check if a group with this GID already exists
        if getent group "$HOST_GID" > /dev/null 2>&1; then
            # Remove existing group with this GID
            existing_group=$(getent group "$HOST_GID" | cut -d: -f1)
            groupdel "$existing_group" 2>/dev/null || true
        fi
        groupmod -g "$HOST_GID" "${CTNR_USER}"
    fi

    # Modify user if needed
    if [ "$HOST_UID" != "$CTNR_UID" ]; then
        # Check if a user with this UID already exists
        if getent passwd "$HOST_UID" > /dev/null 2>&1; then
            # Remove existing user with this UID
            existing_user=$(getent passwd "$HOST_UID" | cut -d: -f1)
            userdel "$existing_user" 2>/dev/null || true
        fi
        usermod -u "$HOST_UID" "${CTNR_USER}"
    fi

    # Fix ownership of home directory if UID/GID changed
    if [ "$HOST_UID" != "$CTNR_UID" ] || [ "$HOST_GID" != "$CTNR_GID" ]; then
        chown -R "${HOST_UID}:${HOST_GID}" "${CTNR_HOME}"
    fi

    # Execute the command as the target user
    exec gosu "${CTNR_USER}" "$@"
else
    # Already running as non-root, just exec the command
    exec "$@"
fi

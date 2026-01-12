#!/bin/bash

set -xue

# ensure agent config dirs are owned by host user correctly
owner="$(id -u):$(id -g)"
mkdir -p ~/.claude && sudo chown -R "${owner}" ~/.claude
mkdir -p ~/.gemini && sudo chown -R "${owner}" ~/.gemini

# claude code will create a folder ~/.claude/projects/-home-node-${name}
# so it's necessary to use specific folder name
name=$(basename $(pwd))
workdir=/home/node/${name}

# use a global .env file, so it can be shared across all projects/containers
env_file=${1:-~/.env.d/vibe.env}

# agent config dirs are mounted into container
# so oauth can work directly, and sessions can persist

# run container with host uid/gid to avoid perm issues
# HOST_UID/HOST_GID are passed to the entrypoint script
# which will modify the node user's UID/GID to match
docker run -it --rm --platform linux/amd64 --pull never \
    -e HOST_UID=$(id -u) \
    -e HOST_GID=$(id -g) \
    --env-file ${env_file} \
    -v ~/.claude:/home/node/.claude \
    -v ~/.gemini:/home/node/.gemini \
    -v $(pwd):${workdir} -w ${workdir} \
    --name ${name} \
    vibe


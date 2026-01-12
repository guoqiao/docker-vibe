#!/bin/bash

set -xue

# run container with same user id to avoid perm issues
# HOST_UID/HOST_GID are passed to the entrypoint script
# which will modify the node user's UID/GID to match
owner="$(id -u):$(id -g)"
mkdir -p ~/.claude && sudo chown -R "${owner}" ~/.claude
mkdir -p ~/.gemini && sudo chown -R "${owner}" ~/.gemini

name=$(basename $(pwd))
# claude code will create a folder ~/.claude/projects/-home-node-${name}
# so it's necessary to use specific folder name
workdir=/home/node/${name}

env_file=${1:-~/.env.d/vibe.env}

# agent config dirs are mounted into container
# so oauth can work directly, and sessions can persist

docker run -it --rm --platform linux/amd64 \
    -e HOST_UID=$(id -u) \
    -e HOST_GID=$(id -g) \
    --env-file ${env_file} \
    -v ~/.claude:/home/node/.claude \
    -v ~/.gemini:/home/node/.gemini \
    -v $(pwd):${workdir} -w ${workdir} \
    --name ${name} \
    vibe


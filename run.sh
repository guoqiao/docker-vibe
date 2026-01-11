#!/bin/bash

set -xue

# run container with same user id to avoid perm issues
# assume the user id exists in both host and container
# which is normally 1000 on debian/ubuntu
owner="$(id -u):$(id -g)"
sudo chown -R "${owner}" ~/.claude
sudo chown -R "${owner}" ~/.gemini

name=$(basename $(pwd))
# claude code will create a folder ~/.claude/projects/-home-node-${name}
# so it's necessary to use specific folder name
workdir=/home/node/${name}

ENV_FILE=${ENV_FILE:-~/.env.d/vibe.env}

docker run -it --rm \
    -u ${owner} \
    --env-file ${ENV_FILE} \
    -v ~/.claude:/home/node/.claude \
    -v ~/.gemini:/home/node/.gemini \
    -v $(pwd):${workdir} -w ${workdir} \
    --name ${name} \
    vibe


#!/bin/bash

set -xue

touch .env

docker run -it --rm \
    --env-file .env \
    -v $(pwd):/workspace \
    vibe


# docker-vibe

Vide Coding in Docker with all the batteries.

## Why I need this ?

A few reasons:
- start vibe coding fast
- use docker container as a sandbox
  * avoid pollute your system
  * avoid code agent break your system
  * avoid malious code steal your data

## Usage

in this repo:
```
# build docker image called `vibe`
make build

# link ./run.sh to ~/bin/vibe
# please ensure ~/bin is in your $PATH
make link
```

in your project:
```
cd path/to/project
vim .env  # edit your .env

# start vibe container, load .env, and mount pwd at /workspace
vibe
```

available code agents:
- claude-code
- gemini-cli
- opencode
- amp
- pi

available code executors:
- bash
- python/uv/uvx
- node/npm/pnpm/bun/bunx
- golang

available package managers:
- apt/apt-get
- brew
- pip/uv
- npm/pnpm/bun


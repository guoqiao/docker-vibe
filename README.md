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

in this repo (one-off):
```
# build docker image called `vibe`
make build

# link ./run.sh to ~/bin/vibe
# please ensure ~/bin is in your $PATH
make link
```

work on a project:
```
cd path/to/project

# edit default .env file
vim ~/.env.d/vibe.env
vibe

# or load a custom .env file
vibe path/to/my/.env
```

`.env` example for claude code:
(not needed if you use oauth for claude code)
```
ANTHROPIC_BASE_URL=http://192.168.20.55:8317
ANTHROPIC_AUTH_TOKEN=sk-xxxx

# optional, advance
# opus: most powerful, slow, expensive
# sonnet: balanced, daily tasks
# haiku: fast, cheap, simple tasks
ANTHROPIC_DEFAULT_OPUS_MODEL=gemini-claude-opus-4-5-thinking
ANTHROPIC_DEFAULT_SONNET_MODEL=gemini-claude-sonnet-4-5-thinking
ANTHROPIC_DEFAULT_HAIKU_MODEL=gemini-3-flash-preview
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


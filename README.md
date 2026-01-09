# docker-vibe

Vide Coding in Docker with all the tools.

## Usage

in this repo:
```
make build
make link  # link ./run.sh to ~/bin/vibe, please ensure ~/bin is in your $PATH
```

in your project:
```
cd path/to/project
vim .env  # edit your .env

# this will start the vibe container, pass .env in, and mount current dir into contianer at /workspace
vibe
```

available code agents:
- claude-code
- gemini-cli
- opencode
- amp

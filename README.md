# docker-vibe

**Vibe Coding in Docker with all the batteries included.**

A sandboxed, portable Docker environment for AI-powered coding that keeps your system clean and secure.

---

## 🚀 What is This?

`docker-vibe` provides a pre-configured Docker container with all the tools you need for modern AI-assisted development. It's designed to:

- **Isolate AI coding agents** in a secure sandbox to prevent system damage or data leaks
- **Keep your host system clean** by installing all dependencies inside the container
- **Get you coding fast** with popular AI agents, cli tools and  language runtimes pre-installed
- **Persist your sessions** across container restarts via mounted config directories

Perfect for experimenting with AI coding agents, rapid prototyping, or working in a consistent environment across multiple machines.

---

## 🎯 Why Use This?

**Security & Isolation**
- AI agents run in a sandboxed environment, protecting your host system
- Prevents malicious code from accessing sensitive data
- No risk of breaking your development environment

**Convenience**
- All major AI coding agents pre-installed and ready to use
- Multiple language runtimes (Node.js, Python, Go) configured out of the box
- OAuth and session configs persist across container restarts
- No need to pollute your system with various tools and dependencies

**Developer Experience**
- File ownership automatically synced between host and container
- Your current directory is mounted as the workspace
- Helpful aliases like `claude-yolo` for faster iteration

---

## 📦 What's Included?

### AI Coding Agents
- **[claude-code](https://github.com/anthropics/claude-code)** - Anthropic's Claude AI coding assistant
- **[gemini-cli](https://www.npmjs.com/package/@google/gemini-cli)** - Google's Gemini AI CLI
- **[opencode](https://opencode.dev/)** - Multi-model AI coding agent
- **[amp](https://ampcode.com/)** - Amp coding assistant
- **[pi-coding-agent](https://www.npmjs.com/package/@mariozechner/pi-coding-agent)** - Pi coding assistant

### Language Runtimes
- **Node.js** (LTS) with `npm`, `pnpm`, and `bun`
- **Python 3** with `uv` for fast package management
- **Go** (latest stable version)

### Development Tools
- **Search & Navigation**: `ripgrep`, `fd-find`, `fzf`, `ag`
- **Code Quality**: `shellcheck`, `yamllint`, `ast-grep`
- **Utilities**: `jq`, `bat`, `tree`, `tmux`, `httpie`, `vim`
- **Debugging**: `htop`, `lsof`, `strace`, `net-tools`

### Package Managers
- **System**: `apt`, `apt-get`
- **Python**: `pip`, `uv`, `uvx`
- **JavaScript**: `npm`, `pnpm`, `bun`

---

## 🛠️ Installation

**One-time setup** (run these commands in this repository):

```bash
# 1. Build the Docker image
make build

# 2. Link the launcher script to ~/bin (ensure ~/bin is in your $PATH)
make link
```

That's it! You can now use `vibe` from anywhere.

---

## 📖 Usage

### Basic Usage

Navigate to any project directory and run:

```bash
cd path/to/your/project
vibe
```

This will:
- Launch a Docker container with the current directory mounted as your workspace
- Drop you into a bash shell with all AI agents and tools available
- Preserve file ownership so files created in the container belong to your host user

### Using AI Agents

Once inside the container:

```bash
# Start Claude Code
claude

# Or use "yolo mode" to skip permission prompts (faster iteration)
claude-yolo

# Start Gemini CLI
gemini

# Use Gemini in yolo mode
gemini-yolo

# Other agents
opencode
amp
pi
```

### Configuration with .env Files

#### Default Configuration

Create a default `.env` file for all your projects:

```bash
# Create config directory
mkdir -p ~/.env.d

# Edit your default config
vim ~/.env.d/vibe.env
```

Then simply run `vibe` - it will automatically load `~/.env.d/vibe.env`.

#### Project-Specific Configuration

Use a custom `.env` file for specific projects:

```bash
vibe /path/to/custom/.env
```

#### Example .env File

For Claude Code with API authentication (not needed if using OAuth):

```bash
# API Configuration
ANTHROPIC_BASE_URL=http://192.168.20.55:8317
ANTHROPIC_AUTH_TOKEN=sk-xxxx

# Optional: Model Selection
# opus: most powerful, slower, more expensive
# sonnet: balanced performance, great for daily tasks
# haiku: fast, cheap, good for simple tasks
ANTHROPIC_DEFAULT_OPUS_MODEL=gemini-claude-opus-4-5-thinking
ANTHROPIC_DEFAULT_SONNET_MODEL=gemini-claude-sonnet-4-5-thinking
ANTHROPIC_DEFAULT_HAIKU_MODEL=gemini-3-flash-preview
```

---

## 🔧 How It Works

### File Permissions
The container automatically syncs file ownership between your host user and the container user, so all files created inside the container will be owned by your host user (not root!).

### Persistent Configurations
Your AI agent configurations are stored on the host machine:
- `~/.claude` - Claude Code sessions and OAuth tokens
- `~/.gemini` - Gemini CLI configurations

These directories are mounted into the container, so you don't need to re-authenticate every time.

### Workspace Mounting
Your current working directory is mounted into the container as `/home/node/<directory-name>`, and the container starts in this location automatically.

---

## 🤝 Contributing

Found a bug or have a suggestion? Feel free to open an issue or submit a pull request!

---

## 📄 License

This project is provided as-is for the community. Use it to build amazing things! 🚀


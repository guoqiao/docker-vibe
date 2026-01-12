# https://hub.docker.com/_/node
FROM node:lts-trixie

RUN apt-get update && apt-get install -y \
    build-essential \
    ca-certificates \
    curl wget httpie \
    git tree less \
    time \
    tmux \
    htop lsof \
    jq yamllint \
    ripgrep fd-find silversearcher-ag \
    bat fzf \
    shellcheck yamllint \
    strace net-tools \
    vim \
    sudo \
    gosu

RUN npm install -g \
    npm \
    pnpm \
    bun \
    @ast-grep/cli@latest \
    @mariozechner/pi-coding-agent@latest \
    @anthropic-ai/claude-code@latest \
    @google/gemini-cli@latest \
    opencode-ai@latest

RUN bunx oh-my-opencode install --no-tui --claude=no --chatgpt=no --gemini=no

RUN curl -fsSL https://ampcode.com/install.sh | bash

# install uv
# https://docs.astral.sh/uv/guides/integration/docker/#available-images
# not working:
# COPY --from=ghcr.io/astral-sh/uv:python3.14-trixie-slim /uv /uvx /bin/
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
RUN ln -sf /usr/bin/python3 /usr/bin/python

# install go
COPY --from=golang:latest /usr/local/go /usr/local/go
ENV PATH="/usr/local/go/bin:${PATH}"
ENV GOPATH="/root/go"
ENV PATH="${GOPATH}/bin:${PATH}"

# install homebrew
#RUN useradd -m -s /bin/bash linuxbrew
#COPY --from=homebrew/brew:latest /home/linuxbrew/.linuxbrew /home/linuxbrew/.linuxbrew
#RUN chown -R linuxbrew:linuxbrew /home/linuxbrew/.linuxbrew
#ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"
#ENV HOMEBREW_NO_AUTO_UPDATE=1

# Configure node user with sudo access
RUN usermod -aG sudo node && echo "node ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Add custom aliases
RUN cat >> /etc/bash.bashrc <<'EOF'
alias ll="ls -alh"
alias claude-yolo="claude --dangerously-skip-permissions"
alias gemini-yolo="gemini --yolo"
EOF

# Add entrypoint script for dynamic UID/GID mapping
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /workspace

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
# run a login shell, so /etc/profile.d/*.sh will be loaded
CMD ["/bin/bash", "--login"]

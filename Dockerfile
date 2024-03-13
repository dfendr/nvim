# Use Alpine as the base image
FROM alpine:latest

# Install dependencies
RUN apk update && \
    apk add --no-cache \
    build-base cmake automake autoconf libtool pkgconf git curl wget \
    python3 py3-pip luajit gettext-dev libxml2-dev libxslt-dev zsh \
    nodejs npm bash fzf ripgrep openjdk17 gzip unzip luarocks

# Install Go
RUN wget https://go.dev/dl/go1.20.3.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.20.3.linux-amd64.tar.gz && \
    rm go1.20.3.linux-amd64.tar.gz

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Create user
ARG USERNAME=user
RUN adduser -D ${USERNAME} && \
    echo "${USERNAME}:${USERNAME}" | chpasswd

# Switch to user
USER ${USERNAME}

# Set up environment variables
ENV USERNAME=${USERNAME}
ENV EDITOR nvim
ENV MAIN_SHELL zsh
ENV SH zsh
ENV PATH="/home/${USERNAME}/.cargo/bin:/usr/local/go/bin:${PATH}"
ENV JAVA_HOME="/usr/lib/jvm/java-17-openjdk"
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Create workspace
WORKDIR /home/${USERNAME}/workspace

# Clone Neovim repository, build, and install
RUN git clone --depth 1 https://github.com/neovim/neovim.git /tmp/neovim && \
    cd /tmp/neovim && \
    make CMAKE_BUILD_TYPE=RelWithDebInfo



# Switch back to root to install
USER root
RUN cd /tmp/neovim && \
    make install && \
    rm -rf /tmp/neovim


# Install Starship
RUN sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -y

# Switch back to the user
USER ${USERNAME}

# Add Starship initialization to .zshrc
RUN echo 'eval "$(starship init zsh)"' >> /home/${USERNAME}/.zshrc

# Clone Fenvim configuration and install lazy +
RUN git clone --depth 1 https://github.com/dfendr/nvim /home/${USERNAME}/.config/nvim && \
    git clone --depth 1 --filter=blob:none --branch=stable https://github.com/folke/lazy.nvim.git /home/${USERNAME}/.local/share/nvim && \
    nvim --headless -c "let &runtimepath.=','.string(\"/home/$( whoami )/.local/share/nvim\") | quit"

# Set up the terminal
ENV TERM xterm-256color


# Set the entrypoint to pull updates from the Fenvim repository and start Neovim
ENTRYPOINT ["zsh", "-c", "git -C /home/${USERNAME}/.config/nvim pull && exec nvim \"$@\"", "--"]

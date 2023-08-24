# Use Alpine as the base image
FROM alpine:latest

# Install dependencies
RUN apk update && \
    apk add --no-cache \
    build-base cmake automake autoconf libtool pkgconf git curl wget \
    python3 py3-pip luajit gettext-dev libxml2-dev libxslt-dev zsh expat \
    libssl1.1 freetype expat-dev libxcb-dev harfbuzz \
    nodejs npm bash fzf ripgrep

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
ENV PATH="/home/${USERNAME}/.cargo/bin:/usr/local/go/bin:${PATH}"

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

# Switch back to the user
USER ${USERNAME}

# Clone Fenvim configuration
RUN git clone https://github.com/postfen/nvim /home/${USERNAME}/.config/nvim

# Set up the terminal
ENV TERM xterm-256color

# Set the entrypoint to pull updates from the Fenvim repository and start Neovim
ENTRYPOINT ["sh", "-c", "git -C /home/${USERNAME}/.config/nvim pull && exec nvim \"$@\"", "--"]

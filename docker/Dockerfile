# Neovim Docker IDE
# Multi-stage build for optimal image size

FROM ubuntu:22.04 AS base

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Install base dependencies
RUN apt-get update && apt-get install -y \
    # Core utilities
    curl \
    wget \
    git \
    unzip \
    tar \
    gzip \
    # Build essentials
    build-essential \
    # Search tools (required for Telescope)
    ripgrep \
    fd-find \
    # Clipboard support (for copy/paste in Docker)
    xclip \
    # Additional utilities
    jq \
    tree \
    htop \
    locales \
    # Cleanup
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Setup locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# ============================================
# Stage: Install Neovim
# ============================================
FROM base AS neovim-installer

WORKDIR /tmp

# Install Neovim stable version (v0.10.2 - latest stable with pre-built binaries)
# Detect architecture and download appropriate binary
RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then \
        echo "Detected ARM64 architecture, building from source..." && \
        apt-get update && apt-get install -y ninja-build gettext cmake && \
        git clone --depth 1 --branch v0.10.2 https://github.com/neovim/neovim.git && \
        cd neovim && \
        make CMAKE_BUILD_TYPE=Release && \
        make install && \
        cd .. && rm -rf neovim; \
    else \
        echo "Detected x86_64 architecture, downloading pre-built binary..." && \
        curl -Lo nvim-linux64.tar.gz https://github.com/neovim/neovim/releases/download/v0.10.2/nvim-linux64.tar.gz && \
        tar xzf nvim-linux64.tar.gz && \
        mv nvim-linux64 /opt/nvim && \
        ln -s /opt/nvim/bin/nvim /usr/local/bin/nvim && \
        rm nvim-linux64.tar.gz; \
    fi && \
    nvim --version

# ============================================
# Stage: Install Node.js (for LSP servers)
# ============================================
FROM neovim-installer AS nodejs-installer

# Install Node.js 20.x LTS
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install global npm packages for LSP and tools
RUN npm install -g \
    # TypeScript/JavaScript LSP
    typescript \
    typescript-language-server \
    # Vue LSP
    @vue/language-server \
    # ESLint
    eslint \
    # Prettier
    prettier \
    # Neovim support
    neovim

# ============================================
# Stage: Install PHP and Composer
# ============================================
FROM nodejs-installer AS php-installer

# Install PHP 8.2 with extensions (8.3 not available in Ubuntu 22.04 repos)
# Add ondrej PPA for latest PHP versions
RUN apt-get update && apt-get install -y software-properties-common \
    && add-apt-repository ppa:ondrej/php \
    && apt-get update && apt-get install -y \
    php8.2 \
    php8.2-cli \
    php8.2-common \
    php8.2-curl \
    php8.2-mbstring \
    php8.2-xml \
    php8.2-zip \
    php8.2-intl \
    php8.2-mysql \
    php8.2-pgsql \
    php8.2-sqlite3 \
    # Xdebug for debugging
    php8.2-xdebug \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Configure Xdebug for remote debugging
RUN echo "xdebug.mode=debug" >> /etc/php/8.2/cli/conf.d/20-xdebug.ini \
    && echo "xdebug.start_with_request=yes" >> /etc/php/8.2/cli/conf.d/20-xdebug.ini \
    && echo "xdebug.client_host=host.docker.internal" >> /etc/php/8.2/cli/conf.d/20-xdebug.ini \
    && echo "xdebug.client_port=9003" >> /etc/php/8.2/cli/conf.d/20-xdebug.ini

# ============================================
# Stage: Install Nerd Fonts
# ============================================
FROM php-installer AS fonts-installer

WORKDIR /tmp

# Install fontconfig for fc-cache
RUN apt-get update && apt-get install -y fontconfig \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install FiraCode Nerd Font (monospace with icons)
RUN mkdir -p /usr/share/fonts/truetype/nerd-fonts \
    && curl -fLo /tmp/FiraCode.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip \
    && unzip /tmp/FiraCode.zip -d /usr/share/fonts/truetype/nerd-fonts/ \
    && rm /tmp/FiraCode.zip \
    && fc-cache -fv

# ============================================
# Final Stage
# ============================================
FROM fonts-installer AS final

# Create non-root user for better security
ARG USER_UID=1000
ARG USER_GID=1000

RUN set -eux; \
    # Only create developer user if UID is not 0 (root)
    if [ "${USER_UID}" != "0" ]; then \
        if ! getent group ${USER_GID} > /dev/null 2>&1; then \
            groupadd -g ${USER_GID} developer; \
        fi && \
        useradd -m -u ${USER_UID} -g ${USER_GID} -s /bin/bash developer; \
    fi

# Setup working directory
WORKDIR /workspace

# Create directories for Neovim data
RUN mkdir -p /home/developer/.config/nvim \
    && mkdir -p /home/developer/.local/share/nvim/lazy \
    && mkdir -p /home/developer/.cache/nvim \
    && chown -R ${USER_UID}:${USER_GID} /home/developer \
    && chown -R ${USER_UID}:${USER_GID} /workspace

# Pre-install lazy.nvim to avoid bootstrap issues in Docker
RUN cd /tmp \
    && git clone --filter=blob:none --branch=stable \
    https://github.com/folke/lazy.nvim.git /home/developer/.local/share/nvim/lazy/lazy.nvim \
    && chown -R ${USER_UID}:${USER_GID} /home/developer/.local/share/nvim/lazy

# Switch to non-root user
USER developer

# Environment variables
ENV HOME=/home/developer
ENV XDG_CONFIG_HOME=/home/developer/.config
ENV XDG_DATA_HOME=/home/developer/.local/share
ENV XDG_CACHE_HOME=/home/developer/.cache

# Set Neovim as default editor
ENV EDITOR=nvim
ENV VISUAL=nvim

# Healthcheck - verify Neovim is working
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD nvim --version || exit 1

# Default command - start Neovim
CMD ["nvim"]

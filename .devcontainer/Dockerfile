# Devcontainer to update aurelio.net's contents.
#
# It has a working Jekyll and it's dependencies, in the specific version
# that I know the site will be properly generated.
#
# Specially crafted to be used in VS Code or GitHub Codespaces.

# Base image: Ubuntu 22.04 plus git and dev tools for shell and python.
# https://github.com/aureliojargas/devcontainer
FROM ghcr.io/aureliojargas/devcontainer

# Install the basic Ruby stack, using pinned versions to avoid surprises
# Note that Jekyll will be installed later, using `bundle install` when
# the aurelio.net repository is available (see devcontainer.json)
RUN apt update && export DEBIAN_FRONTEND=noninteractive \
    && apt --yes install --no-install-recommends \
    bundler=2.3.5-2 \
    ruby=1:3.0~exp1 \
    ruby-dev=1:3.0~exp1 \
    tidy=2:5.6.0-11build2 \
    && rm -rf /var/lib/apt/lists/*

# Setup bundler
ENV BUNDLE_PATH=/home/vscode/.local/share/gem \
    PATH=/home/vscode/.local/share/gem/ruby/3.0.0/bin:$PATH

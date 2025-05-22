FROM nvidia/cuda:12.9.0-base-ubuntu22.04

# Set bash as the default shell
ENV SHELL=/bin/bash

# Create a working directory
WORKDIR /app/

# Build with some basic utilities
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip \
    apt-utils \
    vim \
    git \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# alias python='python3'
RUN ln -s /usr/bin/python3 /usr/bin/python

# Install UV package manager
ADD https://astral.sh/uv/install.sh /uv-installer.sh
RUN sh /uv-installer.sh && rm /uv-installer.sh
ENV PATH="/root/.local/bin/:$PATH"

# build with some basic python packages
RUN uv pip install --no-cache-dir \
    --system \
    numpy \
    torch \
    torchvision \
    torchaudio  \
    jupyterlab

# start jupyter lab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--no-browser"]
EXPOSE 8888

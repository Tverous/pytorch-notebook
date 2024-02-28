FROM nvidia/cuda:12.3.2-base-ubuntu22.04

# Set bash as the default shell
ENV SHELL=/bin/bash

# Create a working directory
WORKDIR /app/

# Build with some basic utilities
RUN apt-get update && apt-get install -y \
    python3-pip \
    apt-utils \
    vim \
    git

# alias python='python3'
RUN ln -s /usr/bin/python3 /usr/bin/python

# build with some basic python packages
RUN pip install \
    numpy \
    torch \
    jupyterlab

# start jupyter lab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--no-browser"]
EXPOSE 8888

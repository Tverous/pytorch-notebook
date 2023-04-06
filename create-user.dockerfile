FROM tverous/pytorch-notebook

ARG MY_UID
ARG MY_GID
ARG USER
ARG HOME

# for prompts
ENV RED='\033[0;31m'
ENV GREEN='\033[0;32m'
ENV NC='\033[0m'
# run id -u
ENV MY_UID=${MY_UID}
# run id -g
ENV MY_GID=${MY_GID}
# your username
ENV USER=${USER}
# your home directory
ENV HOME=${HOME}

RUN test ! -z ${MY_UID} && echo ${GREEN}"MY_UID is set to ${MY_UID}"${NC} || (echo ${RED}"MY_UID is not set"${NC} && exit 1)
RUN test ! -z ${MY_GID} && echo ${GREEN}"MY_GID is set to ${MY_GID}"${NC} || (echo ${RED}"MY_GID is not set"${NC} && exit 1)
RUN test ! -z ${USER} && echo ${GREEN}"USER is set to ${USER}"${NC} || (echo ${RED}"USER is not set"${NC} && exit 1)
RUN test ! -z ${HOME} && echo ${GREEN}"HOME is set to ${HOME}"${NC} || (echo ${RED}"HOME is not set"${NC} && exit 1)

RUN unset RED && unset GREEN && unset NC

# install sudo 
RUN apt-get update && apt-get install -y \
    sudo

# add a new user with the specific user id and group id
RUN groupadd -g ${MY_GID} ${USER} \
    && useradd ${USER} -u ${MY_UID} -g ${MY_GID} -d ${HOME} -m -s /bin/bash

# for user space executables
ENV PATH="${PATH}:${HOME}/.local/bin/"

# add user to the root group
RUN usermod -aG root ${USER}

# TODO:  disable sudo password
RUN echo "%${USER}   ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers && exit

USER ${USER}
WORKDIR ${HOME}

# start jupyter lab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--no-browser"]
EXPOSE 8888

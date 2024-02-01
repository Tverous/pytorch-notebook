# Jupyter Notebook with Pytorch

[![Create and publish a Docker iamge](https://github.com/Tverous/pytorch-notebook/actions/workflows/docker-image.yml/badge.svg)](https://github.com/Tverous/pytorch-notebook/actions/workflows/docker-image.yml)

This docker image supports with jupyter, pytorch and cuda.

## Run the container

### Start the container with only CPU support:

``` sh
docker run --rm -it  \
           -p 8888:8888  \
           -e JUPYTER_TOKEN=passwd  \
           tverous/pytorch-notebook:latest
```

### Start the container with GPUs support:

``` sh
docker run --rm -it  \
           --gpus all  \
           -p 8888:8888  \
           -e JUPYTER_TOKEN=passwd  \
           tverous/pytorch-notebook:latest
```

### Start the container with volumes:

``` sh
docker run --rm -it  \
           --gpus all  \
           -p 8888:8888  \
           -e JUPYTER_TOKEN=passwd \
           -v /local_vol:/docker_vol  \
           tverous/pytorch-notebook:latest
```

## Others (Experimental)

### Build the image with non-root users

To start the container with a non-root user, you need to build a new image that includes the designated user.

``` sh
git clone https://github.com/Tverous/pytorch-notebook.git
cd pytorch-notebook/
```

Build a new image that incorporates a non-administrator user within.

*The `NOPASSWD` option is enabled for the `sudo` command in the `create-user.dockerfile` file, signifying that no password is necessary to execute the `sudo` command.*
Modify this setting if it is not desired.

``` sh
docker build --no-cache \
             -f create-user.dockerfile \
             --build-arg MY_UID="$(id -u)" \
             --build-arg MY_GID="$(id -g)" \
             --build-arg USER=demo \
             --build-arg HOME=/home/demo \
             -t tverous/pytorch-notebook:user \
             .
```

Start the container with the image you just builded.

``` sh
docker run --rm -it  \
           -p 8888:8888  \
           -e JUPYTER_TOKEN=passwd  \
           tverous/pytorch-notebook:user
```

Where the argument `MY_UID` is the user id for the created user, `MY_GID` is the group id for the created user, `USER` is the name of the created user, and `HOME` is the home directory for the created user.

Please check the file `create-user.dockerfile` for details

### Build the image with HTTPS supports

*Modify the parameters to OpenSSL and `PEM_FILE_PATH` defined in the file `https.dockerfile` for your needs*

Build a new image with HTTPS supports.

``` sh
docker build --no-cache \
             -f https.dockerfile \
             -t tverous/pytorch-notebook:https \
             .
```

Start the container with the image you just builded.

``` sh
docker run --rm -it  \
           -p 8888:8888  \
           -e JUPYTER_TOKEN=passwd  \
           tverous/pytorch-notebook:https
```

Now you can access your host with HTTPS.

### Build the image with jupyter lab extensions

Jupyter Lab supports extensions to enhance its functionality.

Check [awesome-jupyter](https://github.com/markusschanta/awesome-jupyter) for a list of awesome JupyterLab extensions and resources.

``` sh
git clone https://github.com/Tverous/pytorch-notebook.git
cd pytorch-notebook/
```

Build a new image with Jupyter Lab extensions installed.

``` sh
docker build --no-cache \
             -f jupyter-lab-extension.dockerfile \
             -t tverous/pytorch-notebook:extension \
             .
```

Start the container with the image you just builded.

``` sh
docker run --rm -it  \
           -p 8888:8888  \
           -e JUPYTER_TOKEN=passwd  \
           tverous/pytorch-notebook:extension
```

Update the file `jupter-lab-extension.dockerfile` for other extensions you would like to install.

## Launch Jupyter Notebook

When you start a notebook server with token authentication enabled (default), a token is generated to use for authentication. 

This token is logged to the terminal, so that you can copy/paste the URL into your browser:

#### If you did not specify the token before starting the container, make sure to copy/paste the token logged on the terminal

``` sh
[I 11:59:16.597 NotebookApp] The Jupyter Notebook is running at:
http://localhost:8888/?token=c8de56fa4deed24899803e93c227592aef6538f93025fe01
```

#### Make sure to update the localhost of the url to your remote server IP, if you are running the container remotely

## Detach the logged context in the tty

Press `Ctrl + p` and `Ctrl + q` to detach the tty.

## References

``` sh
docker run --rm \                       # remove the container when it exits
           -it \                        # pseudo-TTY
           -p 8888:8888 \               # port forwarding: <Host>:<Container>
           --gpus all \                 # support all gpus (docker > 19.03)
           -v /local_vol:/docker_vol \  # volume: mapping local folder to container
           -e JUPYTER_TOKEN=passwd \    # Jupyter password: passwd
           -d tverous/pytorch-notebook:latest
```

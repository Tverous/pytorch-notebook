# Jupyter Notebook with Pytorch

This docker image supports with jupyter, pytorch and cuda.

## Run the container

### Start the container with only CPU support:
```
docker run --rm -it  \
           -p 8888:8888  \
           -e JUPYTER_TOKEN=passwd  \
           tverous/pytorch-notebook:latest
```

### Start the container with GPUs support:
```
docker run --rm -it  \
           --gpus all  \
           -p 8888:8888  \
           -e JUPYTER_TOKEN=passwd  \
           tverous/pytorch-notebook:latest
```

### Start the container with volumes:
```
docker run --rm -it  \
           --gpus all  \
           -p 8888:8888  \
           -e JUPYTER_TOKEN=passwd \
           -v /local_vol:/docker_vol  \
           tverous/pytorch-notebook:latest
```

## Launch Jupyter Notebook

When you start a notebook server with token authentication enabled (default), a token is generated to use for authentication. 

This token is logged to the terminal, so that you can copy/paste the URL into your browser:

> #### If you did not specify the token before starting the container, make sure to copy/paste the token logged on the terminal

```
[I 11:59:16.597 NotebookApp] The Jupyter Notebook is running at:
http://localhost:8888/?token=c8de56fa4deed24899803e93c227592aef6538f93025fe01
```

> #### Make sure to update the localhost of the url to your remote server IP, if you are running the container remotely.

## Detach the logged context in the tty

Press `Ctrl + p` and `Ctrl + q` to detach the tty.

## References:
```
docker run --rm \                       # remove the container when it exits
           -it \                        # pseudo-TTY
           -p 8888:8888 \               # port forwarding: <Host>:<Container>
           --gpus all \                 # support all gpus (docker > 19.03)
           -v /local_vol:/docker_vol \  # volume: mapping local folder to container
           -e JUPYTER_TOKEN=passwd \    # Jupyter password: passwd
           -d tverous/pytorch-notebook:latest
```

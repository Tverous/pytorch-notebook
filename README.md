# Jupyter Lab with Pytorch

This docker image supports with jupyter, pytorch and cuda.

## Run the container

### Start a container with GPUs support:
```
docker run --rm -it --gpus all -p 8888:8888 tverous/pytorch-notebook
```

### Start a container with volumes:
```
docker run --rm -it --gpus all -p 8888:8888 -v /local_vol:/docker_vol tverous/pytorch-notebook
```

## Launch Jupyter Notebook

When you start a notebook server with token authentication enabled (default), a token is generated to use for authentication. 

This token is logged to the terminal, so that you can copy/paste the URL into your browser:
```
[I 11:59:16.597 NotebookApp] The Jupyter Notebook is running at:
http://localhost:8888/?token=c8de56fa4deed24899803e93c227592aef6538f93025fe01
```

## Detach the logged context in the tty

Press `Ctrl + p` and `Ctrl + q` to detach the tty.

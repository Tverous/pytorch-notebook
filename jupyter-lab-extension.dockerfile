FROM tverous/pytorch-notebook

# install jupyter lab extensions
RUN pip install \
    # https://github.com/mohirio/jupyterlab-horizon-theme
    jupyterlab-horizon-theme \
    # https://github.com/jupyterlab/jupyterlab-git
    jupyterlab-git \
    # https://github.com/jupyter-lsp/jupyterlab-lsp
    jupyterlab-lsp \
    'python-lsp-server[all]'

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--no-browser"]
EXPOSE 8888

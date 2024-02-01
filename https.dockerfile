FROM tverous/pytorch-notebook

RUN jupyter-lab --generate-config

RUN openssl req -new                                              \
                -newkey=rsa:2048                                  \
                -days=365                                         \
                -nodes -x509                                      \
                -subj=/C=XX/ST=XX/L=XX/O=generated/CN=generated   \
                -keyout=notebook.pem -out=notebook.pem

RUN sed -i '/c.ServerApp.certfile /c\c.ServerApp.certfile = "/app/notebook.pem"' ~/.jupyter/jupyter_lab_config.py 

# start jupyter lab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--no-browser"]
EXPOSE 8888

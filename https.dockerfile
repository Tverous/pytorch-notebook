FROM tverous/pytorch-notebook

RUN jupyter-lab --generate-config

ENV PEM_FILE_PATH=/etc/ssl/certs/jupyter.pem
RUN openssl req -new                                              \
                -newkey=rsa:4096                                  \
                -days=365                                         \
                -nodes -x509                                      \
                -subj=/C=XX/ST=XX/L=XX/O=generated/CN=generated   \
                -keyout=${PEM_FILE_PATH} -out=${PEM_FILE_PATH}

# RUN echo "c.ServerApp.certfile = '$PEM_FILE_PATH'" >> ~/.jupyter/jupyter_lab_config.py
RUN sed -i "/c.ServerApp.certfile /c\c.ServerApp.certfile = '$PEM_FILE_PATH'" \
            ~/.jupyter/jupyter_lab_config.py 

# start jupyter lab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--no-browser"]
EXPOSE 8888

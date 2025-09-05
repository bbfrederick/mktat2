FROM fredericklab/neurodockerfsl:latest
RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends \
           git \
    && rm -rf /var/lib/apt/lists/* 

# install AWS tools
RUN pip install numpy s3fs awscli dxpy

# Create a shared $HOME directory
RUN useradd \
    --create-home \
    --shell /bin/bash \
    --groups users \
    --home /home/neurodocker \
    neurodocker
RUN chown -R neurodocker /neurodocker

WORKDIR /home/neurodocker
ENV HOME="/home/neurodocker"

# set to non-root user
USER neurodocker
RUN git clone https://github.com/lncd/lncdtools

COPY ./3dBrickStat /home/neurodocker/lncdtools
RUN chmod a+x /home/neurodocker/lncdtools

RUN echo 'export PATH=${PATH}:/home/neurodocker/lncdtools' >> /home/neurodocker/.bashrc

ENTRYPOINT ["/neurodocker/startup.sh"]


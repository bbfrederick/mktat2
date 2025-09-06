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

RUN echo 'export PATH=/home/neurodocker/lncdtools:/opt/afni-latest:/opt/fsl-6.0.7.8:${PATH}' >> /home/neurodocker/.bashrc

ENTRYPOINT ["/bin/bash"]

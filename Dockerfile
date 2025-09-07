FROM fredericklab/neurodockerbase:latest
RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends \
           git \
    && rm -rf /var/lib/apt/lists/* 

# install AWS tools
RUN pip install s3fs awscli

# install extra python bits
RUN pip install dxpy numpy pandas

# install tat2 software
RUN cd /opt \
    && git clone https://github.com/lncd/lncdtools
ENV PATH="/opt/lncdtools:/opt/afni-latest:$PATH"

# put a copy of 3dBrickStat in the lncdtools directory
RUN cp /opt/afni-latest/3dBrickStat /opt/lncdtools

# fix the root path
RUN echo 'export PATH=/opt/lncdtools:/opt/afni-latest:${PATH}' >> /root/.bashrc

## Create a shared $HOME directory
#RUN useradd \
#    --create-home \
#    --shell /bin/bash \
#    --groups users \
#    --home /home/neurodocker \
#    neurodocker
#RUN chown -R neurodocker /neurodocker
#RUN cp /root/.bashrc /home/neurodocker.bashrc

#WORKDIR /home/neurodocker
#ENV HOME="/home/neurodocker"

# set to non-root user
#USER neurodocker

#RUN echo 'export PATH=/home/neurodocker/lncdtools:/opt/afni-latest:/opt/fsl-6.0.7.8:${PATH}' >> /home/neurodocker/.bashrc
#RUN echo 'export PATH=/opt/lncdtools:/opt/afni-latest:/opt/fsl-6.0.7.8:${PATH}' >> /home/neurodocker/.bashrc

ENTRYPOINT ["/neurodocker/startup.sh"]

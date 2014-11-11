FROM phusion/baseimage:0.9.15
MAINTAINER Kenny Do <kedo@ocf.berkeley.edu>
EXPOSE 6697

# Disable the SSH server installed by phusion by default
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y build-essential git libcurl4-openssl-dev

RUN useradd --uid 1001 -m znc-user

# Download and install znc
RUN cd $HOME && \
    curl -o znc.tar.gz http://znc.in/releases/znc-1.4.tar.gz && \
    tar -zxf znc.tar.gz

RUN cd $HOME/znc-1.4 && \
    ./configure && \
    make && \
    make install

# Download and install the znc-push module
RUN cd $HOME && \
    git clone https://github.com/jreese/znc-push.git && \
    cd $HOME/znc-push && \
    znc-buildmod push.cpp

# Create the runit service for znc
RUN mkdir /etc/service/znc
ADD znc.sh /etc/service/znc/run

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]


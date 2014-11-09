FROM phusion/baseimage:0.9.15
MAINTAINER Kenny Do <kedo@ocf.berkeley.edu>
EXPOSE 6697

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y build-essential git libcurl4-openssl-dev

RUN useradd -m znc-user
RUN mkdir /home/znc-user/.znc && \
    mkdir /home/znc-user/.znc/configs && \
    mkdir /home/znc-user/.znc/modules && \
    chown znc-user:znc-user -R /home/znc-user/.znc

# Disable the SSH server installed by phusion by default
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

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
    znc-buildmod push.cpp && \
    find ~znc-user && \
    cp push.so ~znc-user/.znc/modules/push.so && \
    chown znc-user:znc-user /home/znc-user/.znc/modules/push.so

# Create the runit service for znc
RUN mkdir /etc/service/znc
ADD znc.sh /etc/service/znc/run

ADD znc.conf /home/znc-user/.znc/configs/znc.conf
RUN chown znc-user:znc-user /home/znc-user/.znc/configs/znc.conf

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]


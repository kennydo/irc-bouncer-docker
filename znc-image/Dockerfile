FROM phusion/baseimage:0.9.16
MAINTAINER Kenny Do <chinesedewey@gmail.com>
EXPOSE 6697

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y build-essential git libcurl4-openssl-dev

RUN useradd --uid 1000 -m znc-user

# Download and install znc
RUN cd /tmp && \
    curl -o znc.tar.gz http://znc.in/releases/znc-1.6.0.tar.gz && \
    tar -zxf znc.tar.gz

RUN cd /tmp/znc-1.6.0 && \
    ./configure && \
    make && \
    make install

# Download and install the znc-push module
RUN cd /tmp && \
    git clone --depth 1 https://github.com/jreese/znc-push.git && \
    cd /tmp/znc-push && \
    znc-buildmod push.cpp

# Copy the compiled push.so to a directory where ZNC looks for modules
RUN cp /tmp/znc-push/push.so /usr/local/lib/znc

# Create the runit service for znc
RUN mkdir /etc/service/znc
ADD znc.sh /etc/service/znc/run

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]


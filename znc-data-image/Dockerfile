FROM busybox:buildroot-2014.02
MAINTAINER Kenny Do <kedo@ocf.berkeley.edu>

# Add a new user without prompting for password
RUN adduser -u 1001 -D znc-user

RUN mkdir /home/znc-user/.znc && \
    mkdir /home/znc-user/.znc/configs && \
    mkdir /home/znc-user/.znc/modules && \
    chown znc-user:znc-user -R /home/znc-user/.znc

# Add the znc.conf from the local directory
ADD znc.conf /home/znc-user/.znc/configs/znc.conf
ADD znc.pem /home/znc-user/.znc/znc.pem

# Symlink the push.so compiled from znc-image
RUN ln -s /opt/znc/modules/push.so /home/znc-user/.znc/modules/push.so

RUN chown znc-user:znc-user -R /home/znc-user/.znc

VOLUME /home/znc-user/.znc

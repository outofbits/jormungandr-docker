FROM centos:8

# Create Lovelace User
RUN groupadd cardano --gid 1024
RUN adduser lovelace -u 1023 --no-create-home
RUN usermod -a -G cardano lovelace

# Make Lovelace owner of data & conf
RUN mkdir -p /data && chown -R lovelace:cardano /data
RUN mkdir -p /conf && chown -R lovelace:cardano /conf

RUN dnf install -y glibc glibc-devel

# Copy entrypoint
COPY docker-entrypoint.sh .
RUN chmod a+x docker-entrypoint.sh

# Install
RUN mkdir -p /opt/jormungandr/bin/ 

## Guardian
ADD https://github.com/sobitada/guardian/releases/download/v1.2/guardian-1.2-linux-amd64.tar.gz .
RUN tar xzf guardian-1.2-linux-amd64.tar.gz && rm -f guardian-1.2-linux-amd64.tar.gz
RUN chmod a+x guardian
RUN mv guardian /opt/jormungandr/bin/

## Jormungandr (compile)
COPY binaries/jormungandr jormungandr
RUN chmod a+x jormungandr
RUN mv jormungandr /opt/jormungandr/bin/

# Choose Lovelace as user to run jormungandr
USER lovelace

ENTRYPOINT ["./docker-entrypoint.sh"]
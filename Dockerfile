FROM centos:8

# Create Lovelace User
RUN groupadd cardano --gid 1024
RUN adduser lovelace -u 1023 --no-create-home
RUN usermod -a -G cardano lovelace

# Make Lovelace owner of data & conf
RUN mkdir -p /data && chown -R lovelace:cardano /data
RUN mkdir -p /conf && chown -R lovelace:cardano /conf

# Copy entrypoint
COPY docker-entrypoint.sh .
RUN chmod a+x docker-entrypoint.sh

# Documentation
ENV DFILE_VERSION "1.2"

LABEL maintainer="Kevin Haller <keivn.haller@outofbits.com>"
LABEL version="${DFILE_VERSION}-jormungandr${JOR_VERSION}"
LABEL description="Aspiring blockchain node for Cardano (implemented in Rust)."

# Install
RUN mkdir -p /opt/jormungandr/bin/

ADD https://github.com/sobitada/guardian/releases/download/v1.0/guardian-1.0-linux-amd64.tar.gz .
RUN tar xzf guardian-1.0-linux-amd64.tar.gz && rm -f guardian-1.0-linux-amd64.tar.gz
RUN chmod a+x guardian
RUN mv guardian /opt/jormungandr/bin/

ARG JOR_VERSION

ADD "https://github.com/input-output-hk/jormungandr/releases/download/v${JOR_VERSION}/jormungandr-v${JOR_VERSION}-x86_64-unknown-linux-gnu.tar.gz" ./
RUN tar zxf jormungandr-v${JOR_VERSION}-x86_64-unknown-linux-gnu.tar.gz && rm -f jormungandr-v${JOR_VERSION}-x86_64-unknown-linux-gnu.tar.gz
RUN chmod a+x jormungandr
RUN chmod a+x jcli

RUN mv jormungandr /opt/jormungandr/bin/
RUN mv jcli /opt/jormungandr/bin/

# Choose Lovelace as user to run jormungandr
USER lovelace

ENTRYPOINT ["./docker-entrypoint.sh"]
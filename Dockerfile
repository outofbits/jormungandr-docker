FROM centos:8

ARG JOR_VERSION
ARG DFILE_VERSION

LABEL maintainer="Kevin Haller <keivn.haller@outofbits.com>"
LABEL version="${DFILE_VERSION}-jormungandr${JOR_VERSION}"
LABEL description="Aspiring blockchain node for Cardano (implemented in Rust)."

# Create Lovelace User
RUN groupadd cardano --gid 1024
RUN adduser lovelace -u 1023 --no-create-home
RUN usermod -a -G cardano lovelace

# Install
ADD "https://github.com/input-output-hk/jormungandr/releases/download/v${JOR_VERSION}/jormungandr-v${JOR_VERSION}-x86_64-unknown-linux-gnu.tar.gz" ./
RUN tar zxf jormungandr-v${JOR_VERSION}-x86_64-unknown-linux-gnu.tar.gz && rm jormungandr-v${JOR_VERSION}-x86_64-unknown-linux-gnu.tar.gz
RUN chmod +x jormungandr
RUN chmod +x jcli

RUN mkdir -p /opt/jormungandr/bin/
RUN mv jormungandr /opt/jormungandr/bin/
RUN mv jcli /opt/jormungandr/bin/

# Make Lovelace owner of data & conf
RUN mkdir -p /data && chown -R lovelace:cardano /data
RUN mkdir -p /conf && chown -R lovelace:cardano /conf

# Choose Lovelace as user to run jormungandr
USER lovelace

ENTRYPOINT ["/opt/jormungandr/bin/jormungandr"]
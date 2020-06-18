FROM centos:8

# Copy entrypoint
COPY docker-entrypoint.sh .
RUN chmod a+x docker-entrypoint.sh

# Documentation
ENV DFILE_VERSION "1.3"

LABEL maintainer="Kevin Haller <keivn.haller@outofbits.com>"
LABEL version="${DFILE_VERSION}-jormungandr${JOR_VERSION}"
LABEL description="Aspiring blockchain node for Cardano (implemented in Rust)."

# Install
RUN mkdir -p /opt/jormungandr/bin/

ADD https://github.com/sobitada/guardian/releases/download/v1.2/guardian-1.2-linux-amd64.tar.gz .
RUN tar xzf guardian-1.2-linux-amd64.tar.gz && rm -f guardian-1.2-linux-amd64.tar.gz
RUN chmod a+x guardian
RUN mv guardian /opt/jormungandr/bin/

ARG JOR_VERSION

ADD "https://github.com/input-output-hk/jormungandr/releases/download/v${JOR_VERSION}/jormungandr-v${JOR_VERSION}-x86_64-unknown-linux-gnu-generic.tar.gz" ./
RUN tar zxf jormungandr-v${JOR_VERSION}-x86_64-unknown-linux-gnu-generic.tar.gz && rm -f jormungandr-v${JOR_VERSION}-x86_64-unknown-linux-gnu-generic.tar.gz
RUN chmod a+x {jormungandr,jcli}

RUN mv {jormungandr,jcli} /opt/jormungandr/bin/

ENTRYPOINT ["./docker-entrypoint.sh"]
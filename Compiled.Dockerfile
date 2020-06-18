# Builder Image
FROM centos:8 AS builder

RUN dnf install -y gcc git openssl-devel

ADD https://sh.rustup.rs sh.rustup.rs
RUN sh sh.rustup.rs -y

ARG JOR_VERSION
ARG JOR_REPOSITORY
ARG JOR_BRANCH

RUN git clone -b ${JOR_BRANCH} --recurse-submodules ${JOR_REPOSITORY} jormungandr
WORKDIR jormungandr
RUN git fetch && git fetch --tags
RUN git checkout "${JOR_VERSION}"
RUN git submodule update
RUN $HOME/.cargo/bin/cargo install --locked --path jormungandr
RUN $HOME/.cargo/bin/cargo install --locked --path jcli

RUN mkdir -p /binaries/ && mv $HOME/.cargo/bin/{jormungandr,jcli} /binaries/

# Main Image
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

# Install
RUN mkdir -p /opt/jormungandr/bin/ 

## Guardian
ADD https://github.com/sobitada/guardian/releases/download/v1.2/guardian-1.2-linux-amd64.tar.gz .
RUN tar xzf guardian-1.2-linux-amd64.tar.gz && rm -f guardian-1.2-linux-amd64.tar.gz
RUN chmod a+x guardian
RUN mv guardian /opt/jormungandr/bin/

ENV CFILE_VERSION "1.0c"

LABEL maintainer="Kevin Haller <keivn.haller@outofbits.com>"
LABEL version="${CFILE_VERSION}-jormungandr.${JOR_VERSION}"
LABEL description="Aspiring blockchain node for Cardano (implemented in Rust)."

## Jormungandr (compiled)
COPY --from=builder /binaries/jormungandr /opt/jormungandr/bin/jormungandr
COPY --from=builder /binaries/jcli /opt/jormungandr/bin/jcli
RUN chmod a+x /opt/jormungandr/bin/{jormungandr,jcli} 

# Choose Lovelace as user to run jormungandr
USER lovelace

ENTRYPOINT ["./docker-entrypoint.sh"]
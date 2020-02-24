FROM centos:8

RUN mkdir /binaries

RUN dnf install -y gcc git curl

RUN curl https://sh.rustup.rs > sh.rustup.rs && sh sh.rustup.rs -y

# Copy entrypoint
COPY compile.sh .
RUN chmod a+x compile.sh

ENTRYPOINT ["./compile.sh"]
# Jörmungandr Docker Image
Jormungandr is a node implementation, written in rust, with the initial aim to support the Ouroboros type of consensus protocol.

A node is a participant of a blockchain network, continuously making, sending, receiving, and validating blocks. Each node is responsible to make sure that all the rules of the protocol are followed.

The guide for Jörmungandr can be found [here](https://input-output-hk.github.io/jormungandr/introduction.html).

**Mythology:** Jörmungandr refers to the Midgard Serpent in Norse mythology. It is a hint to Ouroboros, the Ancient Egyptian serpent, who eat its own tail, as well as the IOHK paper on proof of stake.

## Build
The Docker image expects the version of jormungandr as build argument as well as the dockerfile version.

```
docker build . --build-arg JOR_VERSION="0.8.3"
```

This repository includes a Makefile with preconfigured options, and with the following command the most recent version can be build.

```
make latest
```

## Run
The image requires that the genesis block hash is passed as an environment variable as well as the path to the node configuration. Optionally, the
path to the node secret configuration can be passed as an environment variable, if it shall start as a stake pool/leader candidate.

```
docker run -v chain-data:/data -v conf:/conf -e GENESIS_BLOCK_HASH="9409af111b04896c756c1cee3b7f9bae8b9ed1843c9e0a5f07d92ab9b62f6f78" -e NODE_CONFIG_PATH="/conf/node-config.yaml" adalove/jormungandr:1.1-jormungandr0.8.3
```

**Environment Variables:**

| ENVIRONMENT NAME  | Required? | Jormungandr Parameter Name |
| ------------- | --------- | ------------------------------ |
| GENESIS_BLOCK_HASH| Yes | --genesis-block-hash |
| NODE_CONFIG_PATH  | Yes | --config |
| NODE_SECRET_PATH  | No | --secret |

### Where to store the data?
There are several ways to store data used by applications that run in Docker containers. We encourage users of our images to familiarize themselves with the options available, including: 

* Let Docker manage the storage of your database data by writing the database files to disk on the host system using its own internal volume management. This is the default and is easy and fairly transparent to the user. The downside is that the files may be hard to locate for tools and applications that run directly on the host system, i.e. outside containers.

* Create a data directory on the host system (outside the container) and mount this to a directory visible from inside the container. This places the database files in a known location on the host system, and makes it easy for tools and applications on the host system to access the files. The downside is that the user needs to make sure that the directory exists and that e.g. directory permissions and other security mechanisms on the host system are set up correctly.

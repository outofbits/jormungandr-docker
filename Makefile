DFILE_VERSION=1.2
C_DFILE_VERSION=1.0c

HASH="ed9f7550156fd118eedd1ba4bcd3e809bd17191f"
JOR_HASH_PREFIX="ed9f755"

latest: 0.8.11

0.8.11:
	docker build --build-arg JOR_VERSION="0.8.11" -t "adalove/jormungandr:${DFILE_VERSION}-jormungandr0.8.11" .

0.8.10-2:
	docker build --build-arg JOR_VERSION="0.8.10-2" -t "adalove/jormungandr:${DFILE_VERSION}-jormungandr0.8.10-2" .

0.8.9:
	docker build --build-arg JOR_VERSION="0.8.9" -t "adalove/jormungandr:${DFILE_VERSION}-jormungandr0.8.9" .

0.8.8:
	docker build --build-arg JOR_VERSION="0.8.8" -t "adalove/jormungandr:${DFILE_VERSION}-jormungandr0.8.8" .

0.8.7:
	docker build --build-arg JOR_VERSION="0.8.7" -t "adalove/jormungandr:${DFILE_VERSION}-jormungandr0.8.7" .

0.8.6:
	docker build --build-arg JOR_VERSION="0.8.6" -t "adalove/jormungandr:${DFILE_VERSION}-jormungandr0.8.6" .

0.8.5:
	docker build --build-arg JOR_VERSION="0.8.5" -t "adalove/jormungandr:${DFILE_VERSION}-jormungandr0.8.5" .

0.8.4:
	docker build --build-arg JOR_VERSION="0.8.4" -t "adalove/jormungandr:${DFILE_VERSION}-jormungandr0.8.4" .

0.8.3:
	docker build --build-arg JOR_VERSION="0.8.3" -t "adalove/jormungandr:${DFILE_VERSION}-jormungandr0.8.3" .

0.7.5:
	docker build --build-arg JOR_VERSION="0.7.5" -t "adalove/jormungandr:${DFILE_VERSION}-jormungandr0.7.5" .

compiler:
	docker build -f Compiler.Dockerfile -t "adalove/jormungandr-compiler" . --no-cache

compile:
	rm -rf ./binaries
	docker run -v "$(PWD)/binaries:/binaries" -e GIT_REPO="https://github.com/input-output-hk/jormungandr" -e GIT_BRANCH="master" -e REV_HASH=${HASH} adalove/jormungandr-compiler:latest
	docker build -f Compiled.Binaries.Dockerfile -t "adalove/jormungandr:${C_DFILE_VERSION}-jormungandr.${JOR_HASH_PREFIX}" .

cartel:
	rm -rf ./binaries
	docker run -v "$(PWD)/binaries:/binaries" -e GIT_REPO="https://github.com/michaeljfazio/jormungandr" -e GIT_BRANCH="cartel-v0.8.9" adalove/jormungandr-compiler:latest
	docker build -f Compiled.Binaries.Dockerfile -t "adalove/jormungandr:${C_DFILE_VERSION}-jormungandr.cartel" .
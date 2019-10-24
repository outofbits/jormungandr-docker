DFILE_VERSION=1.0
JOR_VERSION=0.7.0-rc1

build:
	docker build --build-arg JOR_VERSION=${JOR_VERSION} --build-arg DFILE_VERSION=${DFILE_VERSION} -t "adalove/jormungandr:${DFILE_VERSION}-jormungandr${JOR_VERSION}" .

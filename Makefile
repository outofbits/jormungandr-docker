DFILE_VERSION=1.1

latest: 0.8.3

0.8.3:
	docker build --build-arg JOR_VERSION="0.8.3" -t "adalove/jormungandr:${DFILE_VERSION}-jormungandr0.8.3" .

0.7.5:
	docker build --build-arg JOR_VERSION="0.7.5" -t "adalove/jormungandr:${DFILE_VERSION}-jormungandr0.7.5" .
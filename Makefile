DFILE_VERSION=1.2

latest: 0.8.5

0.8.5:
	docker build --build-arg JOR_VERSION="0.8.5" -t "adalove/jormungandr:${DFILE_VERSION}-jormungandr0.8.5" .

0.8.5-alpha3:
	docker build --build-arg JOR_VERSION="0.8.5-alpha3" -t "adalove/jormungandr:${DFILE_VERSION}-jormungandr0.8.5-alpha3" .

0.8.5-alpha2:
	docker build --build-arg JOR_VERSION="0.8.5-alpha2" -t "adalove/jormungandr:${DFILE_VERSION}-jormungandr0.8.5-alpha2" .

0.8.5-alpha1:
	docker build --build-arg JOR_VERSION="0.8.5-alpha1" -t "adalove/jormungandr:${DFILE_VERSION}-jormungandr0.8.5-alpha1" .

0.8.4:
	docker build --build-arg JOR_VERSION="0.8.4" -t "adalove/jormungandr:${DFILE_VERSION}-jormungandr0.8.4" .

0.8.3:
	docker build --build-arg JOR_VERSION="0.8.3" -t "adalove/jormungandr:${DFILE_VERSION}-jormungandr0.8.3" .

0.7.5:
	docker build --build-arg JOR_VERSION="0.7.5" -t "adalove/jormungandr:${DFILE_VERSION}-jormungandr0.7.5" .

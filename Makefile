DFILE_VERSION=1.2
C_DFILE_VERSION=1.0c

LATEST_JOR_VERSION=0.8.13
LATEST_JOR_CARTEL_VERSION=0.8.9-stable-alpha6

latest: 0.8.13

0.8.13:
	docker build --build-arg JOR_VERSION="0.8.13" -t "adalove/jormungandr:${DFILE_VERSION}-jormungandr0.8.13" .

0.8.12:
	docker build --build-arg JOR_VERSION="0.8.12" -t "adalove/jormungandr:${DFILE_VERSION}-jormungandr0.8.12" .

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

compile:
	docker build -f Compiled.Dockerfile --build-arg JOR_VERSION="v${LATEST_JOR_VERSION}" \
	    --build-arg JOR_REPOSITORY="https://github.com/input-output-hk/jormungandr" \
		--build-arg  JOR_BRANCH="master" \
		-t "adalove/jormungandr:${C_DFILE_VERSION}-jormungandr${LATEST_JOR_VERSION}" .

cartel-compile:
	docker build -f Compiled.Dockerfile --build-arg JOR_VERSION=${LATEST_JOR_CARTEL_VERSION} \
	    --build-arg JOR_REPOSITORY="https://github.com/michaeljfazio/jormungandr" \
		--build-arg  JOR_BRANCH="cartel-v0.8.9" \
		-t "adalove/jormungandr:${C_DFILE_VERSION}-jormungandr.cartel${LATEST_JOR_CARTEL_VERSION}" .
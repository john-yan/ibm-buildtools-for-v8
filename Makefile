
GN_VERSION=`buildtools/gn --version`

all: build-and-upload-gn

build-images:
	docker build -t buildtools .

build-and-update-gn: build-images
	docker run --rm -v $(PWD)/buildtools:/buildtools buildtools bash -x /srcdir/script.sh

upload-gn:
	git ci buildtools/gn -m "GN: Update to $(GN_VERSION)"

build-and-upload-gn: build-and-update-gn
	git ci buildtools/gn -m "GN: Update to $(GN_VERSION)"

run: build-images
	docker run --rm -it -v $(PWD)/buildtools:/buildtools buildtools bash || true

.PHONY: build-images build-and-update-gn upload-gn build-and-upload-gn run


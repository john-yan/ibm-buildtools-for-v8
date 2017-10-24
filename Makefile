
ARCH := $(shell uname -m | tr '[:upper:]' '[:lower:]')

all: build-and-upload-gn

build-images:
	docker build -t buildtools .

build-and-update-gn: build-images
	docker run --rm -v $(PWD)/buildtools-$(ARCH):/buildtools buildtools bash -x /srcdir/script.sh

upload-gn:
	git ci buildtools-$(ARCH)/gn -m "GN: Update $(ARCH) gn to $(shell buildtools-$(ARCH)/gn --version)"

build-and-upload-gn: build-and-update-gn
	git ci buildtools-$(ARCH)/gn -m "GN: Update $(ARCH) gn to $(shell buildtools-$(ARCH)/gn --version)"

run: build-images
	docker run --rm -it -v $(PWD)/buildtools-$(ARCH):/buildtools -v /sandbox/johnyan:/sandbox buildtools bash || true

.PHONY: build-images build-and-update-gn upload-gn build-and-upload-gn run


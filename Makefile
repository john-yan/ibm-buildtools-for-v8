
ARCH := $(shell uname -m | tr '[:upper:]' '[:lower:]')

all: build-and-upload-gn

build-images:
	docker build -t buildtools .

build-and-update-gn:
	docker run --rm -v "$(PWD)/buildtools-$(ARCH):/buildtools" buildtools bash -x /srcdir/script.sh

upload-gn:
	git commit buildtools-$(ARCH)/gn -m "GN: Update $(ARCH) gn to $(shell buildtools-$(ARCH)/gn --version)"

build-and-upload-gn: build-and-update-gn
	git commit buildtools-$(ARCH)/gn -m "GN: Update $(ARCH) gn to $(shell buildtools-$(ARCH)/gn --version)"

run:
	docker run --rm -it -v "$(PWD)/buildtools-$(ARCH):/buildtools" buildtools bash || true

.PHONY: build-images build-and-update-gn upload-gn build-and-upload-gn run



build-images:
	docker build -t buildtools .

build-and-update-gn: build-images
	docker run --rm -v $(PWD)/buildtools:/buildtools buildtools bash -x /srcdir/script.sh

run: build-images
	docker run --rm -it -v $(PWD)/buildtools:/buildtools -v /sandbox/johnyan/buildtools/src:/src buildtools bash || true

.PHONY: build-images build-and-update-gn run



build-images:
	docker build -t buildtools .

run: build-images
	docker run --rm -it -v $(PWD)/buildtools:/buildtools -v /sandbox/johnyan/buildtools/src:/src buildtools bash || true

.PHONY: build-images run


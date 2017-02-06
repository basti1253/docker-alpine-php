CONTAINER = "basti1253-alpine-php"
IMG = "basti1253/alpine-php"

.PHONY: build clean

all: build

rebuild: clean build

build:
	@@docker build -t ${IMG}:latest ${PWD};

clean:
	-docker rm -vf ${CONTAINER}
	-docker rmi ${IMG}:latest

start:
	@@docker attach --sig-proxy=false ${IMG};

run:
	@@docker run \
		-p 9000:9000 \
		-i \
		--name="${CONTAINER}" \
		-d \
		-t ${IMG};

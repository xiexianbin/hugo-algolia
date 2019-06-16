.PHONY: all test clean build build-linux

GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
BINARY_NAME=hugo-lalgolia

all: clean test build
test:
	$(GOTEST) -v ./...
clean:
	$(GOCLEAN)
	rm -f bin/$(BINARY_NAME)
build:
	$(GOBUILD) -o bin/$(BINARY_NAME) -v

build-linux:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 $(GOBUILD) -o bin/$(BINARY_UNIX) -v

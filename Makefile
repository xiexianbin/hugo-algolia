.PHONY: all test clean build build-linux build-mac build-windows

GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
BINARY_NAME=hugo-lalgolia
BINARY_LINUX=hugo-lalgolia-linux
BINARY_MAC=hugo-lalgolia-mac
BINARY_WIN=hugo-lalgolia-win

all: clean test build build-linux build-mac build-windows
test:
	$(GOTEST) -v ./...
clean:
	$(GOCLEAN)
	rm -f bin/$(BINARY_NAME)
build:
	$(GOBUILD) -o bin/$(BINARY_NAME) -v

build-linux:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 $(GOBUILD) -o bin/$(BINARY_LINUX) -v
build-mac:
	CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 $(GOBUILD) -o bin/$(BINARY_MAC) -v
build-windows:
	CGO_ENABLED=0 GOOS=windows GOARCH=amd64 $(GOBUILD) -o bin/$(BINARY_WIN) -v

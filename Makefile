VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux

TARGETARCH ?= $(shell dpkg --print-architecture)

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

build:
	CGO_ENABLED=0 go build -v -o go_bot -ldflags "-X=github.com/ddidyk23/go_bot/cmd.appVersion=${VERSION}"

linux-amd64:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -v -o go_bot -ldflags "-X=github.com/ddidyk23/go_bot/cmd.appVersion=${VERSION}"

linux-arm64:
	CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -v -o go_bot -ldflags "-X=github.com/ddidyk23/go_bot/cmd.appVersion=${VERSION}"

windows:
	CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -v -o go_bot -ldflags "-X=github.com/ddidyk23/go_bot/cmd.appVersion=${VERSION}"

macos:
	CGO_ENABLED=0 GOOS=darwin GOARCH=arm64 go build -v -o go_bot -ldflags "-X=github.com/ddidyk23/go_bot/cmd.appVersion=${VERSION}"

	CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -v -o go_bot -ldflags "-X=github.com/ddidyk23/go_bot/cmd.appVersion=${VERSION}"

clean:
	rm -rf go_bot
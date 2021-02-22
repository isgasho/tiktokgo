# cannot use relative path in GOROOT, otherwise 6g not found. For example,
#   export GOROOT=../go  (=> 6g not found)
# it is also not allowed to use relative path in GOPATH
ifndef GITHUB_ACTIONS
	export GOROOT=$(realpath ../go)
	export GOPATH=$(realpath .)
	export PATH := $(GOROOT)/bin:$(GOPATH)/bin:$(PATH)
	#export GOCACHE=off
endif
GO_VERSION=1.16

ALL_GO_SOURCES=$(shell /bin/sh -c "find *.go | grep -v _test.go")

default: userinfo

userinfo: fmt
	@echo "\033[92mTest getting __NEXT_DATA__ in script tag ...\033[0m"
	@go test -v $(ALL_GO_SOURCES) userpage_test.go

test: fmt
	@echo "\033[92mTest ...\033[0m"
	@go test -v

fmt:
	@echo "\033[92mGo fmt source code...\033[0m"
	@go fmt *.go

download_go:
	@echo "\033[92mDownloading and Installing Go ...\033[0m"
	@wget https://golang.org/dl/go$(GO_VERSION).linux-amd64.tar.gz
	@tar -xvzf go$(GO_VERSION).linux-amd64.tar.gz
	@rm go$(GO_VERSION).linux-amd64.tar.gz
